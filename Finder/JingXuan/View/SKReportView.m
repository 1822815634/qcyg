//
//  SKReportView.m
//  Stockallocation
//
//  Created by wuyou on 2019/7/24.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKReportView.h"

@implementation SKReportView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"333333" andAlpha:0.5];
        [self makeSubView];
    }
    return self;
}

- (void)makeSubView {
    UIView *bottomBackView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight -kSecrityHeight - 110 , kScreenWidth, 110)];
    bottomBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomBackView];
    
    NSArray *imageArray = @[@"report",@"closeNews",@"close"];
    NSArray *titleArray = @[@"举报",@"屏蔽此条动态",@"屏蔽他的动态"];
    for (int i = 0; i < imageArray.count; i++) {
        UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancleBtn.frame = CGRectMake(i*kScreenWidth/3, 0, kScreenWidth/imageArray.count, 110);
        [cancleBtn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [cancleBtn addTarget:self action:@selector(cancleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cancleBtn.tag = i;
        [bottomBackView addSubview:cancleBtn];
    
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/3*i, 110 - 20, kScreenWidth/3, 20)];
        label.font = [UIFont systemFontOfSize:15];
        label.text = titleArray[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithHexString:@"333333" andAlpha:1];
        [bottomBackView addSubview:label];
    }
}

- (void)cancleBtnClick:(UIButton *)btn {
    NSString *title ;
    switch (btn.tag) {
        case 0: {
            title = @"举报成功";
        }
            break;
        case 1: {
            title = @"屏蔽成功";
        }
            break;
        case 2: {
            title = @"屏蔽成功";
        }
            break;
        default:
            break;
    }
    [WSYToastView toastWithString:title];
//    [NSThread sleepForTimeInterval:1];
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

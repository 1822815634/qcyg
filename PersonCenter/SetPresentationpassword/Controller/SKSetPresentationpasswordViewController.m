//
//  SKSetPresentationpasswordViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/23.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKSetPresentationpasswordViewController.h"
#import "SYPasswordView.h"
@interface SKSetPresentationpasswordViewController ()<SYPasswordViewDelegate>

@property (nonatomic, weak) SYPasswordView *pasView;

@property (nonatomic , weak)UILabel *tishiLab;

@end

@implementation SKSetPresentationpasswordViewController
- (UILabel *)tishiLab
{
    if (!_tishiLab) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(15,90,kScreenWidth - 30,20);
        label.text = @"设置6位数字提现密码";
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        label.textColor = [UIColor colorWithRed:68/255.0 green:64/255.0 blue:62/255.0 alpha:1];
        label.textAlignment = NSTextAlignmentCenter;
        label.alpha = 1;
        label.numberOfLines = 0;
        [self.view addSubview:label];
        _tishiLab = label;
    }
    return _tishiLab;
}
- (SYPasswordView *)pasView
{
    if (!_pasView) {
        SYPasswordView *psView = [[SYPasswordView alloc] initWithFrame:CGRectMake(15, 131, kScreenWidth - 30, 45)];
        psView.Vdelegate = self;
        [self.view addSubview:psView];
        _pasView = psView;
    }
    return _pasView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self tishiLab];
    [self pasView];
    // Do any additional setup after loading the view.
}
- (void)passwordSure:(NSString *)password
{
    NSLog(@"我的密码 %@",password);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

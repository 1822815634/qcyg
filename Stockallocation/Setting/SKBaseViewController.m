//
//  SKBaseViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/19.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKBaseViewController.h"

@interface SKBaseViewController ()

@end

@implementation SKBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:KBlueColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.titleTextAttributes= @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:kFont(18)};
    UIButton *leftCustomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftCustomButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [leftCustomButton setImage:[UIImage imageNamed:@"iconfont-fanhui"] forState:UIControlStateNormal];
     [leftCustomButton setImage:[UIImage imageNamed:@"iconfont-fanhui"] forState:UIControlStateHighlighted];
    leftCustomButton.frame = CGRectMake(2, 5, 25, 32);
    UIBarButtonItem * leftButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftCustomButton];
    [self.navigationItem setLeftBarButtonItem:leftButtonItem];
    [self config];
}
#pragma mark --> 数据请求
- (void)config
{
    
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}
- (void)dealloc
{
    NSLog(@"__%s__  %@ 销毁了  这个地方到时候是要注释掉的，切记",__func__,NSStringFromClass([self class]));
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

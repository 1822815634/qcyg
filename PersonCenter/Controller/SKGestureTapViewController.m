//
//  SKGestureTapViewController.m
//  Stockallocation
//
//  Created by wuyou on 2019/7/9.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKGestureTapViewController.h"

@interface SKGestureTapViewController ()

@end

@implementation SKGestureTapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手势密码";
    [self makeUI];
    // Do any additional setup after loading the view.
}

- (void)makeUI {
    GestureLockView * lock=[[GestureLockView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    [lock setUnlockSuccess:^{
//        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:GestureTag];
//        [[NSUserDefaults standardUserDefaults]synchronize];
//        [self.navigationController popViewControllerAnimated:YES];
    }];
    [lock setSetSuccess:^{
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:GestureTag];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:lock];
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

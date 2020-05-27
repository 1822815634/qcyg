//
//  SVCTabBarController.m
//  SmartValleyCloudSeeding
//
//  Created by hxisWater on 2018/5/29.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCTabBarController.h"
#import "SVCNavigationController.h"
#import "SKLoginViewController.h"

@interface SVCTabBarController ()<UITabBarControllerDelegate>
@end

@implementation SVCTabBarController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]] ;
    self.delegate = self;
    self.tabBar.opaque = YES;
    self.tabBar.translucent=NO;
    if([[NSUserDefaults standardUserDefaults]boolForKey:HudeString]) {
        [self initWithtabBar:@"SKStockViewController" title:@"大赛" selectedImage:@"jyxxx" unselectedImage:@"jywww" ];
        [self initWithtabBar:@"SKConsultViewController" title:@"社区" selectedImage:@"sqxxx" unselectedImage:@"sqwww" ];
        [self initWithtabBar:@"SKPersonCenterViewController" title:@"我的" selectedImage:@"wdxxx" unselectedImage:@"wdwww" ];
//        self.selectedIndex = 1;
    } else {
        [self initWithtabBar:@"SKMainHomeViewController" title:@"首页" selectedImage:@"syxxx" unselectedImage:@"sywww"];
        [self initWithtabBar:@"SKProductViewController" title:@"产品" selectedImage:@"hqxxx" unselectedImage:@"hqwww" ];
        [self initWithtabBar:@"SKStockViewController" title:@"大赛" selectedImage:@"jyxxx" unselectedImage:@"jywww" ];
        [self initWithtabBar:@"SKConsultViewController" title:@"社区" selectedImage:@"sqxxx" unselectedImage:@"sqwww" ];
        [self initWithtabBar:@"SKPersonCenterViewController" title:@"我的" selectedImage:@"wdxxx" unselectedImage:@"wdwww" ];
    }

}

- (void)initWithtabBar:(NSString *)viewControlName title:(NSString *)title selectedImage:(NSString *)imageName unselectedImage:(NSString *)unselectedimage {
    Class class = NSClassFromString(viewControlName);
    UIViewController *control = [[class alloc] init];
    control.title = title;
    control.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage loadImageWithImgName:unselectedimage] selectedImage:[UIImage loadImageWithImgName:imageName]];
    NSDictionary *dictHome = [NSDictionary dictionaryWithObject:KBlueColor forKey:NSForegroundColorAttributeName];
    [control.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
    SVCNavigationController *nav = [[SVCNavigationController alloc] initWithRootViewController:control];
    [self addChildViewController:nav];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([viewController.tabBarItem.title isEqualToString:@"我的"]||[viewController.tabBarItem.title isEqualToString:@"社区"]) {
        if ([SKUserInfoModel userToken].length < 5) {
            [self SKoutLogoutCellClick];
             return NO;
        }else{
            return YES;
        }
    }else{
        return YES;
    }
}
- (void)SKoutLogoutCellClick
{
    SKLoginViewController *logVC = [[SKLoginViewController alloc] init];
    logVC.title = @"登录";
    SVCNavigationController *nav = [[SVCNavigationController alloc] initWithRootViewController:logVC];
    [self presentViewController:nav animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

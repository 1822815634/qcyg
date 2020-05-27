//
//  AppDelegate.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/7.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "AppDelegate.h"
#import "SVCTabBarController.h"
#import <ShareSDK/ShareSDK.h>
#import <WXApi.h>
#import "GestureLockView.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    /**
     启动图延时
     */
    [NSThread sleepForTimeInterval:1.0];
    SVCTabBarController *tab = [[SVCTabBarController alloc] init];
    _window.rootViewController = tab;
    [self initShare];
    /**
     请求隐藏接口
     */
    WS(weakSelf);
    [SVCCommunityApi hudeIsOpenWithNSDictionary:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"ios1",@"fromChannel", nil] BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
        NSDictionary *dictionary = [JSON objectForKey:@"data"];
            NSLog(@"%@",[dictionary objectForKey:@"isopen"]);
        [[NSUserDefaults standardUserDefaults] setBool:[[dictionary objectForKey:@"isopen"]integerValue] forKey:HudeString];
        [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"%d",[[NSUserDefaults standardUserDefaults] boolForKey:HudeString]);
        SVCTabBarController *tab = [[SVCTabBarController alloc] init];
        _window.rootViewController = tab;
        //开启手势密码
        if ([[NSUserDefaults standardUserDefaults]boolForKey:GestureTag]) {
            GestureLockView * lock=[[GestureLockView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) hiddenBottom:NO bottomBtnTag:0];
            [lock setUnlockSuccess:^{
                [lock removeFromSuperview];
            }];
            [lock setBtnBlock:^{
               //忘记手势密码
                [SKUserInfoModel deleteModel];
                SVCTabBarController *tab = [[SVCTabBarController alloc] init];
                _window.rootViewController = tab;
                SKLoginViewController *logVC = [[SKLoginViewController alloc] init];
                logVC.title = @"登录";
                SVCNavigationController *nav = [[SVCNavigationController alloc] initWithRootViewController:logVC];
                [tab presentViewController:nav animated:YES completion:nil];
            }];
            [_window addSubview:lock];
        }
        }
    } andfail:^(NSError *error) {
        [weakSelf.window toastShow:@"网络请求失败,请接入网络后使用"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        exit(0);
        });
    }];
    return YES;
}
- (void)initShare
{
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
        [platformsRegister setupQQWithAppId:@"101844018" appkey:@"e57803d19d48f91864c7c8dd3ff85d08"];
        [platformsRegister setupWeChatWithAppId:@"wx86006c52b15e7c1a" appSecret:@"wybbs9527"];
    }];
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<NSString *,id> *)options {
 return  [WXApi handleOpenURL:url delegate:self];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    if ([[NSUserDefaults standardUserDefaults]boolForKey:GestureTag]) {
        GestureLockView * lock=[[GestureLockView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) hiddenBottom:NO bottomBtnTag:0];
        [lock setUnlockSuccess:^{
            [lock removeFromSuperview];
        }];
        [lock setBtnBlock:^{
            //忘记手势密码
            [SKUserInfoModel deleteModel];
            SVCTabBarController *tab = [[SVCTabBarController alloc] init];
            _window.rootViewController = tab;
            SKLoginViewController *logVC = [[SKLoginViewController alloc] init];
            logVC.title = @"登录";
            SVCNavigationController *nav = [[SVCNavigationController alloc] initWithRootViewController:logVC];
            [_window.rootViewController presentViewController:nav animated:YES completion:nil];
            
        }];
        [_window addSubview:lock];
    }
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Stockallocation"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end

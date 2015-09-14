//
//  AppDelegate.m
//  观天下
//
//  Created by MS on 15/9/5.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "AppDelegate.h"
#import "QianDaoViewController.h"
#define PK @"0YuSuQOmVnhQkQsnh20yssMW"
BMKMapManager* _mapManager;
@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:PK generalDelegate:self];
    
    if (!ret) {
        NSLog(@"manager start failed!");
    }

    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    
//    设置状态栏颜色
    NSDictionary* textAttributes = @{
                                     NSFontAttributeName : [UIFont systemFontOfSize:24],
                                     NSForegroundColorAttributeName :[UIColor colorWithRed:214.0/255 green:102.0/255 blue:64.0/255 alpha:1.0],
                                     };
    
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
    
//    MainUITabBarController  *rootVC = [[MainUITabBarController alloc]init];
    
    
    QianDaoViewController *qian = [[QianDaoViewController alloc]init];

    self.window.rootViewController = qian;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}


@end

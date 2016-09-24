//
//  AppDelegate.m
//  iOS10通知
//
//  Created by JuLiaoyuan on 16/9/24.
//  Copyright © 2016年 JuLiaoyuan. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "PEEAlertView.h"

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 在 didFinishLaunchingWithOptions：
    UNUserNotificationCenter *notification = [UNUserNotificationCenter currentNotificationCenter];
    notification.delegate = self;
    [notification requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionAlert | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
    }];
    return YES;
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
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSString *categoryIdentifier = response.actionIdentifier;
    if ([categoryIdentifier isEqualToString:JLYNotificationInputID]) {
        
        UNTextInputNotificationResponse *action = (UNTextInputNotificationResponse *)response;
        [PEEAlertView showAlertWithTitle:@"输入的内容为:" message:action.userText actionTitle:@"确定"];
    }
    if ([categoryIdentifier isEqualToString:JLYNotificationSayHelloID]) {
        [PEEAlertView showAlertWithTitle:@"Hello" message:@"" actionTitle:@"OK"];
    }
    if ([categoryIdentifier isEqualToString:JLYNotificationCancelID]) {
        NSLog(@"cancel");
    }
    NSLog(@"%@",response.notification.request.content.userInfo[@"name"]);
    completionHandler();
}

//- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    
//}


@end

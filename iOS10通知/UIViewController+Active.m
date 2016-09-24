//
//  UIViewController+Active.m
//  PandaeeMercApp
//
//  Created by JuLiaoyuan on 16/8/18.
//  Copyright © 2016年 JuLiaoyuan. All rights reserved.
//

#import "UIViewController+Active.h"

@implementation UIViewController (Active)

+ (UIViewController *)activeViewController {
    UIViewController *viewController = [[UIViewController alloc] init];
    id vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [viewController activeViewController:vc];
}
- (UIViewController *)activeViewController:(id)viewController {
    if ([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)viewController;
        return [self activeViewController:tab.selectedViewController];
    }
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)viewController;
        return [nav visibleViewController];
    }
    if ([viewController isKindOfClass:[UIViewController class]]) {
        return (UIViewController *)viewController;
    }
    return nil;
}
@end

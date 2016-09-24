//
//  PEEAlertView.m
//  PandaeeMercApp
//
//  Created by JuLiaoyuan on 16/8/18.
//  Copyright © 2016年 JuLiaoyuan. All rights reserved.
//

#import "PEEAlertView.h"
#import "UIViewController+Active.h"

@implementation PEEAlertView

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message actionTitle:(nonnull NSString *)actionTitle {
    
    PEEAlertView *alert = [[PEEAlertView alloc] init];
    [alert showAlertWithTitle:title
                      message:message
                  actionTitle:actionTitle];
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message actionTitle:(NSString *)actionTitle {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:nil]];
    UIViewController *vc = [UIViewController activeViewController];
    [vc presentViewController:alert animated:YES completion:nil];
}

@end

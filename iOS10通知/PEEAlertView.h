//
//  PEEAlertView.h
//  PandaeeMercApp
//
//  Created by JuLiaoyuan on 16/8/18.
//  Copyright © 2016年 JuLiaoyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PEEAlertView : NSObject

/**
 *  @author JuLiaoyuan, 16-08-18 15:08:30
 *
 *  弹出AlertView
 *
 *  @param title   标题
 *  @param message 信息
 */
+ (void)showAlertWithTitle:(nonnull NSString *)title
                   message:(nonnull NSString *)message
               actionTitle:(nonnull NSString *)actionTitle;

@end

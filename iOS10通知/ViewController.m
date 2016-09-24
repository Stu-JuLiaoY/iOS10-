//
//  ViewController.m
//  iOS10通知
//
//  Created by JuLiaoyuan on 16/9/24.
//  Copyright © 2016年 JuLiaoyuan. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <MobileCoreServices/MobileCoreServices.h>

static NSString * const categoryIdentifier  = @"com.liaoyuanCategory.www";
static NSString * const threadIdentifier    = @"com.liaoyuanThread.www";
static NSString * const requestIdentifier   = @"com.liaoyuannotification.www";
static NSString * const attachmentIdentifie = @"com.liaoyuanAttachment.www";
static NSString * const customUIIdentifier  = @"com.customUIIdentifier.www";

NSString *JLYNotificationInputID    = @"notificationInputID";
NSString *JLYNotificationSayHelloID = @"notificationSayHelloID";
NSString *JLYNotificationCancelID   = @"notificationCancelID";


@interface ViewController ()

@property (nonatomic, strong) UNMutableNotificationContent *content;

@property (nonatomic, strong) UNNotificationRequest *request;

@property (nonatomic, strong) UNTimeIntervalNotificationTrigger *trigger;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.badge = @1;
    content.title = @"liaoyuan test title";
    content.body = @"liaoyuan test body";
    content.subtitle = @"liaoyuan test subtitle";
    content.categoryIdentifier = categoryIdentifier;
    content.sound = [UNNotificationSound defaultSound];
    content.threadIdentifier = threadIdentifier;
    content.userInfo = @{@"name":@"liaoyuan"};
    
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3.f repeats:NO];
    
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"1" withExtension:@"jpg"];
    NSDictionary *options = @{UNNotificationAttachmentOptionsTypeHintKey:(NSString *)kUTTypeImage,
                              UNNotificationAttachmentOptionsThumbnailHiddenKey:@NO,
                              UNNotificationAttachmentOptionsThumbnailClippingRectKey:NSStringFromCGRect(CGRectMake(0, 0, 0.5, 0.5))};
    UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:attachmentIdentifie URL:url options:options error:nil];

    content.attachments = @[attachment];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:trigger];
    
    // 添加Action
    UNNotificationAction *sayHelloAction = [UNNotificationAction actionWithIdentifier:JLYNotificationSayHelloID title:@"你好" options:UNNotificationActionOptionForeground];
    UNTextInputNotificationAction *textInput = [UNTextInputNotificationAction actionWithIdentifier:JLYNotificationInputID title:@"评论一个" options:UNNotificationActionOptionForeground textInputButtonTitle:@"评论" textInputPlaceholder:@"评论一个"];
    
    UNNotificationAction *cancelAction = [UNNotificationAction actionWithIdentifier:JLYNotificationCancelID title:@"取消" options:UNNotificationActionOptionDestructive];
    
    UNNotificationCategory *notiCategory = [UNNotificationCategory categoryWithIdentifier:categoryIdentifier actions:@[sayHelloAction,textInput,cancelAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    
    UNUserNotificationCenter *notification = [UNUserNotificationCenter currentNotificationCenter];
    NSSet *set = [[NSSet alloc] initWithObjects:notiCategory, nil];
    [notification setNotificationCategories:set];
    
    self.content = content;
    self.trigger = trigger;
    self.request = request;
}
- (IBAction)pushLocalNotification:(id)sender {
    UNUserNotificationCenter *notification = [UNUserNotificationCenter currentNotificationCenter];
    [notification addNotificationRequest:self.request withCompletionHandler:^(NSError * _Nullable error) {
        
    }];

}
// 移除还未展示的通知
- (IBAction)removeLocalNotification:(id)sender {
    UNUserNotificationCenter *notification = [UNUserNotificationCenter currentNotificationCenter];
    [notification removePendingNotificationRequestsWithIdentifiers:@[requestIdentifier]];
}

// 移除已经展示的通知
- (IBAction)removeDeliveredLocalNotification:(id)sender {
    UNUserNotificationCenter *notification = [UNUserNotificationCenter currentNotificationCenter];
    [notification removeDeliveredNotificationsWithIdentifiers:@[requestIdentifier]];

}

// 更新通知
- (IBAction)updateLocalNotification:(id)sender {
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.badge = @1;
    content.title = @"liaoyuan update title";
    content.body = @"liaoyuan update body";
    content.subtitle = @"liaoyuan update subtitle";
    content.categoryIdentifier = categoryIdentifier;
    content.sound = [UNNotificationSound defaultSound];
    content.threadIdentifier = threadIdentifier;
    content.userInfo = @{@"name":@"liaoyuan"};
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3.f repeats:NO];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"2" withExtension:@"gif"];
    NSError *error = nil;
    UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:attachmentIdentifie URL:url options:nil error:&error];
    content.attachments = @[attachment];
    
    UNNotificationRequest *newRequest = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:trigger];
    UNUserNotificationCenter *newNotification = [UNUserNotificationCenter currentNotificationCenter];
    [newNotification addNotificationRequest:newRequest withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
    
}

// 静态图片
- (IBAction)pushImageNotification:(id)sender {
    UNUserNotificationCenter *notification = [UNUserNotificationCenter currentNotificationCenter];
    [notification addNotificationRequest:self.request withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
    
}

// GIF
- (IBAction)pushGIFNotification:(id)sender {
    UNUserNotificationCenter *notification = [UNUserNotificationCenter currentNotificationCenter];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"2" withExtension:@"gif"];
    NSDictionary *options = @{UNNotificationAttachmentOptionsTypeHintKey:(NSString *)kUTTypeGIF,
                              UNNotificationAttachmentOptionsThumbnailHiddenKey:@NO};
    UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:attachmentIdentifie URL:url options:options error:nil];
    
    self.content.attachments = @[attachment];
    UNNotificationRequest *gifRequest = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:self.content trigger:self.trigger];
    [notification addNotificationRequest:gifRequest withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
}

// Movie
- (IBAction)pushMovieNotification:(id)sender {

    UNUserNotificationCenter *notification = [UNUserNotificationCenter currentNotificationCenter];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"movie" withExtension:@"mov"];
    NSDictionary *options = @{UNNotificationAttachmentOptionsTypeHintKey:(NSString *)kUTTypeMovie,
                              UNNotificationAttachmentOptionsThumbnailHiddenKey:@NO,
                              UNNotificationAttachmentOptionsThumbnailTimeKey: @5};
    UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:attachmentIdentifie URL:url options:options error:nil];
    
    self.content.attachments = @[attachment];
    UNNotificationRequest *movieRequest = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:self.content trigger:self.trigger];
    [notification addNotificationRequest:movieRequest withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
    
}

// 声音
- (IBAction)pushSoundNotification:(id)sender {
    
    UNUserNotificationCenter *notification = [UNUserNotificationCenter currentNotificationCenter];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"sound" withExtension:@"m4a"];
    NSDictionary *options = @{UNNotificationAttachmentOptionsTypeHintKey:(NSString *)kUTTypeMPEG4Audio,
                              UNNotificationAttachmentOptionsThumbnailHiddenKey:@NO
                              };
    UNNotificationAttachment *soundAttachment = [UNNotificationAttachment attachmentWithIdentifier:attachmentIdentifie URL:url options:options error:nil];
    
    self.content.attachments = @[soundAttachment];
    UNNotificationRequest *soundRequest = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:self.content trigger:self.trigger];
    [notification addNotificationRequest:soundRequest withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
}
- (IBAction)pushCustomUINotification:(id)sender {
    UNMutableNotificationContent *cuContent = [UNMutableNotificationContent new];
    cuContent.title = @"custom UI Notification";
    cuContent.body = @"custom UI body";
    cuContent.categoryIdentifier = customUIIdentifier;
    
    UNTimeIntervalNotificationTrigger *cuTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3.f repeats:NO];
    
    UNNotificationRequest *cuRequest = [UNNotificationRequest requestWithIdentifier:@"custom UI" content:cuContent trigger:cuTrigger];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:cuRequest withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

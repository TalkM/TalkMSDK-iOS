//
//  IMClientManager.m
//  MobileIMSDK4iDemo
//
//  Created by JackJiang on 15/11/8.
//  Copyright © 2015年 openmob.net. All rights reserved.
//

#import "IMClientManager.h"
#import "ClientCoreSDK.h"
#import "ConfigEntity.h"
#import "MessagesProvider.h"
#import "SDKUtils.h"

//prefix
#import <Availability.h>

#ifndef __IPHONE_3_0
#warning "This project uses features only available in iOS SDK 3.0 and later."
#endif

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Default.h"
#import "BasicTool.h"
#import "CocoaLumberjack.h"

#ifdef DEBUG
static DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static DDLogLevel ddLogLevel = DDLogLevelInfo;
#endif

#endif
//end prefix





///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 私有API
///////////////////////////////////////////////////////////////////////////////////////////

@interface IMClientManager ()

/* MobileIMSDK是否已被初始化. true表示已初化完成，否则未初始化. */
@property (nonatomic) BOOL _init;
//
@property (strong, nonatomic) ChatBaseEventImpl *baseEventListener;
//
@property (strong, nonatomic) ChatTransDataEventImpl *transDataListener;
//
@property (strong, nonatomic) MessageQoSEventImpl *messageQoSListener;

// 消息提供者
@property (strong, nonatomic) MessagesProvider *messagesProvider;

@end


///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 本类的代码实现
///////////////////////////////////////////////////////////////////////////////////////////

@implementation IMClientManager

// 本类的单例对象
static IMClientManager *instance = nil;

+ (IMClientManager *)sharedInstance
{
    if (instance == nil)
    {
        instance = [[super allocWithZone:NULL] init];
    }
    return instance;
}

/*
 *  重写init实例方法实现。
 *
 *  @return
 *  @see [NSObject init:]
 */
- (id)init
{
    if (![super init])
        return nil;
    
    [self initMobileIMSDK];
    
    return self;
}

- (void)initMobileIMSDK
{
    if(!self._init)
    {
        // 设置AppKey
        [ConfigEntity registerWithAppKey:@"5418023dfd98c579b6001741"];
        
        // 设置服务器ip和服务器端口
      [ConfigEntity setServerIp:IM_SERVER_ADDR];
      [ConfigEntity setServerPort:IM_SERVER_PORT];

        // RainbowCore核心IM框架的敏感度模式设置
//      [ConfigEntity setSenseMode:SenseMode10S];
        
        // 开启DEBUG信息输出
        [ClientCoreSDK setENABLED_DEBUG:NO];
        
        // 设置事件回调
        self.baseEventListener = [[ChatBaseEventImpl alloc] init];
        self.transDataListener = [[ChatTransDataEventImpl alloc] init];
        self.messageQoSListener = [[MessageQoSEventImpl alloc] init];
        [ClientCoreSDK sharedInstance].chatBaseEvent = self.baseEventListener;
        [ClientCoreSDK sharedInstance].chatTransDataEvent = self.transDataListener;
        [ClientCoreSDK sharedInstance].messageQoSEvent = self.messageQoSListener;

        self.messagesProvider = [[MessagesProvider alloc] init];
        
        self._init = YES;
    }
}

- (void)releaseMobileIMSDK
{
    [[ClientCoreSDK sharedInstance] releaseCore];
}

- (ChatTransDataEventImpl *) getTransDataListener
{
    return self.transDataListener;
}
- (ChatBaseEventImpl *) getBaseEventListener
{
    return self.baseEventListener;
}
- (MessageQoSEventImpl *) getMessageQoSListener
{
    return self.messageQoSListener;
}

- (MessagesProvider *)getMessagesProvider
{
    return self.messagesProvider;
}

- (NSString *)getCurrentFrontChattingUserUID
{
//    return @"40089";
    return [SDKUtils getCurrentLoginExtra].csid;
}

- (LoginInfoExtra *)getLocalUserInfoProvider
{
    return [SDKUtils getCurrentLoginExtra];
}

- (void)updateLocalUserInfoProvider:(LoginInfoExtra *)latestLoginInfoExtra
{
    [SDKUtils updateCurrentLoginExtra:latestLoginInfoExtra];
}

+ (NSString *)getSSOURL:(NSString *)cid
{
    NSString *fullSSOURL = [SSO_API_URL stringByReplacingOccurrencesOfString:@"{1}" withString:cid];
    DDLogDebug(@"[IMClientManager][SSO接口]构造完成的fullSSOURL=%@", fullSSOURL);
    return fullSSOURL;
}

@end

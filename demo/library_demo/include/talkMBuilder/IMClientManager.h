//
//  IMClientManager.h
//  MobileIMSDK4iDemo
//
//  Created by JackJiang on 15/11/8.
//  Copyright © 2015年 openmob.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatBaseEventImpl.h"
#import "MessageQoSEventImpl.h"
#import "MessagesProvider.h"
#import "ChatTransDataEventImpl.h"
//#import "LoginInfoExtra.h"

@interface IMClientManager : NSObject

/*!
 * 取得本类实例的唯一公开方法。
 * <p>
 * 本类目前在APP运行中是以单例的形式存活，请一定注意这一点哦。
 *
 * @return instancetype
 */
+ (IMClientManager *)sharedInstance;

- (void)initMobileIMSDK;

//- (void)releaseMobileIMSDK;

- (ChatTransDataEventImpl *) getTransDataListener;
- (ChatBaseEventImpl *) getBaseEventListener;
- (MessageQoSEventImpl *) getMessageQoSListener;

- (MessagesProvider *)getMessagesProvider;

/**
 * 获得当前正在聊天中的用户UID.
 * <p>
 * <b>重要说明：</b>此变量只在{@link ChatActivity}处于前景（即在onResume()方法调用的情况下）被
 * 设置、在{@link ChatActivity}处于非激活或关闭（即在onPause()方法调用的情况下）被取消设置（置成null）.
 *
 * @return
 */
//- (NSString *)getCurrentFrontChattingUserUID;

//- (LoginInfoExtra *)getLocalUserInfoProvider;

//- (void)updateLocalUserInfoProvider:(LoginInfoExtra *)latestLoginInfoExtra;

/**
 * 返回TalkM的SSO单点登陆接口完整URL。
 *
 * 目前Talkm的SSO接口是每个租户一个url，形如：“https://公司id.alias.talkm.info/sso”，
 * 所以自20170308起，SSO的URL已改为根据cid自动组织SSO完整URL.
 *
 * @param cid 公司（租户）id
 * @return 动态拼接完成的对应租户的SSO完整URL
 */
//+ (NSString *)getSSOURL:(NSString *)cid;

@end

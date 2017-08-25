//
//  IMLaunchWrapper.h
//  TalkM_visitor
//
//  Created by JackJiang on 17/4/11.
//  Copyright © 2017年 JackJiang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IMLaunchWrapper : NSObject<UIAlertViewDelegate>

- (id)initWith:(UIViewController *)parentViewController;

/**
 * IM相关配置的初始化代码，在真正连接之前，本方法必须首先被调用（理论上只需调用一次）。
 */
- (void)initConnectToIMServer;

/**
 * 连接到IM服务器实现代码。
 *
 * @param cid
 * @param uid
 * @param token
 */
- (void)connectToIMServer:(NSString *)cid withUid:(NSString *)uid andToken:(NSString *)token;

/**
 进入一对一聊天界面。
 */
- (void)gotoChatViewController;

- (void)gotoNoAgentViewController;

@end

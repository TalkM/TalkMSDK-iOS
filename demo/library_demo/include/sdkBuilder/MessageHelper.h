//
//  MessageHelper.h
//  TalkM_visitor
//
//  Created by JackJiang on 17/4/2.
//  Copyright © 2017年 JackJiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageHelper : NSObject

/**
 * 发送消息给指定user_id的用户（根方法实现）.
 *
 * @param user_id 当user_id=0时表示发送给服务器，否则发送给指定用户
 * @param message 要发送的文本消息
 * @return 返回发送状态码，参见 ErrorCode.h 的定义
 */
+ (int)sendMessageImpl:(NSString *)user_id withMessage:(NSString *)message
                finger:(NSString *)fingerPrint andTypeu:(int)typeu;

/**
 * 发送聊天消息（包括普通文本、图片消息、语音留言消息等）给指定user_id的用户.
 * <b>注意：</b>目前普通文本消息为了提升用户体验，提供QoS支持.
 *
 * @param user_id 当user_id=0时表示发送给服务器，否则发送给指定用户
 * @param message 要发送的文本消息
 * @param fingerPrint
 * @return 返回发送状态码，参见 ErrorCode.h 的定义
 */
+ (int)sendChatMessage:(NSString *)user_id withMessage:(NSString *)message finger:(NSString *)fingerPrint andTypeu:(int)typeu;

@end

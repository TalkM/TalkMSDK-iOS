//
//  MessageQoSHelper.h
//  TalkM_visitor
//
//  Created by JackJiang on 17/4/8.
//  Copyright © 2017年 JackJiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageQoSHelper : NSObject

/**
 * 处理发送失败的消息.
 *
 * @param lostMessages
 * @return
 */
+ (void)processMessagesLost_forLoverChat:(NSMutableArray*)lostMessages;

/**
 * 收到正式聊天消息的应答包时的处理.
 *
 * @param theFingerPrint
 * @return
 */
+ (BOOL)processMessagesBeReceived_forLoverChat:(NSString *)theFingerPrint;

@end

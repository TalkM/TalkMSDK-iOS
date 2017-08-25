//
//  ChatHelper.h
//  TalkM_visitor
//
//  Created by JackJiang on 17/4/1.
//  Copyright © 2017年 JackJiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserMessageType.h"
#import "CompletionDefine.h"
#import "ChatMsgEntity.h"
#import "MessagesProvider.h"
#import "JSQSystemSoundPlayer+JSQMessages.h"

@interface ChatHelper : NSObject

/**
 * 尝试从从TextMessage的JSON文本中解析出可以显示给用户看的消息文本.
 *
 * @param messageContent 真正的聊天文本内容（该内容可能是扁平文本（文本聊天消息）、文件（语音留言、图片消息）），是TextMessage中的m内容
 * @return 返回消息文本（仅用于ui显示哦）
 */
+ (NSString *)parseMessageForShow:(NSString *)messageContent withType:(int)msgType;

+ (ChatMsgEntity *)prepareRecievedMessage:(NSString *)msg withNickName:(NSString *)nickName
                                  andTime:(NSDate *)time andMsgType:(int)msgType avatar:(UIImage *)avatar;

/**
 * 处理收到的聊天文本消息.
 *
 * @param messageContent 真正的聊天文本内容（该内容可能是扁平文本（文本聊天消息）、文件（语音留言、图片消息）），是TextMessage中的m内容
 * @param time
 * @param playPromtAudio
 * @param showNotification
 * @param msgType 真正的聊天消息类型（是TextMessage对象中的ty内容）
 * @param recivedMessagesObserver
 */
+ (void)addChatMessageData:(NSString *)messageContent withTime:(NSString *)time playAudio:(BOOL)playPromtAudio showNotify:(BOOL)showNotification msgType:(int)msgType withrecivedMessagesObserver:(ObserverCompletion)recivedMessagesObserver avatar:(UIImage *)avatar;

+ (void)addMsgItemToChat_TO_TEXT:(NSString *)friendUid withContent:(NSString *)message andFinger:(NSString *)fingerPring;
+ (ChatMsgEntity *)addMsgItemToChat_TO_IMAGE:(NSString *)friendUid withContent:(NSString *)imageFileName andFinger:(NSString *)fingerPring;
+ (void)addMsgItemToChat_TO_VOICE:(NSString *)friendUid withContent:(NSString *)message andFinger:(NSString *)fingerPring;

/**
 * 将指导定的图片消息发送给聊天中的好友.
 *
 * @param messageType 参见  {@link TextMessage}中的文本消息类型
 * @param message 文本消息，如果该文本为null或空字符串则不会真正执行发送过程
 * @return code:0 表示发送成功，否则错误码
 */
+ (void)sendPlainTextMessageAsync:(NSString *)friendUID withMessage:(NSString *)message forSucess:(ObserverCompletion)sucessObs;

+ (void)sendPlainTextMessageAsyncForRating:(NSString *)friendUID withMessage:(NSString *)message forSucess:(ObserverCompletion)sucessObs;
+ (void)sendPlainTextMessageAsyncByType:(NSString *)friendUID withMessage:(NSString *)message forSucess:(ObserverCompletion)sucessObs msgType:(int) msgType;
/**
 * 将指定的图片消息发送给聊天中的好友.
 */
+ (void)sendImageMessageAsync:(NSString *)friendUID withImage:(NSString *)imageFileName fp:(NSString *)fingerPring forSucess:(ObserverCompletion)sucessObs;

/**
 * 向服务端发送“转接客服”指令/消息。
 * <p>
 * 提示：在调用本指令后，UI界面上可以做出相应的处理，本指令一旦成功发出就可以认为转接完成！
 *
 * @param originalServicerUid 从此客服转出
 * @param toServicerUid 转入到此客服
 * @param beSwitchVisitorUid 被转接的访客
 * @author Jack Jiang, at 20170711
 */
+ (void)doSendSwitchServicerCMD4IM:(NSString *)originalServicerUid
                                to:(NSString *)toServicerUid
                                be:(NSString *)beSwitchVisitorUid;

@end

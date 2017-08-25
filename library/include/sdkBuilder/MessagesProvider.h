//
//  MessagesProvider.h
//  TalkM_visitor
//
//  Created by JackJiang on 17/3/18.
//  Copyright © 2017年 JackJiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSMutableArrayObservable.h"
#import "ChatMsgEntity.h"

@interface MessagesProvider : NSObject

- (void)putMessage:(NSString *)uid withData:(ChatMsgEntity *)me;

/**
 * 将消息保存到本地数据库中作为历史聊天消息保存下来.
 *
 * @param uid
 * @param me
 * @see #putMessage(Context, String, ChatMsgEntity)
 */
- (void)saveToSqlite:(NSString *)uid withData:(ChatMsgEntity *)me;

/**
 * 载入历史聊天记录（存放于本地数据库中的）.
 * <p>
 * 本方法目前是在首次{@link #getMessages(String)}时，被调用.
 *
 * @param messageArray 即NSMutableArrayObservable<ChatMsgEntity>数组
 * @see #getMessages(String)
 */
- (void)loadChatMessageHistory:(NSMutableArrayObservable *) messageArray;

/**
 * 返回消息列表.
 * <p>
 * 本方法将会在任何时候保证返回非空对象！
 *
 * @return 如果该人员有历史消息则返回消息列表对象引用（即NSMutableArrayObservable<ChatMsgEntity>数组），否则返回一个空NSMutableArrayObservable对象引用
 */
- (NSMutableArrayObservable *) getMessages;

/**
 *
 * New Chat
 *
 */
- (NSMutableArrayObservable *) clearMessages;

/**
 * 通知所有观察者.
 *
 * <p>
 * 某些场景下，无法确知应该告之哪个观察者（其实是不知道对应的uid）.
 * 比如：新算法实现的丢包判断逻辑，因为了提高算法性能而无法知道uid，
 * 但丢包的消息状态变更后希望ui也能刷新，那么就干脆就这样尝试通知所有
 * 息所有者的观察者吧，性能也没有多大损失，但UI更新的目的也达到了！
 */
- (void)notifyAllObserver;

/**
 * 【本方法用于聊天消息质量保证机制的表现层机制】当对方确实收到包时（判定的标准
 * 是本地收到应答包）.
 *
 * @param fingerPrint
 */
- (void)friendReceivedMessage:(NSString *)fingerPrint;

/**
 * 【本方法用于聊天消息质量保证机制的表现层机制】直接从待决列表中匹配，而非遍历所有
 * 好友的所有消息，则计算效率要高很多罗.
 *
 * @return 返回的是“NSMutableDictionary<NSString *, ChatMsgEntity *>”字典对象指针
 */
- (NSMutableDictionary<NSString *, ChatMsgEntity *> *)getAllFriendsMessagesGhostForNoReceived;

/**
 * 【本方法用于聊天消息质量保证机制的表现层机制】当确实因网络等原因没有发送成功时（
 * 判定的标准是本地在超时的时间间隔内没有收到应答包：即客户决的QoS质量保证机制）.
 *
 * @param fingerPrint
 */
- (void)sendToFriendFaild:(NSString *)fingerPrint;

@end

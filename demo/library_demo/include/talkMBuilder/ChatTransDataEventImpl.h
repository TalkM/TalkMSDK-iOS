//
//  ChatTransDataEventImpl.h
//  RainbowCore4i
//
//  Created by JackJiang on 14/10/28.
//  Copyright (c) 2014年 openmob.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatTransDataEvent.h"
#import "ChatHelper.h"

@interface ChatTransDataEventImpl : NSObject <ChatTransDataEvent>

/** 服务端为此访客分配了客服后以指令的形式发送到访客端，由访客端网络监听器
 * 通过本观察者完成界面UI上的相应显示刷新。*/
@property (nonatomic, copy) ObserverCompletion receivedServicerUidObserver;// block代码块一定要用copy属性，否则报错！
- (void)setReceivedServicerUidObserver:(ObserverCompletion)receivedServicerUidObserver;

@property (nonatomic, copy) ObserverCompletion identityObserver;
- (void)setIdentityObserver:(ObserverCompletion)identityObserver;

@property (nonatomic, copy) ObserverCompletion queueObserver;
- (void)setQueueObserver:(ObserverCompletion)queueObserver;

@property (nonatomic, copy) ObserverCompletion typingObserver;
- (void)setTypingObserver:(ObserverCompletion)typingObserver;

@property (nonatomic, copy) ObserverCompletion endChatObserver;
- (void)setEndChatObserver:(ObserverCompletion)endChatObserver;

@property (nonatomic, copy) ObserverCompletion chatTransferObserver;
- (void)setChatTransferObserver:(ObserverCompletion)chatTransferObserver;

@property (nonatomic, copy) ObserverCompletion banUserObserver;
- (void)setBanUserObserver:(ObserverCompletion)banUserObserver;

-(void)onSocketListenerImpl:(NSArray *)dataContent typeU:(int)typeU;

@end

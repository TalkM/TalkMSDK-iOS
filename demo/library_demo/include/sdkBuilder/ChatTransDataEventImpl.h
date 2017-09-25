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

@end

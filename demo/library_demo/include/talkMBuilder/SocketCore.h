//
//  SocketCore.h
//  talkm_visitor_sdk
//
//  Created by Star Systems Internation on 17/04/2018.
//  Copyright © 2018 Star Systems International. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SocketIOEvent.h"

@interface SocketCore : NSObject <NSURLSessionDelegate>

@property (nonatomic, retain) id<SocketIOEvent> socketIOEvent;

+ (SocketCore *)sharedInstance;

@end

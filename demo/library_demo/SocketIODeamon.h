//
//  SocketIODeamon.h
//  talkm_visitor_sdk
//
//  Created by Star Systems Internation on 20/03/2018.
//  Copyright © 2018 Star Systems International. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatTransDataEvent.h"
#import "SocketIOEvent.h"

@import SocketIO;

@interface SocketIODeamon : NSObject <NSURLSessionDelegate, SocketIOEvent>

//socket properties
@property (strong, nonatomic) SocketManager* manager;

@end

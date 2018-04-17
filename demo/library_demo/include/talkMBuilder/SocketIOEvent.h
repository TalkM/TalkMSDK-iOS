//
//  SocketIO.h
//  talkm_visitor_sdk
//
//  Created by Star Systems Internation on 17/04/2018.
//  Copyright © 2018 Star Systems International. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SocketIOEvent <NSObject>

-(void)reconnect;
- (void)connect;
- (void)startChat: (NSString *)visitorID name:(NSString *)name email:(NSString *)email contactNumber:(NSString *)contactNumber chatID:(NSString *)chatID agentID:(NSString *)agentID gid:(NSString *)gid categoryName:(NSString*)categoryName message:(NSString *)message complete:(void (^)(bool sucess, NSString *returnValue))complete;

-(void)sendText:(NSString *)csid message:(NSString *)message complete:(void (^)(bool success, NSString *returnValue))complete;
-(void)sendFile:(NSString *)csid fileName:(NSString *)fileName fileSize:(NSString *)fileSize fileType:(NSString *)fileType fileLink:(NSString *)fileLink thumbLink:(NSString *)thumbLink complete:(void (^)(bool success, NSString *returnValue))complete;
-(void)sendTyping:(NSString *)csid  message:(NSString *)message complete:(void (^)(bool success, NSString *returnValue))complete;
-(void)sendRating:(NSString *)csid chatID:(NSString *)chatID rating:(NSString *)rating message:(NSString *)message complete:(void (^)(bool success, NSString *returnValue))complete;
-(void)sendTransferChat:(NSString *)chatID fromAgent:(NSString *)fromAgent toAgent:(NSString *)toAgent complete:(void (^)(bool success, NSString *returnValue))complete;
-(void)sendExportChat:(NSString *)id exportTo:(NSString *)exportTo complete:(void (^)(bool success, NSString *returnValue))complete;
-(void)sendOfflineMessage:(NSString *)name email:(NSString *)email contact:(NSString *)contact message:(NSString *)message complete:(void (^)(bool success, NSString *returnValue))complete;
-(void)sendEndChat:(NSString *)chatID csid:(NSString *)csid complete:(void (^)(bool success, NSString *returnValue))complete;

-(void)disconnct;

@end

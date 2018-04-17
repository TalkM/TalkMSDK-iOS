//
//  SocketIODeamon.m
//  talkm_visitor_sdk
//
//  Created by Star Systems Internation on 20/03/2018.
//  Copyright © 2018 Star Systems International. All rights reserved.
//

#import "SocketIODeamon.h"
#import "UserMessageType.h"
#import "Default.h"
#import "EVAToolKits.h"
#import "libsdk.h"
#import "ClientCoreSDK.h"

#import "UserDefaultsToolKits.h"

@implementation SocketIODeamon{

    SocketIOClient *socket;
    NSString *C_IMEVT_COMMON_DATA;
    
    BOOL *isReconnectStart, isTalkMInitialConnect;
}
/*! 由客户端发出 - 协议类型：客户端登陆 */
#define FROM_CLIENT_TYPE_OF_LOGIN       0
/*! 由客户端发出 - 协议类型：心跳包 */
#define FROM_CLIENT_TYPE_OF_KEEP_ALIVE  1
/*! 由客户端发出 - 协议类型：发送通用数据 */
#define FROM_CLIENT_TYPE_OF_COMMON_DATA 2
/*! 由客户端发出 - 协议类型：客户端退出登陆 */
#define FROM_CLIENT_TYPE_OF_LOGOUT      3
/*! 由客户端发出 - 协议类型：QoS保证机制中的消息应答包（目前只支持客户端间的QoS机制哦） */
#define FROM_CLIENT_TYPE_OF_RECIVED     4
/*! 由客户端发出 - 协议类型：C2S时的回显指令（此指令目前仅用于测试时） */
#define FROM_CLIENT_TYPE_OF_ECHO        5
/*! 由服务端发出 - 协议类型：响应客户端的登陆 */
#define FROM_SERVER_TYPE_OF_RESPONSE_LOGIN      50
/*! 由服务端发出 - 协议类型：响应客户端的心跳包 */
#define FROM_SERVER_TYPE_OF_RESPONSE_KEEP_ALIVE 51
/*! 由服务端发出 - 协议类型：反馈给客户端的错误信息 */
#define FROM_SERVER_TYPE_OF_RESPONSE_FOR_ERROR  52
/*! 由服务端发出 - 协议类型：反馈回显指令给客户端 */
#define FROM_SERVER_TYPE_OF_RESPONSE_ECHO       53


#pragma mark - initialization
static SocketIODeamon *instance = nil;
// 获取本类的单例。使用单例访问本类的所有资源是唯一的合法途径。
+ (SocketIODeamon *)sharedInstance
{
    if (instance == nil)
    {
        instance = [[super allocWithZone:NULL] init];
    }
    
    return instance;
}

#pragma mark - socket

-(void)reconnect{
    isReconnectStart = YES;
    
    [self connect];
}

- (void)connect{
    self.manager = [[SocketManager alloc] initWithSocketURL:[libsdk getUrl] config:@{@"log": @YES, @"compress": @YES, @"forcePolling":@YES, @"selfSigned": @YES , @"sessionDelegate":self, @"connectParams":@{@"role":@"visitor"}}];

    self.manager.forceNew = YES;
    socket = self.manager.defaultSocket;
    
    isTalkMInitialConnect = YES;
    [self setListener];
    [socket connect];
}

- (void)startChat: (NSString *)visitorID name:(NSString *)name email:(NSString *)email contactNumber:(NSString *)contactNumber chatID:(NSString *)chatID agentID:(NSString *)agentID gid:(NSString *)gid categoryName:(NSString*)categoryName message:(NSString *)message complete:(void (^)(bool sucess, NSString *returnValue))complete{
    
    [libsdk setStartChat:visitorID name:name email:email contactNumber:contactNumber chatID:chatID agentID:agentID gid:gid categoryName:categoryName message:message];
    
    [self startChat];
    
    complete(YES, @"0");
}

-(void)disconnct{
    [socket disconnect];
}

-(void)setListener{
    [socket on:@"connect" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"socket connected");
        NSLog(@"data size: %i", data.count);
        NSLog(@"data : %@", data.firstObject);
        NSLog(@"ack : %@", ack);
        
        [ClientCoreSDK sharedInstance].connectedToServer = YES;
        
        if (isReconnectStart){
            isReconnectStart = NO;
            [self startChat];
        }
        
        if (isTalkMInitialConnect == NO){
            //this connecct is not trigger by talkm, maybe its socket auto reconnect
            [self startChat];
        }
        
        isTalkMInitialConnect = NO;
    }];
    
    [socket on:@"disconnect" callback:^(NSArray* data, SocketAckEmitter* ack) {
        
        [self startChat];
    }];
    
    [socket on:@"identity" callback:^(NSArray* data, SocketAckEmitter* ack) {
        
        [libsdk setSocketVisitor:data];
        [[ClientCoreSDK sharedInstance].chatTransDataEvent onSocketListenerImpl:data.firstObject typeU:UMT_TYPE_IDENTITY];
    }];
    
    //visitor was put to queue
    [socket on:@"queued" callback:^(NSArray * data, SocketAckEmitter * ack) {
        
        [libsdk clearServicerUserDefault];
        
        //update chat
        [ClientCoreSDK sharedInstance].loginHasInit = YES;   //visitor success login, don openIM for temp back screen
        [[ClientCoreSDK sharedInstance].chatTransDataEvent onSocketListenerImpl:data.firstObject typeU:UMT_TYPE_QUEUE];
        
    }];
    
    //visitor was pick up by CS
    [socket on:@"served" callback:^(NSArray * data, SocketAckEmitter * ack) {
        
        [ClientCoreSDK sharedInstance].loginHasInit = YES;
        if([ClientCoreSDK sharedInstance].chatTransDataEvent != nil){
            [[ClientCoreSDK sharedInstance].chatTransDataEvent onSocketListenerImpl:data.firstObject typeU:UMT_TYPE_CMD_S_GET_NEXT_VISITOR_RESULT];
        }
    }];
    
    [socket on:@"text" callback:^(NSArray * data, SocketAckEmitter * ack) {
        
        [[ClientCoreSDK sharedInstance].chatTransDataEvent onSocketListenerImpl:data.firstObject typeU:UMT_TYPE_TEXT];
    }];
    
    [socket on:@"file" callback:^(NSArray * data, SocketAckEmitter * ack) {
        
        [[ClientCoreSDK sharedInstance].chatTransDataEvent onSocketListenerImpl:data.firstObject typeU:UMT_TYPE_IMAGE];
    }];
    
    [socket on:@"typing" callback:^(NSArray * data, SocketAckEmitter * ack) {
        
        [[ClientCoreSDK sharedInstance].chatTransDataEvent onSocketListenerImpl:data.firstObject typeU:C_USER_CMD_TYPE_TYPING];
    }];
    
    [socket on:@"action" callback:^(NSArray * data, SocketAckEmitter * ack) {
        
        [[ClientCoreSDK sharedInstance].chatTransDataEvent onSocketListenerImpl:data.firstObject typeU:UMT_TYPE_CMD_C_SUPER_COMMAND];
    }];
    
    [socket on:@"chat-ended" callback:^(NSArray * data, SocketAckEmitter * ack) {
        
        [[ClientCoreSDK sharedInstance].chatTransDataEvent onSocketListenerImpl:data.firstObject typeU:talkmEndChatActionID];
    }];
    
    //after chat
    [socket on:@"chat-transferred" callback:^(NSArray * data, SocketAckEmitter * ack) {
        
        [[ClientCoreSDK sharedInstance].chatTransDataEvent onSocketListenerImpl:data.firstObject typeU:UMT_TYPE_CHAT_TRANSFER];
    }];
    
    //ban visitor
    [socket on:@"banned" callback:^(NSArray * data, SocketAckEmitter * ack) {
        
        [[ClientCoreSDK sharedInstance].chatTransDataEvent onSocketListenerImpl:data.firstObject typeU:talkmBanActionID];
    }];
    
    //no CS online
    [socket on:@"offline" callback:^(NSArray * data, SocketAckEmitter * ack) {
        
        [[ClientCoreSDK sharedInstance].chatTransDataEvent onSocketListenerImpl:data.firstObject typeU:UMT_TYPE_SUPPORT_OFFLINE];
    }];
    
//        [socket on:@"currentAmount" callback:^(NSArray* data, SocketAckEmitter* ack) {
//            double cur = [[data objectAtIndex:0] floatValue];
//
//            [[socket emitWithAck:@"canUpdate" with:@[@(cur)]] timingOutAfter:0 callback:^(NSArray* data) {
//                [socket emit:@"update" with:@[@{@"amount": @(cur + 2.50)}]];
//            }];
//
//            [ack with:@[@"Got your currentAmount, ", @"dude"]];
//        }];
}

-(void)loginOKCallBack{
    [[ClientCoreSDK sharedInstance].chatBaseEvent onLoginMessage:0];  //this is working
}

-(void)startChat{
    [socket emit:@"start-chat" with:@[[libsdk sendSocketStartChatData]]];
}

-(void)sendText:(NSString *)csid message:(NSString *)message complete:(void (^)(bool success, NSString *returnValue))complete{
    
    [socket emit:@"text" with:@[[libsdk sendSocketTextData:csid message:message complete:complete]]];
}

-(void)sendFile:(NSString *)csid fileName:(NSString *)fileName fileSize:(NSString *)fileSize fileType:(NSString *)fileType fileLink:(NSString *)fileLink thumbLink:(NSString *)thumbLink complete:(void (^)(bool success, NSString *returnValue))complete{
    
    [socket emit:@"file" with:@[[libsdk sendSocketFileData:csid fileName:fileLink fileSize:fileSize fileType:fileType fileLink:fileLink thumbLink:thumbLink complete:complete]]];
}

-(void)sendTyping:(NSString *)csid  message:(NSString *)message complete:(void (^)(bool success, NSString *returnValue))complete{
    
    [socket emit:@"typing" with:@[[libsdk sendSocketTypingData:csid message:message complete:complete]]];
}

-(void)sendRating:(NSString *)csid chatID:(NSString *)chatID rating:(NSString *)rating message:(NSString *)message complete:(void (^)(bool success, NSString *returnValue))complete{
    
    [socket emit:@"rate-chat" with:@[[libsdk sendSocketRatingData:csid chatID:chatID rating:rating message:message complete:complete]]];
}

-(void)sendExportChat:(NSString *)chatID exportTo:(NSString *)exportTo complete:(void (^)(bool success, NSString *returnValue))complete{
    
    [socket emit:@"export-chat" with:@[[libsdk sendSocketExportChatData:chatID  exportTo:exportTo complete:complete]]];
}

-(void)sendTransferChat:(NSString *)chatID fromAgent:(NSString *)fromAgent toAgent:(NSString *)toAgent complete:(void (^)(bool success, NSString *returnValue))complete{
    
    [socket emit:@"transfer-chat" with:@[[libsdk sendSocketTransferChatData:chatID fromAgent:fromAgent toAgent:toAgent complete:complete]]];
}


-(void)sendOfflineMessage:(NSString *)name email:(NSString *)email contact:(NSString *)contact message:(NSString *)message complete:(void (^)(bool success, NSString *returnValue))complete{
    
    [socket emit:@"offline-message" with:@[[libsdk sendSocketOfflineMessageData:name email:email contact:contact message:message complete:complete]]];
}

-(void)sendEndChat:(NSString *)chatID csid:(NSString *)csid complete:(void (^)(bool success, NSString *returnValue))complete{
    
    [socket emit:@"end-chat" with:@[[libsdk sendSocketEndChatData:chatID csid:csid complete:complete]]];
}

-(void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    //accept all certs when testing, perform default handling otherwise
    
    completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]);
}

@end

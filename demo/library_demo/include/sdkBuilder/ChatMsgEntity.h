//
//  ChatMsgEntity.h
//  TalkM_visitor
//
//  Created by JackJiang on 17/3/25.
//  Copyright © 2017年 JackJiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicTool.h"

/*
 * 消息类型常量定义.
 */
typedef NS_ENUM(NSInteger, MsgType){
    MsgType_TO_TEXT    = 0,
    MsgType_COME_TEXT  = 2,

    MsgType_TO_IMAGE   = 4,
    MsgType_COM_IMAGE  = 5,

    MsgType_TO_VOICE   = 6,
    MsgType_COME_VOICE = 7,
    
    MsgType_RATE    = 17,
    MsgType_RATE_RETURN  = 18,
    MsgType_END_CONV  = 19,        // 3 options
    MsgType_END_CONV_CS  = 109,    //
    MsgType_END_CONV_VISITOR  = 20,   //the bubble msg with alert icon
    MsgType_END_CONV_AUTO  = 200,   //AUTO END MESSAGE
    MsgType_COMP_ADV  = 21,   //the bubble msg with alert icon
    MsgType_RES_TEXT = 22,   //auto respond text
    MsgType_GREATING_TEXT = 23,   //auto respond text
    MsgType_TRANSFER  = 24,   //auto transfer
};

/*
 * 文字消息的发送状态常量.
 */
typedef NS_ENUM(NSInteger, SendStatus){
    /** 消息发送中 */
    SendStatus_SNEDING     = 0,
    /** 消息已被对方收到（我方已收到应答包） */
    SendStatus_BE_RECEIVED = 1,
    /** 消息发送失败（在超时重传的时间内未收到应答包） */
    SendStatus_SEND_FAILD  = 2,
};

/**
 * 辅助发送状态常量.
 * <p>
 * 此常量通常用于发送图片、语音留言场合，因为图片上传到服务端的过程是
 * 一个独立的处理过程，需要和文字消息分开处理.
 */
typedef NS_ENUM(NSInteger, SendStatusSecondary){
    /** 无需处理 */
    SendStatusSecondary_NONE          = 0,
    /** 等待处理 */
    SendStatusSecondary_PENDING       = 1,
    /** 处理中 */
    SendStatusSecondary_PROCESSING    = 2,
    /** 成功处理完成 */
    SendStatusSecondary_PROCESS_OK    = 3,
    /** 处理失败 */
    SendStatusSecondary_PROCESS_FAILD = 4,
};



@interface ChatMsgEntity : NSObject

@property (nonatomic, retain) UIImage *avatar;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDate *date;

/* 本字段存放的内容可能是一个NSString对象或其它复合对象等，表示的是广义消息内容 */
@property (nonatomic, strong) id text;

@property (nonatomic, assign) int isComMeg;// = MsgType.toText;
/** 消息所对应的原始协议包指纹，目前只在发出的消息对象中有意义 */
@property (nonatomic, retain) NSString *fingerPrintOfProtocal;// = null;

/** 文字消息从网络发送的当前状态. 本字段仅针对发送的消息（而非收到的消息哦） */
@property (nonatomic, assign) int sendStatus;// = SendStatus.sending;
/**
 * 辅助处理状态. 本字段仅针对发送的消息（而非收到的消息哦）.
 * <p>
 * 此常量通常用于发送图片、语音留言场合，因为图片上传到服务端的过程是
 * 一个独立的处理过程，需要和文字消息分开处理. */
@property (nonatomic, assign) int sendStatusSecondary;// = SendStatusSecondary.none;
/** for rating : check whether its request or respond */
@property (nonatomic, assign) NSString *customInterfaceType;// = SendStatus.sending;
/** for rating : set the return message to visitor after rate */
@property (nonatomic, assign) NSString *respondText;// 

//comment 20170823
//+ (id)initWith:(NSString *)name andDate:(NSDate *)date andContent:(id)text andIsCome:(int)isComMsg;
//
//+ (id)initWith:(NSString *)name andDate:(NSDate *)date andContent:(id)text andIsCome:(int)isComMsg andSendStatusSecondary:(SendStatusSecondary)sendStatusSecondary;
//
//+ (id)initWith:(NSString *)name andDate:(NSDate *)date andContent:(id)text andIsCome:(int)isComMsg andSendStatusSecondary:(SendStatusSecondary)sendStatusSecondary avatar:(UIImage *)avatar;


+ (ChatMsgEntity *)createChatMsgEntity_TO_TEXT:(NSString *)message withFingerPrint:(NSString *)fingerPrint;
+ (ChatMsgEntity *)createChatMsgEntity_TO_IMAGE:(NSString *)fileName withFingerPrint:(NSString *)fingerPrint;
+ (ChatMsgEntity *)createChatMsgEntity_TO_VOICE:(NSString *)fileName withFingerPrint:(NSString *)fingerPrint;

+ (ChatMsgEntity *)createChatMsgEntity_COME_TEXT:(NSString *)nickName withContent:(NSString *)message avatar:(UIImage *)avatar;
+ (ChatMsgEntity *)createChatMsgEntity_COME_TEXT:(NSString *)nickName withContent:(NSString *)message andTime:(NSDate *)time avatar:(UIImage *)avatar;
+ (ChatMsgEntity *)createChatMsgEntity_RATE:(NSString *)nickName withContent:(NSString *)message customInterfaceType:(NSString *)customInterfaceType respondText:(NSString *)respondText;
+ (ChatMsgEntity *)createChatMsgEntity_RATE:(NSString *)nickName withContent:(NSString *)message andTime:(NSDate *)time customInterfaceType:(NSString *)customInterfaceType respondText:(NSString *)respondText;
+ (ChatMsgEntity *)createChatMsgEntity_END_CONV_BUBBLE:(NSString *)nickName withContent:(NSString *)message andTime:(NSDate *)time customInterfaceType:(NSString *)customInterfaceType respondText:(NSString *)respondText;
+ (ChatMsgEntity *)createChatMsgEntity_END_CONV:(NSString *)nickName withContent:(NSString *)message;
+ (ChatMsgEntity *)createChatMsgEntity_COME_RATE_RETURN:(NSString *)nickName withContent:(NSString *)message andTime:(NSDate *)time;
+ (ChatMsgEntity *)createChatMsgEntity_COME_IMAGE:(NSString *)nickName withContent:(NSString *)fileName avatar:(UIImage *)avatar;
+ (ChatMsgEntity *)createChatMsgEntity_COME_IMAGE:(NSString *)nickName withContent:(NSString *)fileName andTime:(NSDate *)time avatar:(UIImage *)avatar;
+ (ChatMsgEntity *)createChatMsgEntity_COME_VOICE:(NSString *)nickName withContent:(NSString *)fileName avatar:(UIImage *)avatar;
+ (ChatMsgEntity *)createChatMsgEntity_COME_VOICE:(NSString *)nickName withContent:(NSString *)fileName andTime:(NSDate *)time avatar:(UIImage *)avatar;
+ (ChatMsgEntity *)createChatMsgEntity_ByType:(NSString *)nickName withContent:(NSString *)message andTime:(NSDate *)time customInterfaceType:(NSString *)customInterfaceType respondText:(NSString *)respondText msgType:(int)msType avatar:(UIImage *)avatar;

@end

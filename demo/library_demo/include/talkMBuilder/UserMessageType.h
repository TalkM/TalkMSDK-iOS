//
//  UserMessageType.h
//  TalkM_visitor
//
//  Created by JackJiang on 17/3/25.
//  Copyright © 2017年 JackJiang. All rights reserved.
//

/**
 * 用户定义的消息类型常量（自定义协议类型，对应于Protocal的typeu字段值）。
 *
 * @author Jack Jiang, 2017-03-25
 * @version 1.0
 */


/** 聊天消息类型之：普通文字消息 */
#define UMT_TYPE_TEXT   0
/** 聊天消息类型之：图片消息（即消息内容就是存放于服务端的磁盘图片文件名） */
#define UMT_TYPE_IMAGE  1
/** 聊天消息类型之：语音留言消息（即消息内容就是存放于服务端的语音留言文件名） */
#define UMT_TYPE_VOICE  2

#define UMT_TYPE_RATE  107
#define UMT_TYPE_RATE_RETURN  1071    //talkmdev

#define UMT_TYPE_IDENTITY               100
#define UMT_TYPE_QUEUE                  101
#define UMT_TYPE_CHAT_TRANSFER          104


#define UMT_TYPE_SUPPORT_OFFLINE                103

/**
 * 指令消息类型之：接入下一个访客的完成结果指令：本消息由服务端处理完“接入下一个客户”指令后发出，发起对象目前只可能是服务端。
 * 建议使用100以外的整数！
 * 注意：本常量值与Web端的类型定义必须一致！*/
#define UMT_TYPE_CMD_S_GET_NEXT_VISITOR_RESULT  105

/**
 * 指令消息类型之：客服发起的会话评价（Rating)消息。
 * 建议使用100以外的整数！
 * 注意：本类型应与其它端中定义的消息类型必须一致！
 * add by Jack Jiang 20170208 */
#define UMT_TYPE_CMD_C_RATING                   107

/**
 * 【本指令目前用于客服端手动发出转接指令、访客端自动发出转接指令2个场景下，服务端收到指令后开始转接处理逻辑！】
 * 指令消息类型之：客服转接消息。
 *
 * 建议使用100以外的整数！
 * 注意：本类型应与Web服务端、Web访客客户端的main.js、客服端im_c_main.js、APP端中定义的消息类型必须一致！
 * add by Jack Jiang 20170711
 * */
#define UMT_TYPE_CMD_C_SWITCH_SERVICER          108


/**
 * 指令消息类型之：超级指令（用于客服端向访客端直接发送包含自定义dataContent内容的指令）。
 * 建议使用100以外的整数！
 * 注意：本类型应与其它端中定义的消息类型必须一致！
 * add by Jack Jiang 20170724
 * */
#define UMT_TYPE_CMD_C_SUPER_COMMAND            109

/**
 * 指令消息类型之：超级指令（用于客服端向访客端直接发送包含自定义dataContent内容的指令）。
 * 建议使用100以外的整数！
 * 注意：本类型应与其它端中定义的消息类型必须一致！
 * add by marcus 20180301
 * */
#define C_USER_CMD_TYPE_TYPING                  111

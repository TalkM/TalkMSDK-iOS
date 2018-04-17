//
//  Default.h
//  DSprot
//
//  Created by ding wei on 14-3-7.
//  Copyright (c) 2014年 ding wei. All rights reserved.
//

#ifndef DSprot_Default_h
#define DSprot_Default_h



#pragma mark - 基本网络服务URL配置

// ** SSO单点登陆API接口地址
//#define SSO_API_URL  @"http://192.168.1.190:8080/TalkM_IMHttpServer/sso?format=json"  // 苏州内网测试服务器
//#define SSO_API_URL    @"https://{1}.alias.talkm.info/sso?format=json"                  //
//#define SSO_API_URL    @"https://{1}.alias.talkm.dev/sso?format=json"                  // dev



//#define SSO_API_URL    @"https://{1}.talkm.org/sso?format=json&ostype=2&imsdkname=im_visitor_ios&imsdkver=b20170706"  //imsetting aws

//#define SSO_API_URL    @"https://{1}.alias.talkm.info/sso?format=json&ostype=2&imsdkname=im_visitor_ios&imsdkver=b20170706"  //imsetting info - alias only use for info n dev

//#define SSO_API_URL    @"https://{1}.alias.talkm.dev/sso?format=json&ostype=2&imsdkname=im_visitor_ios&imsdkver=b20170706"  //imsetting dev - alias only use for info n dev



// ** IM的服务器根地址
//#define IM_SERVER_ADDR @"192.168.1.190"   // 苏州内网测试服务器
//#define IM_SERVER_ADDR @"101.78.17.229" // TODO TalkM Alpha测试服务器  //info 101.78.17.229 = im.talkm.info (obsolute)
//#define IM_SERVER_ADDR @"im.talkm.dev" // TODO TalkM Alpha测试服务器  //dev  20171010 change to IP
//#define IM_SERVER_ADDR @"10.1.1.64" // TODO TalkM Alpha测试服务器  //dev 10.1.1.64 = im.talkm.dev  //20180411
//#define IM_SERVER_ADDR @"im.talkm.info" // TODO TalkM Alpha测试服务器  //info
//#define IM_SERVER_ADDR @"im.talkm.com" // TODO TalkM Alpha测试服务器  //AWS

//#define IM_SERVER_PORT 7901           //20180411

// ** HTTP Rest的服务器根地址
//#define APP_ROOT_URL @"192.168.1.190:8080"    // 苏州内网测试服务器
//#define APP_ROOT_URL @"101.78.17.229:8080"  // TODO TalkM Alpha测试服务器  //info 101.78.17.229 = tim.talkm.com (obsolute)
//#define APP_ROOT_URL @"im.talkm.com:8443"  // TODO TalkM Alpha测试服务器  //aws
//#define APP_ROOT_URL @"www.talkm.dev:8080"  // TODO TalkM Alpha测试服务器  //dev           //20180411
//#define APP_ROOT_URL @"tim.talkm.com:8443"  // TODO TalkM Alpha测试服务器  //info https
//#define APP_ROOT_URL @"tim.talkm.com:8080"  // TODO TalkM Alpha测试服务器  //info http

// CRM 服务器根地址
//#define CRM_SERVER_ADDR @"im.talkm.dev:4000"   //dev
//#define CRM_SERVER_ADDR @"im.talkm.info:4000"  //info
//#define CRM_SERVER_ADDR @"www.talkm.com:4000"  //aws

////***---------------- stagging and info--------------***
//// ** HTTP Rest普通数据服务端的根URL
//#define SERVER_CONTROLLER_URL_ROOT            @"https://"APP_ROOT_URL@"/TalkM_IMHttpServer/"    //20180411
//// ** HTTP Rest用户2进制数据下载Servlet地址
//#define BBONERAY_DOWNLOAD_CONTROLLER_URL_ROOT @"https://"APP_ROOT_URL@"/TalkM_IMHttpServer/BinaryDownloadController"      //20180411
//// ** HTTP Rest 图片消息的图片文件上传Servlet地址
//#define MSG_IMG_UPLODER_URL_ROOT              @"https://"APP_ROOT_URL@"/TalkM_IMHttpServer/MsgImageUploader"    //20180411

//***---------------- dev --------------***
// ** HTTP Rest普通数据服务端的根URL
//#define SERVER_CONTROLLER_URL_ROOT            @"http://"APP_ROOT_URL@"/TalkM_IMHttpServer/"
//#define IM_SERVER_CONTROLLER_URL_ROOT            @"http://"IM_SERVER_ADDR@":8080/TalkM_IMHttpServer/"
//#define CRM_SERVER_CONTROLLER_URL_ROOT            @"https://"CRM_SERVER_ADDR@""
// ** HTTP Rest用户2进制数据下载Servlet地址
//#define BBONERAY_DOWNLOAD_CONTROLLER_URL_ROOT @"http://"APP_ROOT_URL@"/TalkM_IMHttpServer/BinaryDownloadController"
// ** HTTP Rest 图片消息的图片文件上传Servlet地址
//#define MSG_IMG_UPLODER_URL_ROOT              @"http://"APP_ROOT_URL@"/TalkM_IMHttpServer/MsgImageUploader"



#pragma mark - 本地发出的消息图片、语音留言等文件操作相关配置

#define DIR_KCHAT_WORK_RELATIVE_ROOT        @"/talkm"

/* 聊天图片缓存目录 */
#define DIR_KCHAT_SENDPIC_RELATIVE_DIR      DIR_KCHAT_WORK_RELATIVE_ROOT@"/image"
/* 聊天时的语音留言缓存目录 */
#define DIR_KCHAT_SENDVOICE_RELATIVE_DIR    DIR_KCHAT_WORK_RELATIVE_ROOT@"/voice"

/* 用户发送的图片文件，允许的最大文件大小 */
#define LOCAL_IMAGE_FILE_DATA_MAX_LENGTH    2 * 1024 * 1024 // 2M
/* 用户发送的语音留言文件，允许的最大文件大小 */
#define LOCAL_VOICE_FILE_DATA_MAX_LENGTH    1 * 1024 * 1024 // 1M

/* SQLite本地存储：正式聊天消息的保存周期(目前是保存7天内的聊天消息，早于此消息的将被自动清除：保证安全性和节省存储空间) */
#define SQLITE_CHAT_MESSAGE_SOTRE_RANGE     7

/* 图片消息的图片压缩质量（0~1.0的值），改变此值将影要发送的图片文件大小 */
#define LOCAL_IMAGE_FILE_COMPRESS_QUALITY   0.75
/* 图片消息的图片缩放最大尺寸（0~1.0的值），改变此值将影要发送的图片文件大小 */
#define LOCAL_IMAGE_FILE_COMPRESS_MAX_WIDTH 1000



#pragma mark - 其它宏定义

#define dispatch_sync_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define dispatch_async_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

//
//#define FULL_URL(PAR) ([HTTP_WEB_HOST stringByAppendingString:PAR])
//#define PARMA_NEWDATA           @"newData"
//#define PARMA_PROCESSORID       @"processorId"
//#define PARMA_JOBDISPATCHID     @"jobDispatchId"
//#define PARMA_ACTIONID          @"actionId"


#pragma mark - nsnumber method

#define Numberf(f) ([NSNumber numberWithFloat:f])
#define Numbers(s) ([NSNumber numberWithString:s])
#define Numberi(d) ([NSNumber numberWithInt:d])
#define Numberd(d) ([NSNumber numberWithDouble:d])
#define Numberb(d) ([NSNumber numberWithBool:d])
#define Numberu(d) ([NSNumber numberWithUnsignedInt:d])


#define AlertCondition(condition, str) if(!condition) {[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"general_tip", @"") \
                                                                                   message:str\
                                                                                    delegate:nil\
                                                                                    cancelButtonTitle:NSLocalizedString(@"general_confirm", @"")\
                                                                                    otherButtonTitles:nil] show];}

//#pragma mark uiviewcontroller
//
//#define PUSH_VIEW(NAV,VIEWNAME) ([Utils navigation:NAV vc:VIEWNAME])
//#define PRESENT_VIEW(NAV,VIEWNAME) [Utils presentedViewController:NAV vc:VIEWNAME]
//
//
//#pragma mark - user default
//#define USER_ID @"_USER_ID"
//#define LAST_USER_MAIL @"_LAST_USER_MAIL"
//#define USER_EMAIL @"USER_EMAIL"
//#define USER_NICKNAME @"USER_NICKNAME"
//#define SAVED_MENU @"USER_MENU"
//#define SAVED_USER_DATA @"SAVED_USER_DATA"
//#define SAVED_USER_BOTTOM_DATA @"SAVED_USER_BOTTOM_DATA"
//#define SAVED_DEVICE_DATA @"SAVED_DEVICE_DATA"
//#define SAVED_DEVICE_DATA_SIMPLE @"SAVED_DEVICE_DATA_SIMPLE"
//
//#define ALARM_OFFLINE_TIMESTAMP_SAVED_KEY @"ALARM_OFFLINE_TIMESTAMP_SAVED_KEY"
//#define GOAL_OFFLINE_TIMESTAMP_SAVED_KEY @"GOAL_OFFLINE_TIMESTAMP_SAVED_KEY"
//#define LONGSIT_OFFLINE_TIMESTAMP_SAVED_KEY @"LONGSIT_OFFLINE_TIMESTAMP_SAVED_KEY"


//#pragma mark dictionary 2 object
//
//#define CheckDictionaryKey(A,B) ((!!A)&&(![A isKindOfClass:[NSNull class]])&&A.count>0&&[A.allKeys containsObject:B]&&(![[A objectForKey:B] isKindOfClass:[NSNull class]]))
//#define DateStringFromDictionary(DIC,KEY) ([Utils getDateFromString:[DIC objectForKey:KEY]])
//#define DateFromSecDic(DIC,KEY) ([Utils getDateFromNumber:[DIC objectForKey:KEY]])
//
//#define Dictionary2Object(DIC,KEY,OBJ) OBJ=@"";if (CheckDictionaryKey(DIC, KEY)) { \
//    OBJ = [DIC objectForKey:KEY];\
//}
//#define Dictionary2Object_2(DIC,KEY,OBJ,TYPE)\
//if (CheckDictionaryKey(DIC, KEY)) {\
//    if ([[DIC objectForKey:KEY] isKindOfClass:TYPE]) {\
//        OBJ = [DIC objectForKey:KEY];\
//    }\
//}
//#define Dictionary2TimeObject(DIC,KEY,OBJ) if (CheckDictionaryKey(DIC, KEY)) { \
//    if ([[DIC objectForKey:KEY ] isKindOfClass:[NSString class]]) {\
//        OBJ = DateStringFromDictionary(DIC, KEY);\
//    }else{\
//        OBJ = DateFromSecDic(DIC, KEY);\
//    }\
//}
//
//#define CURRENT_OS_UP_7  ([[[UIDevice currentDevice] systemVersion] floatValue]>=7)

#define UD     [NSUserDefaults standardUserDefaults]
#define KW        [[[UIApplication sharedApplication] delegate] window]
//#define APP_UserDefault     [NSUserDefaults standardUserDefaults]
//#define APP        [[UIApplication sharedApplication] delegate]
#define APP        ((AppDelegate*)[[UIApplication sharedApplication] delegate])

#define WINDOW_HEIGHT [[UIScreen mainScreen] bounds].size.height   //duplicate with [libsdk getScreenWidth]
#define WINDOW_WIDTH [UIScreen mainScreen].bounds.size.width       //duplicate with [libsdk getScreenHeight]

#define RGBCOLOR(r,g,b)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]    //RGB进制颜色值
#define HexColor(hexValue) [UIColor colorWithRed:((float)(((hexValue) & 0xFF0000) >> 16))/255.0 green:((float)(((hexValue) & 0xFF00) >> 8))/255.0 blue:((float)((hexValue) & 0xFF))/255.0 alpha:1.0]   //16进制颜色值，如：#000000 , 注意：在使用的时候hexValue写成：0x000000

#endif

//
//  libsdk.h
//  libtest
//
//  Created by Star Systems Internation on 14/11/2016.
//  Copyright © 2016 Star Systems International. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ServicerUidStore.h"

#define talkmRatingActionID                         0   //follow CRM
#define talkmActionableActionID                     1   //follow CRM
#define talkmTypingActionID                         10  //self define
#define talkmNoAgentActionID                        11  //self define
#define talkmEndChatActionID                        12  //self define
#define talkmBanActionID                            13  //self define
#define talkmUnbanActionID                          14  //self define

#define IS_PAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_PHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

@class MainViewController;

@interface libsdk : NSObject 

//+(void)initTalkM:(id)sender view:(UIView *)view tenant:(NSString *)tenant appID:(NSString *)appID appSecret:(NSString *)appSecret uiViewController:(UIViewController *)uiViewController;
+(void)initTalkM:(id)sender view:(UIView *)view tenant:(NSString *)tenant uiViewController:(UIViewController *)uiViewController;

+(void)showScreen2:(id)sender;

//uiview
+(void)initCustomBackNavigation:(UINavigationController*) navigationController;
+(void)returnParentView: (UINavigationController *) navigationController;
+(BOOL)findActionMessage:(NSString *)actionID;
+(Boolean)findSupportUserDetail:(NSString *)Csid;

+(void)showMessage;
+(void)showMessageWithType:(NSString *) title message : (NSString *) msg buttonTitle:(NSString *)buttonTitle errorType:(NSString *)errorType;

//avatar image
+(UIImage *)getCustomeSupportAvatar: (NSString *)url;
+(NSString *)getStandardSupportAvatarBySize:(NSString *) avatarSize;

//status bar
+(void)hideWindowStatusBar;
+(void)showWindowStatusBar;

//posting
+(BOOL)submitRatingByConversactionID:(NSString *)conversactionID ratingID:(NSString *)ratingID;

+(BOOL)submitLeaveMessage:(NSString *)contactNumber email:(NSString *)email message:(NSString *)message name:(NSString *)name;



//+(void)findOfflineSettingByAppID:(NSString *)appIDappSecret;

//+(void)api_updateChatEndTimeByCsid:(NSString *)csid
//                               uid:(NSString *)uid;

//+(void)saveServicer:(NSString *)servicerID
//       servicerName:(NSString *)servicerName
// servicerAvatarType:(NSString *)servicerAvatarType
//servicerAvatarValue:(NSString *)servicerAvatarValue
//  servicerAvatarUrl:(NSString *)servicerAvatarUrl
//  servicerSignature:(NSString *)servicerSignature;


//+(void) storeUserDefault : (NSString *) servicerId
//             servicerName: (NSString *) servicerName
//       servicerAvatarType: (NSString *) servicerAvatarType
//     servicerAvatarValue : (NSString *) servicerAvatarValue
//        servicerAvatarUrl: (NSString *) servicerAvatarUrl
//        servicerSignature: (NSString *) servicerSignature;

+(void) storeUserDefaultChatRate: (NSString *) isChatRated;
+(void) storeUserDefaultChatStatus: (NSString *) chatStatus chatEndConvText:(NSString *)chatEndConvText chatEndConvType:(NSString *)chatEndConvType;
+(void) storeUserDefaultChatEndConv: (NSString *) isChatEndConv chatEndConvText:(NSString *)chatEndConvText chatEndConvType:(NSString *)chatEndConvType;

//+(NSString *)readUserDefault;
+(NSString *)readUserDefaultChatRate;
+(NSString *)readUserDefaultChatStatus;
+(NSString *)readUserDefaultChatEndConv;
+(NSString *)readUserDefaultChatEndConvText;
+(NSString *)readUserDefaultChatEndConvType;

+(void)clearServicerUserDefault;

+ (UIColor *)convertColorFromHexString:(int)color;
+ (UIColor *)convertColorFromHexString2:(NSString *)hexString;
+(NSDictionary *)convertJsonStringToDictionary:(NSString *)jsonString;
+(NSDictionary *)convertArrayToDictionary:(NSArray *)array;
+(NSString *)convertDateFormatforBubble:(NSDate *)date;
+(NSString *)convertDateFormatforTopLabel:(NSDate *)date;
+ (UIImage *)convertImageWithSize:(UIImage *)image scaledToSize:(CGSize)newSize;
+(NSString *)convertByteToMegaByte:(NSString *)value;
+(NSData *)convertImageToData:(UIImage *)image;
+(int)compareDateInMinutes:(NSDate *)dateFrom dateTo:(NSDate *)dateTo;
+(int)compareDateInSecond:(NSDate *)dateFrom dateTo:(NSDate *)dateTo;

+ (UIImageView *) imageConvertCircle:(UIImageView *)image;
+(NSString *) getPlistPropertiesValue:(NSString *) propertiesKey;

//IM Checking
+(BOOL)checkCurrentViewIsChatView:(UIViewController *)currentView;

//company auto setting
+(void)clearAllAutoTimeOut;
+(void)clearAutoRespondTimeOut;
+(void)clearAutoEndChatTimeOut;
+(void)clearAutoTransferTimeOut;
//+(void)clearTypingTimeOut;

+(void)enableCountDown;
+(void)resetCustomerCountDown;
+(void)resetVisitorCountDown;
+(void)resetAutoRespondCountDown;
+(void)resetAutoEndChatCountDown;
+(void)resetAutoTransferCountDown;
+(void)resetAutoExpiredToken;
//+(void)resetTypingCountDown;

+(void)performCSEndChat;

//check customer support online status
//+(Boolean)findCompanyAgent:(NSString *)csid;

//+(void)startCountDown;

+ (BOOL) validateEmail: (NSString *) emailString ;
+ (BOOL) validateContactlength: (NSString *) contact ;
+ (BOOL) checkNavigationVisible;

//leave message
+(void) storeUserDefaultLeaveMessage:(NSString *)name email:(NSString *)email;
+(NSString *) readUserDefaultLeaveMessageName;
+(BOOL)getOfflineMessageEnableSetting;


//export chat
//+(BOOL)api_submitExportChatByEmail:(NSString *)email conversactionID:(NSString *)conversactionID;
+(BOOL)api_submitPendingExportChat;
+(void) storeUserDefaultExportEmail: (NSString *) email;
+(NSString *) readUserDefaultLeaveMessageEmail;  //transaction email,will cancel after success sent email
+(NSString *) readUserDefaultDisplayLeaveMessageEmail;

+(BOOL)isIphonePlusDevice;


//mobileIMSDK
//@property (strong, nonatomic) MainViewController *mainViewController;

//+ (UIView *) getMainView;
//+ (MainViewController *) getMainViewController;
//+ (void) refreshConnecteStatus;

+ (void)showToastInfo:(NSString *)content;
+ (void)showToastWarn:(NSString *)content;
+ (void)showToastError:(NSString *)content;
+ (void)showToast:(NSString *)title withContent:(NSString *)content;
+ (UIImage *)loadLocalMessageImg:(NSString *)fileName;

//UI handling
//view navigation
+(void)keyboardWillShow: (UIView *)view ;
+(void)keyboardWillHide: (UIView *)view ;
+(void)keyboardWillHide_Rating: (UIView *)view ;  //the window is too small, will handle the move manually in ratingView.m

//emoji
+(NSString *)convertEmojiToUnicode:(NSString *)emoji;
+(NSString *)convertUnicodeToEmoji:(NSString *)unicode;

//facebookID
+(NSString *)findFacebookID:(NSString *)facebookUrl;

//utility
+ (NSString *)findIphoneModel;
+(int) getScreenWidth;
+(int) getScreenHeight;
+(int)getFontWidth:(int) charLength fontSize:(int)fontSize;
+(int)getFontWidth2:(NSString *)text fontSize:(int)fontSize;
+(int)getFontWidth3:(NSString *)text fontSize:(int)fontSize;
+(CGSize)getFontLabelSize:(NSString *)text fontSize:(int)fontSize containerWidth:(float)ContainerWidth;
//+(int)getFontLabelHeight:(NSString *)text fontSize:(int)fontSize;
//+(CGSize)getFontLabelSize:(NSString *)text fontSize:(int)fontSize;
+(UIView *)dialogAlert:(id)sender titleText:(NSString *)titleText messageText:(NSString *)messageText leftButtonText:(NSString *)leftButtonText rightButtonText:(NSString *)rightButtonText andCompletion:(void (^)(BOOL finished))returnCompletion;
+(NSString*)stringAfterString:(NSString*)match inString:(NSString*)string;
+(NSString*)stringBeforeString:(NSString*)match inString:(NSString*)string;
+(NSArray *)substring:(NSString *)input byDelimiter:(NSString *)delimiter;

//bubble width
+(void) storeUserDefaultBubbleMaxWidth: (NSString *) bubbleWidth;
+(NSString *)readUserDefaultBubbleWidth;


//document
+(BOOL) downloadDocument:(NSString *)documentUrl fileName:(NSString *)fileName;
+(NSString *) getDocumentPath:(NSString *)fileName;
+(NSData *) readDocument:(NSString *)fileName;


//update queue event chat
//+(void)api_updateQueueEventtByType:(NSString *)zType cid:(NSString *)cid uid:(NSString *)uid gid:(NSString *)gid;
//+(void)api_updateQueueEventtByType2:(NSString *)zType cid:(NSString *)cid uid:(NSString *)uid gid:(NSString *)gid;

//get queue number
//+(BOOL)findQueueNumber;

//ban user
//+(void) storeUserDefaultBanUser:(NSString *) banStatus;
//+(NSString *)readUserDefaultBanUser;


//previous chat
+(BOOL)findChatHistoryList;
+(BOOL)findChatHistoryMessage:(NSString *)chatID;

//survey
+(BOOL) getPreSurveyEnable;
+ (void)gotoChatViewController;
+ (void)gotoPreSurveyViewController;
+ (void)gotoNoAgentViewController;
+ (void)gotoLeaveMessageViewController;

//upload image
//+(BOOL)api_uploadAttachmentByChat:(NSString *)chatID fileAttachment:(NSString *)attachment complete:(void (^)(bool success, NSString *returnValue))complete;
//+(BOOL)api_updateAttachmentByChat2:(NSString *)chatID fileName:(NSString *)fileName fileData:(NSData *)fileData complete:(void (^)(bool success, NSString *returnValue))complete;
+(void)api_updateAttachmentByFilePath:(NSString *)filePath fileName:(NSString *)fileName complete:(void (^)(bool success, NSString *returnValue))complete;


//socket
+(NSURL *)getUrl;
+(NSString *)getTenantKey;
+(NSDictionary *)getConfig;

+(void)setStartChat:(NSString *)visitorID name:(NSString *)name email:(NSString *)email contactNumber:(NSString *)contactNumber chatID:(NSString *)chatID agentID:(NSString *)agentID gid:(NSString *)gid categoryName:(NSString*)categoryName message:(NSString *)message;
+(NSDictionary *)sendSocketStartChatData;
+(NSDictionary *)sendSocketTextData:(NSString *)csid message:(NSString *)message complete:(void (^)(bool success, NSString *returnValue))complete;
+(NSDictionary *)sendSocketFileData:(NSString *)csid fileName:(NSString *)fileName fileSize:(NSString *)fileSize fileType:(NSString *)fileType fileLink:(NSString *)fileLink thumbLink:(NSString *)thumbLink complete:(void (^)(bool success, NSString *returnValue))complete;
+(NSDictionary *)sendSocketTypingData:(NSString *)csid  message:(NSString *)message complete:(void (^)(bool success, NSString *returnValue))complete;
+(NSDictionary *)sendSocketRatingData:(NSString *)csid chatID:(NSString *)chatID rating:(NSString *)rating message:(NSString *)message complete:(void (^)(bool success, NSString *returnValue))complete;
+(NSDictionary *)sendSocketExportChatData:(NSString *)chatID exportTo:(NSString *)exportTo complete:(void (^)(bool success, NSString *returnValue))complete;
+(NSDictionary *)sendSocketTransferChatData:(NSString *)chatID fromAgent:(NSString *)fromAgent toAgent:(NSString *)toAgent complete:(void (^)(bool success, NSString *returnValue))complete;
+(NSDictionary *)sendSocketOfflineMessageData:(NSString *)name email:(NSString *)email contact:(NSString *)contact message:(NSString *)message complete:(void (^)(bool success, NSString *returnValue))complete;
+(NSDictionary *)sendSocketEndChatData:(NSString *)chatID csid:(NSString *)csid complete:(void (^)(bool success, NSString *returnValue))complete;

+(void)setSocketVisitor:(NSArray *)data;

/**
 * 尝试将之前短因果报应存于本地的客服id取出来（因为APP可能意外崩溃或关闭），确保
 * 意外情况下再打开时不需要再次排队，从而保证用户体验。
 *
 * 按照现在的客服分配策略：
 * 1）如果第3方公司在使用IM的访客SDK时，没有硬指定客服id（即没有设定固定的csid）则此
 * 访客后绪将进入排队队列，以通常的新访客的形式进行完整的“排队、分配客服、交谈”逻辑；
 * 2）如果已指定csid，表示像淘宝的网站上的旺旺客服一样，直接为每一个访客链接设定要却是
 * 定的客服从而回归传统的客服模式。
 */
//+ (ServicerUidStore *)tryGetStoredServerUid;   //new socket will handle it
//+ (BOOL)hasAllocatedServicer;
@end

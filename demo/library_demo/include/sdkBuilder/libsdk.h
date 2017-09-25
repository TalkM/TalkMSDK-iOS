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

#define talkmEndChatActionID                   1
#define IS_PAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_PHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

@class MainViewController;

@interface libsdk : NSObject 

+(void)initCreateTicketFloot_incorrect:(id)sender view:(UIView *)view tenant:(NSString *)tenant appIDValue:(NSString *)appIDValue;
+(void)initTalkM:(id)sender view:(UIView *)view tenant:(NSString *)tenant appID:(NSString *)appID appSecret:(NSString *)appSecret uiViewController:(UIViewController *)uiViewController;

+(void)showScreen2:(id)sender;

//uiview
+(void)initCustomBackNavigation:(UINavigationController*) navigationController;
+(void)returnParentView: (UINavigationController *) navigationController;
+(Boolean)findActionMessage:(NSString *)actionID;
+(Boolean)findSupportUserDetail:(NSString *)Csid;
+(Boolean)findCompanySetting;

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

+(void)api_updateChatEndTimeByCsid:(NSString *)csid
                               uid:(NSString *)uid;

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
+(void) storeUserDefaultChatEndConv: (NSString *) isChatEndConv chatEndConvText:(NSString *)chatEndConvText chatEndConvType:(NSString *)chatEndConvType;

//+(NSString *)readUserDefault;
+(NSString *)readUserDefaultChatRate;
+(NSString *)readUserDefaultChatEndConv;
+(NSString *)readUserDefaultChatEndConvText;
+(NSString *)readUserDefaultChatEndConvType;

+ (UIColor *)colorFromHexString:(int)color;
+ (UIColor *)colorFromHexString2:(NSString *)hexString;

+ (UIImageView *) imageConvertCircle:(UIImageView *)image;
+(NSString *) getPlistPropertiesValue:(NSString *) propertiesKey;

//IM Checking
+(BOOL)checkCurrentViewIsChatView:(UIViewController *)currentView;

//company auto setting
+(void)clearAllAutoTimeOut;
+(void)clearAutoRespondTimeOut;
+(void)clearAutoEndChatTimeOut;
+(void)clearAutoTransferTimeOut;
    
+(void)resetCustomerCountDown;
+(void)resetVisitorCountDown;
+(void)resetAutoRespondCountDown;
+(void)resetAutoEndChatCountDown;
+(void)resetAutoTransferCountDown;

+(void)performCSEndChat;

//check customer support online status
+(Boolean)findCompanyAgent:(NSString *)csid;

//+(void)startCountDown;

+ (BOOL) validateEmail: (NSString *) emailString ;
+ (BOOL) validateContactlength: (NSString *) contact ;
+ (BOOL) checkNavigationVisible;

//leave message
+(void) storeUserDefaultLeaveMessage:(NSString *)name email:(NSString *)email;
+(NSString *) readUserDefaultLeaveMessageName;


//export chat
//+(BOOL)api_submitExportChatByEmail:(NSString *)email conversactionID:(NSString *)conversactionID;
+(BOOL)api_submitPendingExportChat;
+(void) storeUserDefaultExportEmail: (NSString *) email;
+(NSString *) readUserDefaultLeaveMessageEmail;  //transaction email,will cancel after success sent email
+(NSString *) readUserDefaultDisplayLeaveMessageEmail;

+(BOOL)isIphonePlusDevice;


//mobileIMSDK
//@property (strong, nonatomic) MainViewController *mainViewController;

+ (void)switchToMainViewController;

+ (UIView *) getMainView;
+ (MainViewController *) getMainViewController;
+ (void) refreshConnecteStatus;

+ (void)showToastInfo:(NSString *)content;
+ (void)showToastWarn:(NSString *)content;
+ (void)showToastError:(NSString *)content;
+ (void)showToast:(NSString *)title withContent:(NSString *)content;


//UI handling
//view navigation
+(void)keyboardWillShow: (UIView *)view ;
+(void)keyboardWillHide: (UIView *)view ;

@end

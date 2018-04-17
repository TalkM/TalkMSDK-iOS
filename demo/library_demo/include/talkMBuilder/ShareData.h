//
//  ShareData.h
//  libtest
//
//  Created by Star Systems Internation on 24/11/2016.
//  Copyright © 2016 Star Systems International. All rights reserved.
//


#import <Foundation/Foundation.h>

//prefix
#import <Availability.h>

#ifndef __IPHONE_3_0
#warning "This project uses features only available in iOS SDK 3.0 and later."
#endif

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Default.h"
#import "BasicTool.h"
#import "CocoaLumberjack.h"
#endif
//end prefix

@interface ShareData : NSObject

//default data
@property (retain, nonatomic) NSString *tenantNagivigationExist;
@property (retain, nonatomic) NSString *chatID;
//@property (retain, nonatomic) NSString *tenantDomain;
//@property (retain, nonatomic) NSString *tenantId;
@property (retain, nonatomic) NSString *tenantKey;
@property (retain, nonatomic) NSString *visitorUID;  //ssoreturn.uid
@property (retain, nonatomic) NSString *token;
@property (retain, nonatomic) NSString *tokenType;
@property (retain, nonatomic) NSString *tokenExpiredIn;
@property (retain, nonatomic) NSString *talkMBaseUrl;

@property (retain, nonatomic) NSDictionary *chatSetting;
//@property (retain, nonatomic) NSString *queueNumber;

//restAPI
@property (retain, nonatomic) NSString *restProcess;
@property (retain, nonatomic) NSDictionary *restReturn;
@property (retain, nonatomic) NSString *restReturnStructure;

@property (retain, nonatomic) NSMutableDictionary *actionableObject;

//user profile setting
@property (retain, nonatomic) NSDictionary *userProfile;
@property (retain, nonatomic) NSString *profileDisplayRole;   //cusotmer support or company

//company advertisement
//@property (retain, nonatomic) NSDictionary *companySetting;
@property (retain, nonatomic) NSString *htmlBody;
@property (retain, nonatomic) NSString *advertisementImage;
@property (retain, nonatomic) NSString *advertisementUrl;

@property (retain, nonatomic) NSString *servicerCsId;
@property (retain, nonatomic) NSString *servicerName;
@property (retain, nonatomic) NSString *servicerSignature;
@property (retain, nonatomic) NSString *servicerAvatarType;
@property (retain, nonatomic) NSString *servicerAvatarValue;
@property (retain, nonatomic) NSString *servicerAvatarUrl;
@property (retain, nonatomic) NSString *servicerSwitchFrom;
@property (retain, nonatomic) NSString *isRefreshAvatarNeeded;  //no longer use after socket

//company profile
@property (retain, nonatomic) NSString *fbAppUrl;

//theme color
@property (retain, nonatomic) NSString *themeColor;

//rating
@property (retain, nonatomic) NSString *isRatingEnable;
@property (retain, nonatomic) NSString *lastRatingIndex;
@property (retain, nonatomic) NSString *selectedRate;
@property (retain, nonatomic) NSString *selectedRateMessage;


//rating
@property (retain, nonatomic) NSNumber *chatPowerByBottomConstraint;


//repond text after rate
@property (retain, nonatomic) NSString *ratingRespondText;

//company auto setting
@property (retain, nonatomic) NSDate *lastCustomerReplyDate;
@property (retain, nonatomic) NSDate *lastVisitorReplyDate;
@property (retain, nonatomic) NSString *isAutoRespondDone;
@property (retain, nonatomic) NSString *isAutoTransferDone;
@property (retain, nonatomic) NSString *isAutoEndConvDone;
@property (retain, nonatomic) NSString *isAutoTransferCS;
@property (retain, nonatomic) NSString *isAutoRefreshToken;
@property (retain, nonatomic) NSString *isRatingDone;

//CS end chat
@property (retain, nonatomic) NSString *isCSEndChatDone;  //handle for avoid duplicated call for notification center
@property (retain, nonatomic) NSString *isEndChatSendMessageRequire;  //handle whether to send msg to CS

//export email
@property (retain, nonatomic) NSString *isExportImmediately;

//avatar for cme
@property (retain, nonatomic) UIImage *avatarSmall ;


//bubble
@property (retain, nonatomic) NSString *bubbleMaxWidth;

+ (ShareData *)ShareDataAction ;

//reload Adverticement
@property (retain, nonatomic) NSString *adverticementProcess;
@property (retain, nonatomic) NSString *adverticementWidth;
@property (retain, nonatomic) NSString *adverticementHeight;

//resend
@property (retain, nonatomic) NSString *tappedResendIndex;
@property (retain, nonatomic) NSString *resendStatus;

//top daily label
@property (retain, nonatomic) NSString *isDailySet;

//CS join Bubble
@property (retain, nonatomic) NSString *isCSJoinShow;

//for new appoach
@property (retain, nonatomic) NSString *isNewChat;

//show CS typing indicator
//@property (retain, nonatomic) NSString *isCSTyping;
//@property (retain, nonatomic) NSString *isCSTypingDone;

//for ban user
@property (retain, nonatomic) NSString *isUserBanned;


//chat history
@property (retain, nonatomic) NSDictionary *chatHistory;

//presurvey
@property (retain, nonatomic) NSString *visitorName;
@property (retain, nonatomic) NSString *visitorEmail;
@property (retain, nonatomic) NSString *visitorContact;
@property (retain, nonatomic) NSString *surveyCategory;
@property (retain, nonatomic) NSString *surveyGroupID;
@property (retain, nonatomic) NSString *surveyMessage;
@property (retain, nonatomic) NSString *isSurveyDone;

@end

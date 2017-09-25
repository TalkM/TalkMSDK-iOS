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
@property (retain, nonatomic) NSString *conversactionID;
//@property (retain, nonatomic) NSString *tenantDomain;
//@property (retain, nonatomic) NSString *tenantId;
@property (retain, nonatomic) NSString *tenantKey;
@property (retain, nonatomic) NSString *visitorID;  //ssoreturn.uid
@property (retain, nonatomic) NSString *token;
@property (retain, nonatomic) NSString *tokenType;

//restAPI
@property (retain, nonatomic) NSString *restProcess;
@property (retain, nonatomic) NSDictionary *restReturn;
@property (retain, nonatomic) NSString *restReturnStructure;

@property (retain, nonatomic) NSDictionary *ratingObject;

//user profile setting
@property (retain, nonatomic) NSDictionary *userProfile;
@property (retain, nonatomic) NSString *profileDisplayRole;   //cusotmer support or company

//company advertisement
@property (retain, nonatomic) NSDictionary *companySetting;
@property (retain, nonatomic) NSString *voidCheckingForAdvertisement;
@property (retain, nonatomic) NSString *htmlBody;

@property (retain, nonatomic) NSString *servicerCsId;
@property (retain, nonatomic) NSString *servicerName;
@property (retain, nonatomic) NSString *servicerSignature;
@property (retain, nonatomic) NSString *servicerAvatarType;
@property (retain, nonatomic) NSString *servicerAvatarValue;
@property (retain, nonatomic) NSString *servicerAvatarUrl;

//theme color
@property (retain, nonatomic) NSString *themeColor;

//rating
@property (retain, nonatomic) NSString *isRatingEnable;

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

//CS end chat
@property (retain, nonatomic) NSString *isCSEndChatDone;  //handle for avoid duplicated call for notification center
@property (retain, nonatomic) NSString *isEndChatSendMessageRequire;  //handle whether to send msg to CS

//export email
@property (retain, nonatomic) NSString *isExportImmediately;

//avatar for cme
@property (retain, nonatomic) UIImage *avatarSmall ;

+ (ShareData *)ShareDataAction ;

@end

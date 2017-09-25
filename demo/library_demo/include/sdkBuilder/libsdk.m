//
//  libsdk.m
//  libtest
//
//  Created by Star Systems Internation on 14/11/2016.
//  Copyright © 2016 Star Systems International. All rights reserved.
//

#import "libsdk.h"
#import "ShareData.h"
#import "SSOLoginWrapper.h"
#import "DemoMainViewController.h"
#import "NoAgentViewController.h"

#import "IMLaunchWrapper.h"
#import "ChatViewController.h"

//mobileIMSDK
#import "MainViewController.h"
#import "UIViewController+Ext.h"
#import "Toast+UIView.h"
#import "ClientCoreSDK.h"

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

#ifdef DEBUG
static DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static DDLogLevel ddLogLevel = DDLogLevelInfo;
#endif

#endif
//end prefix

@implementation libsdk

//NSString *_email;
NSString *_appID;;
UIView *_view;
UIViewController *_viewController;
MainViewController *_mainViewController;
id _sender;

//api
//AppDelegate *appDel;

NSString *messageTitle, *messageDesc;
NSData *data;
NSError *nerror;

//mobileimsdk
SSOLoginWrapper *_sso;

//auto setting
NSInteger autoRespondTimeOut;
NSInteger autoEndChatTimeOut;
NSInteger autoTransferTimeOut;
dispatch_block_t autoRespondBlock;
dispatch_block_t autoEndChatBlock;
dispatch_block_t autoTransferBlock;
NSTimer * timerRespond;
NSTimer * timerEndChat;
NSTimer * timerTransfer;

ShareData *sdata;

+(void)initScreen{
    
//    appDel = CurAppDelegate;
//    ShareData *sData = [ShareData ShareDataAction];
}

+(void)showScreen2:(id)sender{
    
    
    //method 1 : return as navigation
/*    
 1. set navigation on the client screen
 2. set storyboard reference to SDK story board (main2)
 3. don set navigation screen on sdk screen
 4. don set story board reference to client story board
 5. fire notification to perform step 2
*/
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"showTicket"
     object:self];
   //end method 1
    
    
    
    
//    //method 2 : return as button
///*
// 1. don set navigation screen on client screen
// 2. set storyboard reference to SDK story board (main2)
// 3. don set navigation screen on sdk screen
// 4. set story board reference to client story board
// 5. setup [initCustomBackNavigation:self.navigationController] on SDK view controller
// 6. click button to perform step 2
// */
//    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main2" bundle:nil];
//    UIViewController* initialHelpView = [storyboard instantiateInitialViewController];
//    
//    initialHelpView.modalPresentationStyle = UIModalPresentationFormSheet;
//    [sender presentModalViewController:initialHelpView animated:YES];  //work and display navigation, but no back button
//
//    //    UIViewController *otherVC = [[UIStoryboard storyboardWithName:@"Main2" bundle:nil] instantiateViewControllerWithIdentifier:@"welcomeView"]; //Or get a VC by its identifier
//    
//    //    [self.navigationController pushViewController:otherVC animated:YES];
//    
//    //    [sender presentViewController:otherVC animated:YES completion:nil];  //work but no back button
//
//    
//    //end method 2
    
    
}

//+(void)initCreateTicketFloot_incorrect:(id)sender view:(UIView *)view tenant:(NSString *)tenant appIDValue:(NSString *)appIDValue{
//    
//    UIImage *listImage = [UIImage imageNamed:@"createticket2.png"];
//    UIButton *btnCreate = [UIButton buttonWithType:UIButtonTypeCustom];
//    btnCreate.frame = CGRectMake(100, 550, 50, 50);
//    //    [goToTop setTitle:@"Create Ticket" forState:UIControlStateNormal];
//    [btnCreate addTarget:self action:@selector(createTicket) forControlEvents:UIControlEventTouchUpInside];
//    [btnCreate setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btnCreate.layer setBorderColor:[[UIColor blackColor] CGColor]];
//    //    goToTop.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
//    
//    [btnCreate setImage:listImage forState:UIControlStateNormal];
//    
//    //    [self.view addSubview:btnCreate];
//    [view addSubview:btnCreate];
//    
//    _sender = sender;
//    _view = view;
//    _tenant = tenant;
//    _appID = appIDValue;
////    _email = email;
//}

#pragma mark - mobile widget

+(void)initTalkM:(id)sender view:(UIView *)view tenant:(NSString *)tenant appID:(NSString *)appID appSecret:(NSString *)appSecret uiViewController:(UIViewController *)uiViewController{
    
//    [uiViewController.navigationController setNavigationBarHidden:NO animated:NO];
//    uiViewController.navigationController.navigationBar.tintColor = [UIColor clearColor];
//    
//    uiViewController.navigationController.navigationBar.backIndicatorImage = nil;
//    uiViewController.navigationController.navigationBar.backgroundColor = nil;
    
    [self setupLog];
    
    sdata = [ShareData ShareDataAction];
    
    //store tenant default Navigation bar visible
    if ([self checkNavigationVisible]){
        sdata.tenantNagivigationExist = @"X";
    }
    else{
        sdata.tenantNagivigationExist = @"";
    }
    
    int navigationBarHeight = uiViewController.navigationController.navigationBar.frame.size.height;
    
    bool isReturnOK = [self findMobileWidget:tenant appIDappSecret:[NSString stringWithFormat:@"%@:%@", appID, appSecret]];
    
    if (isReturnOK){
        
        NSDictionary *postResult = sdata.restReturn;
        postResult = [self ConverterDictionaryByReplacingNullsWithStrings:postResult];
        
        NSDictionary *appearance = [sdata.restReturn objectForKey:@"appearance"];
        NSDictionary *mobile = [appearance objectForKey:@"mobile"];
        BOOL chatEnable = [[postResult objectForKey:@"enabled"] boolValue];
        
        if (chatEnable){
            NSString *layout = nil;
            NSString *color = nil;
            NSString *icon = nil;
            NSString *title = nil;
            NSString *position = nil;
            
            NSDictionary *layoutDic = [mobile objectForKey:@"layout"];
            NSDictionary *positionDic = [mobile objectForKey:@"position"];
            NSDictionary *iconDic = [mobile objectForKey:@"icon"];
            layout = [layoutDic objectForKey:@"value"];
            color = [mobile objectForKey:@"colour"];
            title = [mobile objectForKey:@"title"];
            position = [positionDic objectForKey:@"value"];
            icon = [iconDic objectForKey:@"value"];
            
            //        layout = @"horizontalLayout";
            //        layout = @"circularLayout";
            //        layout = @"verticalLayout";
            //        color = @"#ff0009";
            //        icon = @"bubbleIcon";
            //        icon = @"conversationIcon";
            //        icon = @"questionmarkIcon";
            //        icon = @"clockIcon";
            //        icon = @"personIcon";
            //        icon = @"mailIcon";
            //        position = @"leftBottom";
            //        position = @"rightBottom";
            //        title = @"LIVE CHAT";
            
            if ([layout isEqualToString:@"horizontalLayout"]){
                [self setupFAB:sender view:view tenant:tenant appID:appID appSecret:appSecret uiViewController:uiViewController layout:layout color:color icon:icon position:position buttonText:title];
            }
            else if ([layout isEqualToString:@"circularLayout"]){
                [self setupFAB:sender view:view tenant:tenant appID:appID appSecret:appSecret uiViewController:uiViewController layout:layout color:color icon:icon position:position buttonText:@""];
            }
            else {   //verticalLayout
                [self setupFAB:sender view:view tenant:tenant appID:appID appSecret:appSecret uiViewController:uiViewController layout:layout color:color icon:icon position:position buttonText:title];
            }
        }
    }
    
}

+(void)setupLog{
    // 日志框架的配置
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor greenColor] backgroundColor:nil forFlag:DDLogFlagDebug];
}



+(void)setupFAB:(id)sender view:(UIView *)view tenant:(NSString *)tenant appID:(NSString *)appID appSecret:(NSString *)appSecret uiViewController:(UIViewController *)uiViewController layout:(NSString *)layout color:(NSString *)color icon:(NSString *)icon position:(NSString *)position buttonText:(NSString *)buttonText{
    
    [self initTheme:color];
    
    NSString *drawableImage;
    
    if ([icon isEqualToString:@"bubbleIcon"]){
        drawableImage = @"ic_chat";
    }
    else if ([icon isEqualToString:@"conversationIcon"]){
        drawableImage = @"ic_chat2";
    }
    else if ([icon isEqualToString:@"questionmarkIcon"]){
        drawableImage = @"ic_chat3";
    }
    else if ([icon isEqualToString:@"clockIcon"]){
        drawableImage = @"ic_chat4";
    }
    else if ([icon isEqualToString:@"personIcon"]){
        drawableImage = @"ic_chat5";
    }
    else if ([icon isEqualToString:@"mailIcon"]){
        drawableImage = @"ic_chat6_smaller";
    }
    else{
        drawableImage = @"ic_chat2";
    }
    UIImage *listImage = [UIImage imageNamed:drawableImage];
    
    int backgroundButton_X, backgroundButton_Y, backgroundButton_Height, backgroundButton_Width;
    int windowMarginLeft = 7;
    
    backgroundButton_X = 0;
    backgroundButton_Y = 0;
    backgroundButton_Height = 0;
    backgroundButton_Width = 0;
    
    if ([layout isEqualToString:@"circularLayout"]){
        
        //image width fix same as height (make it square)
        backgroundButton_Height = 40;
        backgroundButton_Width = backgroundButton_Height;
        
        //set button position
        int marginFromBottom = 100;
         backgroundButton_Y = view.bounds.size.height - marginFromBottom;
        
        if ([position isEqualToString:@"leftBottom"]){
            backgroundButton_X = windowMarginLeft;
        }
        else if ([position isEqualToString:@"rightBottom"]){
            backgroundButton_X = view.bounds.size.width - windowMarginLeft - backgroundButton_Width;
        }
    }
    else if ([layout isEqualToString:@"horizontalLayout"]){
        
        //image width base on button text length
        backgroundButton_Height = 30;
        int buttonTextLength = (int) buttonText.length;
        backgroundButton_Width = [self getHorizontalWidth:buttonTextLength];
        
        //set button position (bottom of page)
        backgroundButton_Y = view.bounds.size.height - backgroundButton_Height;
        
        if ([position isEqualToString:@"leftBottom"]){
            backgroundButton_X = 0  + windowMarginLeft;
        }
        else if ([position isEqualToString:@"rightBottom"]){
            backgroundButton_X = view.bounds.size.width - windowMarginLeft - backgroundButton_Width;
        }
    }
    else{
        //image height base on button text length
        int backgroundMarginFromBottom = 33;
        int buttonTextLength = (int) buttonText.length;
        backgroundButton_Height = [self getVerticalHeight:buttonTextLength];
        backgroundButton_Width = 30;
        
        //set button position (bottom of page)
        backgroundButton_Y = view.bounds.size.height - backgroundButton_Height - backgroundMarginFromBottom;
        
        if ([position isEqualToString:@"leftBottom"]){
            backgroundButton_X = 0;
        }
        else if ([position isEqualToString:@"rightBottom"]){
            backgroundButton_X = view.bounds.size.width - backgroundButton_Width;
            
        }
    }
    
    
//    if ([self checkNavigationVisible]){
//        backgroundButton_Y = backgroundButton_Y - 44;
//    }
    
    UIButton *btnWidget = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnWidget addTarget:self action:@selector(abtnLogin) forControlEvents:UIControlEventTouchUpInside];
    [btnWidget setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnWidget.layer setBorderColor:[[UIColor blackColor] CGColor]];
    btnWidget.backgroundColor = [libsdk colorFromHexString2:color]; //talkmdev -send button
    btnWidget.frame = CGRectMake(backgroundButton_X, backgroundButton_Y, backgroundButton_Width, backgroundButton_Height);
    
    
    
    if ([layout isEqualToString:@"circularLayout"]){
        
        //for circle, set image as button background
        [btnWidget setImage:listImage forState:UIControlStateNormal];
        
        //draw circle background
        CGFloat padding = 5;
        [btnWidget setContentEdgeInsets:UIEdgeInsetsMake(padding, padding, padding, padding)];
        btnWidget.layer.cornerRadius = btnWidget.frame.size.width / 2;
        
        [view addSubview:btnWidget];
    }
    else if ([layout isEqualToString:@"horizontalLayout"]){
        
        [view addSubview:btnWidget];
        
        //set button image position
        int marginLeft = 17;
        int buttonImage_x, buttonImage_y, buttonImage_height, buttonImage_width;
        buttonImage_x = backgroundButton_X + marginLeft;
        buttonImage_y = backgroundButton_Y +  (( backgroundButton_Height - listImage.size.height) / 2 ) ;
        buttonImage_height = listImage.size.height;
        buttonImage_width = listImage.size.width;
        
    
        //for horizontalLayout, set image as new imageView
        UIImageView *titleImage=[[UIImageView alloc]initWithFrame:CGRectMake(buttonImage_x, buttonImage_y, buttonImage_width, buttonImage_height)];
        titleImage.image=listImage;
        
        [view addSubview:titleImage];
        
        
        
        //set button text position
        int buttonText_x;
        buttonText_x = backgroundButton_X + listImage.size.width + ( marginLeft * 2);
        
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(buttonText_x, backgroundButton_Y, backgroundButton_Width, backgroundButton_Height )];
        lbl.text = buttonText;
        lbl.textColor = [UIColor whiteColor];
        [lbl setFont:[UIFont fontWithName:@"Helvetica" size:20]];
        [view addSubview:lbl];
        
        
//        NSString *fullString = @"A man Google.com domain.";
//        NSString *linkString = @"Google.com";
//        NSString *urlString = @"http://www.google.com";
//        
//        lbl.attributedText = [self linkedStringFromFullString:fullString withLinkString:linkString andUrlString:urlString];
    }
    else if ([layout isEqualToString:@"verticalLayout"]){
        
        [view addSubview:btnWidget];
        
        //set button image position
        int marginTop = 7;
        int buttonImage_x, buttonImage_y, buttonImage_height, buttonImage_width;
        
        buttonImage_x = backgroundButton_X + ( backgroundButton_Width - listImage.size.width) / 2;
        buttonImage_y = backgroundButton_Y + marginTop;
        buttonImage_height = listImage.size.height;
        buttonImage_width = listImage.size.width;
        
        
        //for horizontalLayout, set image as new imageView
        UIImageView *titleImage=[[UIImageView alloc]initWithFrame:CGRectMake(buttonImage_x, buttonImage_y, buttonImage_width, buttonImage_height)];
        titleImage.image=listImage;
        
        [view addSubview:titleImage];

        
        //set button text position
        NSString *singleText = @"1";  //get single text height and width
        UIFont *font = [UIFont fontWithName:@"Helvetica" size:17];
        NSDictionary *userAttributes = @{NSFontAttributeName: font,
                                         NSForegroundColorAttributeName: [UIColor blackColor]};
        CGSize singleTextSize = [singleText sizeWithAttributes:userAttributes] ;
        
        int buttonText_x, buttonText_y;
//        int defaultUilabelHeight = 10;  //uilabel consist of gap from top by default
        buttonText_x = backgroundButton_X + ( (backgroundButton_Width - singleTextSize.width ) / 2 );
        buttonText_y = backgroundButton_Y + buttonImage_height + (marginTop * 2);
        
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(buttonText_x, buttonText_y, backgroundButton_Width, backgroundButton_Height )];
        lbl.numberOfLines = 0;
        lbl.text = [self getVerticalText:buttonText];
        lbl.textColor = [UIColor whiteColor];
//        lbl.backgroundColor = [UIColor cyanColor];
        [lbl setFont:[UIFont fontWithName:@"Helvetica" size:20]];
        [lbl sizeToFit];
        [view addSubview:lbl];
    }
    
    _sender = sender;
    _view = view;
    sdata.tenantKey = tenant;
    _appID = [NSString stringWithFormat:@"%@:%@", appID, appSecret];
    _viewController = uiViewController;
    
//    ShareData *sdata = [ShareData ShareDataAction];
//    sdata.tenantDomain = tenant;
}

+(int)getHorizontalWidth:(int) charLength{
    int size = 80;
    
    NSString *singleText = @"1";  //get single text height and width
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:20];
    NSDictionary *userAttributes = @{NSFontAttributeName: font,
                                     NSForegroundColorAttributeName: [UIColor blackColor]};
    CGSize singleTextSize = [singleText sizeWithAttributes:userAttributes] ;
    
    if (charLength == 0){
        size = 68;
    }
    else{
        size = size + (singleTextSize.width * charLength);
    }
    
    
//    switch (charLength) {
//        case 1:
//            width = 80;
//            break;
//        case 2:
//            width = 90;
//            break;
//        case 3:
//            width = 70;
//            break;
//        case 4:
//            width = 85;
//            break;
//        case 5:
//            width = 100;
//            break;
//        case 6:
//            width = 115;
//            break;
//        case 7:
//            width = 130;
//            break;
//        case 8:
//            width = 145;
//            break;
//        case 9:
//            width = 160;
//            break;
//        case 10:
//            width = 140;
//            break;
//        case 11:
//            width = 150;
//            break;
//        case 12:
//            width = 160;
//            break;
//        case 13:
//            width = 170;
//            break;
//        case 14:
//            width = 180;
//            break;
//        case 15:
//            width = 190;
//            break;
//        case 16:
//            width = 200;
//            break;
//        case 17:
//            width = 210;
//            break;
//        case 18:
//            width = 220;
//            break;
//        case 19:
//            width = 230;
//            break;
//        case 20:
//            width = 240;
//            break;
//        default:
//            width = 240;
//            break;
//    }
    
    return size;
}

+(int)getVerticalHeight:(int) charLength{
    int size = 50;
    
    NSString *singleText = @"1";  //get single text height and width
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:20];
    NSDictionary *userAttributes = @{NSFontAttributeName: font,
                                     NSForegroundColorAttributeName: [UIColor blackColor]};
    CGSize singleTextSize = [singleText sizeWithAttributes:userAttributes] ;
    
    size = size + (singleTextSize.height * charLength);
    
//    switch (charLength) {
//        case 1:
//            size = 60;
//            break;
//        case 2:
//            size = 80;
//            break;
//        case 3:
//            size = 100;
//            break;
//        case 4:
//            size = 120;
//            break;
//        case 5:
//            size = 140;
//            break;
//        case 6:
//            size = 160;
//            break;
//        case 7:
//            size = 180;
//            break;
//        case 8:
//            size = 200;
//            break;
//        case 9:
//            size = 220;
//            break;
//        case 10:
//            size = 240;
//            break;
//        case 11:
//            size = 260;
//            break;
//        case 12:
//            size = 280;
//            break;
//        case 13:
//            size = 300;
//            break;
//        case 14:
//            size = 320;
//            break;
//        case 15:
//            size = 340;
//            break;
//        case 16:
//            size = 360;
//            break;
//        case 17:
//            size = 380;
//            break;
//        case 18:
//            size = 400;
//            break;
//        case 19:
//            size = 420;
//            break;
//        case 20:
//            size = 440;
//            break;
//        default:
//            size = 440;
//            break;
//    }
    
    return size;
}

+(NSString *)getVerticalText:(NSString *)buttonText{
    
    NSString *newTextWithLine = @"";
    
    for (int i=0; i<buttonText.length; i++){
        char singleText = [buttonText characterAtIndex:i];
        
        if (newTextWithLine.length == 0){
            newTextWithLine = [NSString stringWithFormat:@"%c", singleText] ;
        }
        else{
            newTextWithLine = [NSString stringWithFormat:@"%@\n%c", newTextWithLine, singleText] ;
        }
    }
    
    return newTextWithLine;
}


+(void)initTheme:(NSString *)themeColor{
    ShareData *sdata = [ShareData ShareDataAction];
    sdata.themeColor = themeColor;
}

//+(void)createTicket{
//    
//    [self initScreen];  //for testing
//    
//    if ([self tokenLoginValidation2:_tenant appIDValue:_appID]){
//        
//        NSLog(@"login validation success");
//        
//        [self showScreen2:_sender];
//        
//        [self showMessageWithType:messageTitle message:messageDesc buttonTitle:@"OK" errorType:@""];
//    }
//    else{
//        NSLog(@"token authorization failed");
//    }
//}


+(void)abtnLogin{
    
    [self initScreen];  //for testing
    
    [self initCountDown];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self startCountDown];
//    });
    
//    if ([self tokenLoginValidation:sdata.tenantKey appIDValue:_appID]){
    
        NSLog(@"login validation success");
        
        BOOL isAgentOnline = [self findCompanyAgent:nil];
        
//        isAgentOnline = NO;
    
        if (isAgentOnline){
            [self callTalkmIM];
        }
        else{
            
            //get no agent setting
            [libsdk findOfflineSettingByAppID:_appID];
            
            //show no agent screen
            _sso = [[SSOLoginWrapper alloc] initWith:_viewController showProgress:YES];
            
            [_sso gotoNoChatViewController];
        }
        
        
////        [self showScreen2:_sender2];
////
////        [self showMessageWithType:messageTitle message:messageDesc buttonTitle:@"OK" errorType:@""];
//    }
//    else{
//        NSLog(@"token authorization failed");
//    }
}

#pragma mark - talkm user authentication
+(BOOL)tokenLoginValidation:(NSString *)tenant appIDValue:(NSString *)appIDValue{
    BOOL isRestAPIOK = NO;
    ShareData *sData = [ShareData ShareDataAction];
    
    [self findEnterpriseLoginByUserPasswordTenant:tenant appIDappSecret:appIDValue];
    
    //    [self findLoginByUserPasswordTenant:@"support@talkm.com" password:@"password" tenant:@"tenant1"];
    
    if ([sData.restProcess isEqualToString:@"E"]){
        [self showMessageWithType:@"" message:sData.restReturnStructure buttonTitle:@"OK" errorType:@"E"];
    }
    else if ([sData.restProcess isEqualToString:@"D"]){
        
        NSDictionary *postResult = sData.restReturn;
        
        //        NSString *token = [[postResult objectForKey:@"accessToken"] stringValue];
        
        NSString *token, *scope, *errorTitle, *errorDesc;
        
        if ([postResult objectForKey:@"error"]){
            errorTitle = [postResult objectForKey:@"error"];
        }
        
        if ([postResult objectForKey:@"errorDescription"]){
            errorDesc = [postResult objectForKey:@"errorDescription"];
        }
        
        if (errorDesc.length > 0){
            messageTitle = errorTitle;
            messageDesc = errorDesc;
            [self showMessageWithType:messageTitle message:messageDesc buttonTitle:@"OK" errorType:@"E"];
        }
        else{
            
            messageTitle = @"";
            messageDesc = @"Login Success";
            
            //            [Utilities showMessage:token message:scope];
            
//            sData.tenantId = [postResult objectForKey:@"tenantId"];
            sData.tenantKey = [postResult objectForKey:@"tenantKey"];
            sData.tokenType = [postResult objectForKey:@"tokenType"];
//            sData.themeColor = @"2258af";   //talkmBlue
            
            
            isRestAPIOK = YES;
        }
        
    }
    else{
        messageTitle = @"Error";
        messageDesc = @"Login Validation Failed";
        
        [self showMessageWithType:messageTitle message:messageDesc buttonTitle:@"OK" errorType:@"E"];
    }
    
    return isRestAPIOK;
}

+(void)callTalkmIM{
    
//    ShareData *sData = [ShareData ShareDataAction];
//    NSDictionary *postResult = sData.restReturn;
    
    // 实例化Talkm的SSO单点登陆接口封装实现对象
    _sso = [[SSOLoginWrapper alloc] initWith:_viewController showProgress:YES];
    
//    [_sso openIM:@"2cad7a38-ffb1-11e6-bfaa-080027e52f64"   // 公司（租访）的唯一id，本参数不可为空
//             tel:@"18013179220"        // 客户的电话，非必须参数
//            mail:@"jack.jiang@xx.com"]; // 客户的邮箱，非必须参数
    
//    tenantKey = [NSString stringWithFormat:@"%@%@", @"498dec73-ff15-11e6-b9f2-0242ac130008", @""];
    
    
    [_sso openIM:sdata.tenantKey   // 公司（租访）的唯一id，本参数不可为空
             tel:nil        // 客户的电话，非必须参数
            mail:nil
         appName:@"Crazy APP"           // 使用SDK的用户自已设定的他的APP名，由Shihao 201707月提出添加，非必须参数
          appVer:@"1.2"                 // 使用SDK的用户自已设定的他的APP版本，由Shihao 201707月提出添加，非必须参数
     ]; // 客户的邮箱，非必须参数
}


#pragma mark - talkm API

+(Boolean)findCompanyAgent:(NSString *)csid{
    
    //if csid != null, check the specific customer support online status
    //if csid is nil, get all the online customer support number
    
    Boolean isRestAPIOK = NO;
    
    ShareData *sData = [ShareData ShareDataAction];
    
    [self findCompanyOnlineAgentByCsid:csid];
    
    if ([sData.restProcess isEqualToString:@"E"]){
        [self showMessageWithType:@"" message:sData.restReturnStructure buttonTitle:@"OK" errorType:@"E"];
    }
    else if ([sData.restProcess isEqualToString:@"D"]){
        
        NSDictionary *postResult = sData.restReturn;
        
        postResult = [self ConverterDictionaryByReplacingNullsWithStrings:postResult];
        
        
        NSInteger onlineAgent = [[postResult objectForKey:@"returnValue"] integerValue];
        
        NSLog(@"***** Number of online agent : %i", onlineAgent);
        
        if (onlineAgent > 0){
            isRestAPIOK = YES;
        }
    }
    else{
        messageTitle = @"Error";
        messageDesc = @"Login Validation Failed";
        
        [self showMessageWithType:messageTitle message:messageDesc buttonTitle:@"OK" errorType:@"E"];
    }
    
    return isRestAPIOK;
    
}

+(void)findCompanyOnlineAgentByCsid:(NSString *)csid{
    
    NSString *baseUrl = [self getPlistPropertiesValue:@"TalkMBaseUrl"];
    
    NSString *url3 = @"";
    
    if (csid != nil){
        
        url3 = [NSString stringWithFormat:@"%@get?processor_id=1012&job_id=12&action_id=22&company_id=%@&csid=%@", SERVER_CONTROLLER_URL_ROOT, sdata.tenantKey, csid];
    }
    else{
        
        url3 = [NSString stringWithFormat:@"%@get?processor_id=1012&job_id=12&action_id=8&company_id=%@",SERVER_CONTROLLER_URL_ROOT, sdata.tenantKey];
        
    }
    
    ShareData *sData = [ShareData ShareDataAction];
    sData.restProcess = @"P";  //pending
    
    NSHTTPURLResponse *response = [self postRestSynchronousBody:url3 method:@"GET" authorization:@"" jsonData:nil];
    
    if ([response respondsToSelector:@selector(allHeaderFields)]) {
        
        NSInteger statusCode = response.statusCode;
        
        NSLog(@"%i", response.statusCode);
        
        if (statusCode == 200 || statusCode == 201 || statusCode == 202 || statusCode == 500){
            // OK
            if (data.length > 0 && nerror == nil){
                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:NULL];
                
                if (result == nil){
                    //            NSString *error = [[data2.bytes] Stringvalue;
                }
                else{
                    //                    AppDelegate *a = CurAppDelegate;
                    sData.restReturn = result;
                    sData.restProcess = @"D";  //done
                }
            }
        }
        else{
            
            [self restErrorReturnCode:statusCode];
        }
    }
}

+(Boolean)findMobileSetting:(NSString *)tenant appIDappSecret:(NSString *)appIDappSecret{
    Boolean isRestAPIOK = NO;
    
    ShareData *sData = [ShareData ShareDataAction];
    
    [self findMobileSettingByAppID:appIDappSecret tenantValue:tenant];
    
    if ([sData.restProcess isEqualToString:@"E"]){
        [self showMessageWithType:@"" message:sData.restReturnStructure buttonTitle:@"OK" errorType:@"E"];
    }
    else if ([sData.restProcess isEqualToString:@"D"]){
        
        NSDictionary *postResult = sData.restReturn;
        
        postResult = [self ConverterDictionaryByReplacingNullsWithStrings:postResult];
        
        //        NSString *token = [[postResult objectForKey:@"accessToken"] stringValue];
        
        NSString *token, *scope, *errorTitle, *errorDesc;
        
        if ([postResult objectForKey:@"error"]){
            errorTitle = [postResult objectForKey:@"error"];
        }
        
        if ([postResult objectForKey:@"errorDescription"]){
            errorDesc = [postResult objectForKey:@"errorDescription"];
        }
        
        if (errorDesc.length > 0){
            messageTitle = errorTitle;
            messageDesc = errorDesc;
            [self showMessageWithType:messageTitle message:messageDesc buttonTitle:@"OK" errorType:@"E"];
        }
        else{
            
            messageTitle = @"";
            messageDesc = @"Login Success";
            
            isRestAPIOK = YES;
        }
        
    }
    else{
        messageTitle = @"Error";
        messageDesc = @"Login Validation Failed";
        
        [self showMessageWithType:messageTitle message:messageDesc buttonTitle:@"OK" errorType:@"E"];
    }
    
    return isRestAPIOK;
    
}


+(void)findMobileSettingByAppID:(NSString *)appIDappSecret
                    tenantValue:(NSString *)tenantValue{
    
    NSString *baseUrl = [self getPlistPropertiesValue:@"TalkMBaseUrl"];
    
    NSString *url3 = [NSString stringWithFormat:@"https://%@.%@/api/chats/settings", tenantValue, baseUrl];
    
    //?expand=requester
    
    NSString *appIDEncoded = [self convertBased64Encode:appIDappSecret];
    
    NSString *authorization = [NSString stringWithFormat:@"Basic %@", appIDEncoded];
    
    ShareData *sData = [ShareData ShareDataAction];
    sData.restProcess = @"P";  //pending
    
    NSHTTPURLResponse *response = [self postRestSynchronousBody:url3 method:@"GET" authorization:authorization jsonData:nil];
    
    if ([response respondsToSelector:@selector(allHeaderFields)]) {
        
        NSInteger statusCode = response.statusCode;
        
        NSLog(@"%i", response.statusCode);
        
        if (statusCode == 200 || statusCode == 201 || statusCode == 202 || statusCode == 500){
            // OK
            if (data.length > 0 && nerror == nil){
                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:NULL];
                
                if (result == nil){
                    //            NSString *error = [[data2.bytes] Stringvalue;
                }
                else{
                    //                    AppDelegate *a = CurAppDelegate;
                    sData.restReturn = result;
                    sData.restProcess = @"D";  //done
                }
            }
        }
        else{
            
            [self restErrorReturnCode:statusCode];
        }
    }
}

+(Boolean)findMobileWidget:(NSString *)tenant appIDappSecret:(NSString *)appIDappSecret{
    Boolean isRestAPIOK = NO;
    
    ShareData *sData = [ShareData ShareDataAction];
    
    [self findMobileWidgetByAppID:appIDappSecret tenantValue:tenant];
    
    if ([sData.restProcess isEqualToString:@"E"]){
        [self showMessageWithType:@"" message:sData.restReturnStructure buttonTitle:@"OK" errorType:@"E"];
    }
    else if ([sData.restProcess isEqualToString:@"D"]){
        
        NSDictionary *postResult = sData.restReturn;
        
        postResult = [self ConverterDictionaryByReplacingNullsWithStrings:postResult];
        
        //        NSString *token = [[postResult objectForKey:@"accessToken"] stringValue];
        
        NSString *token, *scope, *errorTitle, *errorDesc;
        
        if ([postResult objectForKey:@"error"]){
            errorTitle = [postResult objectForKey:@"error"];
            
            if ([errorTitle isEqualToString:@"bad_credential"]){
                errorTitle = @"Login Error";
            }
        }
        
        if ([postResult objectForKey:@"errorDescription"]){
            errorDesc = [postResult objectForKey:@"errorDescription"];
        }
        
        if (errorDesc.length > 0){
            messageTitle = errorTitle;
            messageDesc = errorDesc;
            [self showMessageWithType:messageTitle message:messageDesc buttonTitle:@"OK" errorType:@"E"];
        }
        else{
            
            messageTitle = @"";
            messageDesc = @"Login Success";
            
            isRestAPIOK = YES;
        }
        
    }
    else{
        messageTitle = @"Error";
        messageDesc = @"Login Validation Failed";
        
        [self showMessageWithType:messageTitle message:messageDesc buttonTitle:@"OK" errorType:@"E"];
    }
    
    return isRestAPIOK;
    
}


+(void)findMobileWidgetByAppID:(NSString *)appIDappSecret
                   tenantValue:(NSString *)tenantValue{
    
    NSString *baseUrl = [self getPlistPropertiesValue:@"TalkMBaseUrl"];
    
    NSString *url3 = [NSString stringWithFormat:@"https://%@.%@/api/chats/settings?expand=appearance", tenantValue, baseUrl];
    
    NSString *appIDEncoded = [self convertBased64Encode:appIDappSecret];
    
    NSString *authorization = [NSString stringWithFormat:@"Basic %@", appIDEncoded];
    
    ShareData *sData = [ShareData ShareDataAction];
    sData.restProcess = @"P";  //pending
    
    NSHTTPURLResponse *response = [self postRestSynchronousBody:url3 method:@"GET" authorization:authorization jsonData:nil];
    
    if ([response respondsToSelector:@selector(allHeaderFields)]) {
        
        NSInteger statusCode = response.statusCode;
        
        NSLog(@"%i", response.statusCode);
        
        if (statusCode == 200 || statusCode == 201 || statusCode == 202 || statusCode == 500 || statusCode == 400){
            // OK
            if (data.length > 0 && nerror == nil){
                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:NULL];
                
                if (result == nil){
                    //            NSString *error = [[data2.bytes] Stringvalue;
                }
                else{
                    //                    AppDelegate *a = CurAppDelegate;
                    sData.restReturn = result;
                    sData.restProcess = @"D";  //done
                }
            }
        }
        else{
            
            [self restErrorReturnCode:statusCode];
        }
    }
}

+(void)findOfflineSettingByAppID:(NSString *)appIDappSecret{
    
    NSString *baseUrl = [self getPlistPropertiesValue:@"TalkMBaseUrl"];
    
    //    NSString *url3 = [NSString stringWithFormat:@"https://%@.%@/api/chats/appearances/mobile", tenantValue, baseUrl];
    
    NSString *url3 = [NSString stringWithFormat:@"https://%@.%@/api/chats/settings?expand=offlineMessage", sdata.tenantKey, baseUrl];
    
    NSString *appIDEncoded = [self convertBased64Encode:appIDappSecret];
    
    NSString *authorization = [NSString stringWithFormat:@"Basic %@", appIDEncoded];
    
    ShareData *sData = [ShareData ShareDataAction];
    sData.restProcess = @"P";  //pending
    
    NSHTTPURLResponse *response = [self postRestSynchronousBody:url3 method:@"GET" authorization:authorization jsonData:nil];
    
    if ([response respondsToSelector:@selector(allHeaderFields)]) {
        
        NSInteger statusCode = response.statusCode;
        
        NSLog(@"%i", response.statusCode);
        
        if (statusCode == 200 || statusCode == 201 || statusCode == 202 || statusCode == 500){
            // OK
            if (data.length > 0 && nerror == nil){
                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:NULL];
                
                if (result == nil){
                    //            NSString *error = [[data2.bytes] Stringvalue;
                }
                else{
                    //                    AppDelegate *a = CurAppDelegate;
                    sData.companySetting = result;
                    sData.restProcess = @"D";  //done
                }
            }
        }
        else{
            
            [self restErrorReturnCode:statusCode];
        }
    }
}

+(void)findEnterpriseLoginByUserPasswordTenant:(NSString *)tenant appIDappSecret:(NSString *)appIDappSecret{
    
    NSString *baseUrl = [self getPlistPropertiesValue:@"TalkMBaseUrl"];
    
    NSString *url3 = [NSString stringWithFormat:@"https://%@.%@/oauth/token", tenant, baseUrl];
    
    NSString *appIDEncoded = [self convertBased64Encode:appIDappSecret];
    
//    NSString *authorization = @"Basic aW9zLWFwcC1pZDppb3MtYXBwLXNlY3JldA==";
    
    NSString *authorization = [NSString stringWithFormat:@"Basic %@", appIDEncoded];
    
//    AppDelegate *a = CurAppDelegate;
    ShareData *sData = [ShareData ShareDataAction];
    sData.restProcess = @"P";  //pending
    
    //json body
    NSError *nerrorJson = nil;
    NSArray *keys = [NSArray arrayWithObjects:@"grantType", nil];
    NSArray *objects = [NSArray arrayWithObjects:@"client", nil];
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:&nerrorJson];
    
    NSHTTPURLResponse *response = [self postRestSynchronousBody:url3 method:@"POST" authorization:authorization jsonData:jsonData];
    
    if ([response respondsToSelector:@selector(allHeaderFields)]) {
        
        NSInteger statusCode = response.statusCode;
        
        NSLog(@"%i", response.statusCode);
        
        if (statusCode == 200 || statusCode == 201 || statusCode == 202 || statusCode == 500){
            // OK
            if (data.length > 0 && nerror == nil){
                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:NULL];
                
                if (result == nil){
                    //            NSString *error = [[data2.bytes] Stringvalue;
                }
                else{
//                    AppDelegate *a = CurAppDelegate;
                    sData.restReturn = result;
                    sData.restProcess = @"D";  //done
                    NSLog([NSString stringWithFormat:@"talkm tenantKey : %@", [result objectForKey:@"tenantKey"]]);
                }
            }
        }
        else{
            
            [self restErrorReturnCode:statusCode];
        }
    }
}

+(void)findLoginByUserPasswordTenant: (NSString *)email password:(NSString *)password tenant:(NSString *)tenant{
    
    NSString *baseUrl = [self getPlistPropertiesValue:@"TalkMBaseUrl"];
    
    NSString *url3 = [NSString stringWithFormat:@"https://%@.&@/oauth/token", tenant, baseUrl];
    
    NSString *authorization = @"Basic YXBwLWlkOmFwcC1zZWNyZXQ=";
    
//    AppDelegate *a = CurAppDelegate;
    ShareData *sData = [ShareData ShareDataAction];
    sData.restProcess = @"P";  //pending
    
    //json body
    NSError *nerrorJson = nil;
    NSArray *keys, *objects;
    
    
    keys = [NSArray arrayWithObjects:@"grantType", @"email", @"password", nil];
    objects = [NSArray arrayWithObjects:@"password", email, password, nil];
    
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:&nerrorJson];
    
    NSHTTPURLResponse *response = [self postRestSynchronousBody:url3 method:@"POST" authorization:authorization jsonData:jsonData];
    
    if ([response respondsToSelector:@selector(allHeaderFields)]) {
        
        NSInteger statusCode = response.statusCode;
        
        NSLog(@"%i", response.statusCode);
        
        if (statusCode == 200){
            // OK
            if (data.length > 0 && nerror == nil){
                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:NULL];
                
                if (result == nil){
                    //            NSString *error = [[data2.bytes] Stringvalue;
                }
                else{
//                    AppDelegate *a = CurAppDelegate;
                    sData.restReturn = result;
                    sData.restProcess = @"D";  //done
                }
            }
        }
        else{
            
            [self restErrorReturnCode:statusCode];
        }
    }
}

+(Boolean)findSupportUserDetail:(NSString *)Csid{
    Boolean isRestAPIOK = NO;
    
    ShareData *sData = [ShareData ShareDataAction];
    
    [self findSupportUserDetailByCsid:Csid];
    
    if ([sData.restProcess isEqualToString:@"E"]){
        [self showMessageWithType:@"" message:sData.restReturnStructure buttonTitle:@"OK" errorType:@"E"];
    }
    else if ([sData.restProcess isEqualToString:@"D"]){
        
        NSDictionary *postResult = sData.restReturn;
        
        postResult = [self ConverterDictionaryByReplacingNullsWithStrings:postResult];
        
        //        NSString *token = [[postResult objectForKey:@"accessToken"] stringValue];
        
        NSString *token, *scope, *errorTitle, *errorDesc;
        
        if ([postResult objectForKey:@"error"]){
            errorTitle = [postResult objectForKey:@"error"];
        }
        
        if ([postResult objectForKey:@"errorDescription"]){
            errorDesc = [postResult objectForKey:@"errorDescription"];
        }
        
        if (errorDesc.length > 0){
            messageTitle = errorTitle;
            messageDesc = errorDesc;
            [self showMessageWithType:messageTitle message:messageDesc buttonTitle:@"OK" errorType:@"E"];
        }
        else{
            
            messageTitle = @"";
            messageDesc = @"Login Success";
            
            sData.userProfile = postResult;  //change to locally
            
            //            [Utilities showMessage:token message:scope];
            
//            NSDictionary *csUser = [sData.restReturn objectForKey:@"user"];   //for user api
            //NSDictionary *csUserSignatureField = [csUser objectForKey:@"fields"];  //for user api
            NSDictionary *csUserSignatureField = [sData.restReturn objectForKey:@"fields"];  //for agent api
            //NSDictionary *csUserAvatar = [csUser objectForKey:@"avatar"];  //for user api
            NSDictionary *csUserAvatar = [sData.restReturn objectForKey:@"avatar"];  //for agent api
            NSDictionary *csUserAvatarType = [csUserAvatar objectForKey:@"type"];
            
            NSString *csId = [sData.restReturn objectForKey:@"uid"];
//            NSString *servicerName = [csUser objectForKey:@"name"];
            NSString *servicerName = [sData.restReturn objectForKey:@"name"];
            NSString *servicerSignature = [csUserSignatureField objectForKey:@"signature"];
            NSString *servicerAvatarType = [csUserAvatarType objectForKey:@"value"];
            NSString *servicerAvatarValue = [csUserAvatar objectForKey:@"value"];
            NSString *servicerAvatarUrl = [csUserAvatar objectForKey:@"url"];
            
            csId               = [self ConverterStringByReplacingNullsWithStrings:csId];
            servicerName       = [self ConverterStringByReplacingNullsWithStrings:servicerName];
            servicerSignature  = [self ConverterStringByReplacingNullsWithStrings:servicerSignature];
            servicerAvatarType = [self ConverterStringByReplacingNullsWithStrings:servicerAvatarType];
            servicerAvatarValue = [self ConverterStringByReplacingNullsWithStrings:servicerAvatarValue];
            servicerAvatarUrl = [self ConverterStringByReplacingNullsWithStrings:servicerAvatarUrl];
            
            servicerAvatarValue = [servicerAvatarValue stringByReplacingOccurrencesOfString: @"-" withString:@""];
            
//            [self saveServicer:csId servicerName:csName servicerAvatarType:csAvatarType servicerAvatarValue:csAvatarValue servicerAvatarUrl:csAvatarUrl servicerSignature:csSignature];
            
//            [self storeUserDefault:Csid servicerName:servicerName servicerAvatarType:servicerAvatarType servicerAvatarValue:servicerAvatarValue servicerAvatarUrl:servicerAvatarUrl servicerSignature:servicerSignature];
            
            sData.servicerCsId = csId;
            sData.servicerName = servicerName;
            sData.servicerSignature = servicerSignature;
            sData.servicerAvatarType = servicerAvatarType;
            sData.servicerAvatarValue = servicerAvatarValue;
            sData.servicerAvatarUrl = servicerAvatarUrl;
            
            isRestAPIOK = YES;
        }
        
    }
    else{
        messageTitle = @"Error";
        messageDesc = @"Login Validation Failed";
        
        [self showMessageWithType:messageTitle message:messageDesc buttonTitle:@"OK" errorType:@"E"];
    }
    
    return isRestAPIOK;
    
}

+(void)findSupportUserDetailByCsid:(NSString *)Csid{
    
    NSString *baseUrl = [self getPlistPropertiesValue:@"TalkMBaseUrl"];
    
    NSString *url3 = [NSString stringWithFormat:@"https://%@.%@/api/chats/agents/%@", sdata.tenantKey, baseUrl, Csid];
    
    NSString *authorization = [NSString stringWithFormat:@"%@ %@", sdata.tokenType, sdata.token];
    
    ShareData *sData = [ShareData ShareDataAction];
    sData.restProcess = @"P";  //pending
    
    NSHTTPURLResponse *response = [self postRestSynchronousBody:url3 method:@"GET" authorization:authorization jsonData:nil];
    
    if ([response respondsToSelector:@selector(allHeaderFields)]) {
        
        NSInteger statusCode = response.statusCode;
        
        NSLog(@"%i", response.statusCode);
        
        if (statusCode == 200 || statusCode == 201 || statusCode == 202 || statusCode == 500){
            // OK
            if (data.length > 0 && nerror == nil){
                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:NULL];
                
                if (result == nil){
                    //            NSString *error = [[data2.bytes] Stringvalue;
                }
                else{
                    //                    AppDelegate *a = CurAppDelegate;
                    sData.restReturn = result;
                    sData.restProcess = @"D";  //done
                }
            }
        }
        else{
            
            [self restErrorReturnCode:statusCode];
        }
    }
}

+(Boolean)findActionMessage:(NSString *)actionID{
    Boolean isRestAPIOK = NO;
    
    ShareData *sData = [ShareData ShareDataAction];
    
    [self findActionMessageByActionID:actionID];
    
    if ([sData.restProcess isEqualToString:@"E"]){
        [self showMessageWithType:@"" message:sData.restReturnStructure buttonTitle:@"OK" errorType:@"E"];
    }
    else if ([sData.restProcess isEqualToString:@"D"]){
        
        NSDictionary *postResult = sData.restReturn;
        
        //        NSString *token = [[postResult objectForKey:@"accessToken"] stringValue];
        
        NSString *token, *scope, *errorTitle, *errorDesc;
        
        if ([postResult objectForKey:@"error"]){
            errorTitle = [postResult objectForKey:@"error"];
        }
        
        if ([postResult objectForKey:@"errorDescription"]){
            errorDesc = [postResult objectForKey:@"errorDescription"];
        }
        
        if (errorDesc.length > 0){
            messageTitle = errorTitle;
            messageDesc = errorDesc;
            [self showMessageWithType:messageTitle message:messageDesc buttonTitle:@"OK" errorType:@"E"];
        }
        else{
            
            messageTitle = @"";
            messageDesc = @"Login Success";
            
            //            [Utilities showMessage:token message:scope];
            
            isRestAPIOK = YES;
        }
        
    }
    else{
        messageTitle = @"Error";
        messageDesc = @"Login Validation Failed";
        
        [self showMessageWithType:messageTitle message:messageDesc buttonTitle:@"OK" errorType:@"E"];
    }
    
    return isRestAPIOK;
    
}

+(void)findActionMessageByActionID:(NSString *)actionID{
    
    NSString *baseUrl = [self getPlistPropertiesValue:@"TalkMBaseUrl"];
    
    NSString *url3 = [NSString stringWithFormat:@"https://%@.%@/api/actionMessages/%@", sdata.tenantKey, baseUrl, actionID];
    
    ShareData *sData = [ShareData ShareDataAction];
    sData.restProcess = @"P";  //pending
    
    NSHTTPURLResponse *response = [self postRestSynchronousBody:url3 method:@"GET" authorization:@"" jsonData:nil];
    
    if ([response respondsToSelector:@selector(allHeaderFields)]) {
        
        NSInteger statusCode = response.statusCode;
        
        NSLog(@"%i", response.statusCode);
        
        if (statusCode == 200 || statusCode == 201 || statusCode == 202 || statusCode == 500){
            // OK
            if (data.length > 0 && nerror == nil){
                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:NULL];
                
                if (result == nil){
                    //            NSString *error = [[data2.bytes] Stringvalue;
                }
                else{
                    //                    AppDelegate *a = CurAppDelegate;
                    sData.ratingObject = result;
                    sData.restProcess = @"D";  //done
                }
            }
        }
        else{
            
            [self restErrorReturnCode:statusCode];
        }
    }
}

+(BOOL)submitRatingByConversactionID:(NSString *)conversactionID ratingID:(NSString *)ratingID{
    BOOL isRestAPIOK = NO;
    ShareData *sData = [ShareData ShareDataAction];
    
    [self api_submit_rating_new:conversactionID ratingID:ratingID];
    
    if ([sData.restProcess isEqualToString:@"E"]){
        [self showMessageWithType:@"" message:sData.restReturnStructure buttonTitle:@"OK" errorType:@"E"];
    }
    else if ([sData.restProcess isEqualToString:@"D"]){
        
        NSDictionary *postResult = sData.restReturn;
        
        //        NSString *token = [[postResult objectForKey:@"accessToken"] stringValue];
        
        NSString *token, *scope, *errorTitle, *errorDesc;
        
        if ([postResult objectForKey:@"error"]){
            errorTitle = [postResult objectForKey:@"error"];
        }
        
        if ([postResult objectForKey:@"errorDescription"]){
            errorDesc = [postResult objectForKey:@"errorDescription"];
        }
        
        if (errorDesc.length > 0){
            messageTitle = errorTitle;
            messageDesc = errorDesc;
            [self showMessageWithType:messageTitle message:messageDesc buttonTitle:@"OK" errorType:@"E"];
        }
        else{
            
            messageTitle = @"";
            messageDesc = @"Rating Success";
            
            //            [Utilities showMessage:token message:scope];
            
            isRestAPIOK = YES;
            
            [self storeUserDefaultChatRate:@"X"];
        }
        
    }
    else{
        messageTitle = @"Error";
        messageDesc = @"Rating Failed";
        
        [self showMessageWithType:messageTitle message:messageDesc buttonTitle:@"OK" errorType:@"E"];
    }
    
    return isRestAPIOK;
    
}


+(void)api_submit_rating_new:(NSString *)conversactionID ratingID:(NSString *)ratingID{
    
    NSString *baseUrl = [self getPlistPropertiesValue:@"TalkMBaseUrl"];
    
    NSString *url3 = [NSString stringWithFormat:@"https://%@.%@/api/conversations/%@/rating/%@", sdata.tenantKey, baseUrl, conversactionID, ratingID];
    
    NSString *authorization =  [NSString stringWithFormat:@"%@ %@", sdata.tokenType, sdata.token];
    
    //    AppDelegate *a = CurAppDelegate;
    ShareData *sData = [ShareData ShareDataAction];
    sData.restProcess = @"P";  //pending
    
    //json body
    NSError *nerrorJson = nil;
    NSArray *keys, *objects;
    
    
//    keys = [NSArray arrayWithObjects:@"grantType", @"email", @"password", nil];
//    objects = [NSArray arrayWithObjects:@"password", email, password, nil];
//    
//    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSError * error = nil;
//    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:&nerrorJson];
    
    NSHTTPURLResponse *response = [self postRestSynchronousBody:url3 method:@"POST" authorization:authorization jsonData:nil];
    
    if ([response respondsToSelector:@selector(allHeaderFields)]) {
        
        NSInteger statusCode = response.statusCode;
        
        NSLog(@"%i", response.statusCode);
        
        if (statusCode == 200 || statusCode == 201){
//            // OK   //talkmdev actionable shd predefine the success msg
//            if (data.length > 0 && nerror == nil){
//                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data
//                                                                       options:0
//                                                                         error:NULL];
//                
//                if (result == nil){
//                    //            NSString *error = [[data2.bytes] Stringvalue;
//                }
//                else{
//                    //                    AppDelegate *a = CurAppDelegate;
//                    sData.restReturn = result;
//                    sData.restProcess = @"D";  //done
//                }
//            }
            
            sData.restProcess = @"D";  //done
        }
        else if (statusCode == 500){              //for testing purposes
            [self storeUserDefaultChatRate:@"X"];
        }
        else{
            
            [self restErrorReturnCode:statusCode];
        }
    }
}

+(NSHTTPURLResponse *) postRestSynchronousBody : (NSString *) restURL method:(NSString *)method authorization:(NSString *)authorization jsonData:(NSData *)jsonData
{
    NSURL *url = [NSURL URLWithString:restURL];
    
    NSLog(@"************* url : %@", restURL);
    NSLog(@"************* jsonData : %@", jsonData);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSError *nerrorOri = nil;
    
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    if (authorization.length > 0){
        [mutableRequest addValue:authorization forHTTPHeaderField:@"AUTHORIZATION"];
    }
    [mutableRequest addValue:@"application/json" forHTTPHeaderField:@"ACCEPT"];
    [mutableRequest setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [mutableRequest setHTTPMethod:method];
    if (jsonData != nil){
        [mutableRequest setHTTPBody:jsonData];
    }
    
    // Now set our request variable with an (immutable) copy of the altered request
    request = [mutableRequest copy];
    
    NSLog(@"%@", request.allHTTPHeaderFields);
    
    NSHTTPURLResponse *response;
    
    data = nil;
    nerror = nil;
    
    data =  [NSURLConnection sendSynchronousRequest:request returningResponse:&response error: &nerrorOri];
    
    nerror = nerrorOri;
    
    return response;
    
}

+(void) restErrorReturnCode:(NSInteger)statusCode{
    ShareData *sData = [ShareData ShareDataAction];
    
    if (statusCode == 400){
        sData.restReturnStructure = @"400 - Login Failed";
        sData.restProcess = @"E";  //Error
    }
    else if (statusCode == 401){
        //404 Invalid Sub-domain
        sData.restReturnStructure = @"401 - Token Expired";
        sData.restProcess = @"E";  //Error
    }
    else if (statusCode == 402){
        //402 Expired Sub-domain
        sData.restReturnStructure = @"402 - Tenant Expired";
        sData.restProcess = @"E";  //Error
    }
    else if (statusCode == 403){
        //402 Expired Sub-domain
        sData.restReturnStructure = @"403 - Forbidden";
        sData.restProcess = @"E";  //Error6
    }
    else if (statusCode == 404){
        //404 Invalid Sub-domain
        sData.restReturnStructure = @"404 - Tenant Not Found";
        sData.restProcess = @"E";  //Error
    }
    else if (statusCode == 503){
        //404 Invalid Sub-domain
        sData.restReturnStructure = @"503 - Service Unavailable";
        sData.restProcess = @"E";  //Error
    }
    //    else{
    //        AppDelegate *a = CurAppDelegate;
    //        sData.restReturnStructure = @"000 - Connection Error";
    //        sData.restProcess = @"E";  //Error
    //    }
}

//+(void)saveServicer:(NSString *)servicerID
//       servicerName:(NSString *)servicerName
// servicerAvatarType:(NSString *)servicerAvatarType
//servicerAvatarValue:(NSString *)servicerAvatarValue
//  servicerAvatarUrl:(NSString *)servicerAvatarUrl
//  servicerSignature:(NSString *)servicerSignature
//{
//    ShareData *sData = [ShareData ShareDataAction];
//    sData.servicerId = servicerID;
//    sData.servicerName = servicerName;
//    sData.servicerAvatarType = servicerAvatarType;
//    sData.servicerAvatarUrl = servicerAvatarUrl;
//    sData.servicerAvatarValue = servicerAvatarValue;
//    sData.servicerSignature = servicerSignature;
//}

+(Boolean)findCompanySetting{
    Boolean isRestAPIOK = NO;
    
    ShareData *sData = [ShareData ShareDataAction];
    
    [self findCompanySettingByAppID:_appID];
    
    if ([sData.restProcess isEqualToString:@"E"]){
        [self showMessageWithType:@"" message:sData.restReturnStructure buttonTitle:@"OK" errorType:@"E"];
    }
    else if ([sData.restProcess isEqualToString:@"D"]){
        
        NSDictionary *postResult = sData.restReturn;
        
        postResult = [self ConverterDictionaryByReplacingNullsWithStrings:postResult];
        
        NSString *token, *scope, *errorTitle, *errorDesc;
        
        if ([postResult objectForKey:@"error"]){
            errorTitle = [postResult objectForKey:@"error"];
        }
        
        if ([postResult objectForKey:@"errorDescription"]){
            errorDesc = [postResult objectForKey:@"errorDescription"];
        }
        
        if (errorDesc.length > 0){
            messageTitle = errorTitle;
            messageDesc = errorDesc;
            [self showMessageWithType:messageTitle message:messageDesc buttonTitle:@"OK" errorType:@"E"];
        }
        else{
            
            messageTitle = @"";
            messageDesc = @"Login Success";
            
            sData.companySetting = postResult;
            
            NSDictionary *rating = [postResult objectForKey:@"rating"];
            
            if ([[rating objectForKey:@"enabled"] boolValue]){
                sData.isRatingEnable = @"y";
            }
            else{
                sData.isRatingEnable = @"n";
            }
            
            NSDictionary *advertisement = [postResult objectForKey:@"advertisement"];
            
            sData.htmlBody = [advertisement objectForKey:@"body"];
            
            isRestAPIOK = YES;
        }
        
    }
    else{
        messageTitle = @"Error";
        messageDesc = @"Login Validation Failed";
        
        [self showMessageWithType:messageTitle message:messageDesc buttonTitle:@"OK" errorType:@"E"];
    }
    
    return isRestAPIOK;
    
}

+(void)findCompanySettingByAppID:(NSString *)appIDappSecret{
    
    NSString *baseUrl = [self getPlistPropertiesValue:@"TalkMBaseUrl"];
    
    NSString *url3 = [NSString stringWithFormat:@"https://%@.%@/api/chats/settings", sdata.tenantKey, baseUrl];
    
    NSString *appIDEncoded = [self convertBased64Encode:appIDappSecret];
    
    NSString *authorization = [NSString stringWithFormat:@"Basic %@", appIDEncoded];
    
    ShareData *sData = [ShareData ShareDataAction];
    sData.restProcess = @"P";  //pending
    
    NSHTTPURLResponse *response = [self postRestSynchronousBody:url3 method:@"GET" authorization:authorization jsonData:nil];
    
    if ([response respondsToSelector:@selector(allHeaderFields)]) {
        
        NSInteger statusCode = response.statusCode;
        
        NSLog(@"%i", response.statusCode);
        
        if (statusCode == 200 || statusCode == 201 || statusCode == 202 || statusCode == 500){
            // OK
            if (data.length > 0 && nerror == nil){
                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:NULL];
                
                if (result == nil){
                    //            NSString *error = [[data2.bytes] Stringvalue;
                    NSLog(@"result is nil");
                }
                else{
                    //                    AppDelegate *a = CurAppDelegate;
                    sData.restReturn = result;
                    sData.restProcess = @"D";  //done
                }
            }
        }
        else{
            
            [self restErrorReturnCode:statusCode];
        }
    }
}


+(BOOL)submitLeaveMessage:(NSString *)contactNumber email:(NSString *)email message:(NSString *)message name:(NSString *)name{
    
    BOOL isRestAPIOK = NO;
    ShareData *sData = [ShareData ShareDataAction];
    
    [self postLeaveMessage:_appID contact:contactNumber email:email message:message name:name];
    
    if ([sData.restProcess isEqualToString:@"E"]){
        [self showMessageWithType:@"" message:sData.restReturnStructure buttonTitle:@"OK" errorType:@"E"];
    }
    else if ([sData.restProcess isEqualToString:@"D"]){
        
        NSDictionary *postResult = sData.restReturn;
        
        //        NSString *token = [[postResult objectForKey:@"accessToken"] stringValue];
        
        NSString *token, *scope, *errorTitle, *errorDesc;
        
        if ([postResult objectForKey:@"error"]){
            errorTitle = [postResult objectForKey:@"error"];
        }
        
        if ([postResult objectForKey:@"errorDescription"]){
            errorDesc = [postResult objectForKey:@"errorDescription"];
        }
        
        if (errorDesc.length > 0){
            messageTitle = errorTitle;
            messageDesc = errorDesc;
            [self showMessageWithType:messageTitle message:messageDesc buttonTitle:@"OK" errorType:@"E"];
        }
        else{
            
            messageTitle = @"";
            messageDesc = @"submit successfully";
            
            //            [Utilities showMessage:token message:scope];
            
            [self storeUserDefaultLeaveMessage:name email:email];
            
            isRestAPIOK = YES;
        }
    }
    else{
        messageTitle = @"Error";
        messageDesc = @"Rating Failed";
        
        [self showMessageWithType:messageTitle message:messageDesc buttonTitle:@"OK" errorType:@"E"];
    }
    
    return isRestAPIOK;
    
}

+(void)postLeaveMessage:(NSString *)appIDappSecret
                contact:(NSString *)contactNumber
                  email:(NSString *)email
                message:(NSString *)message
                   name:(NSString *)name{
    
    NSString *baseUrl = [self getPlistPropertiesValue:@"TalkMBaseUrl"];
    
    NSString *url3 = [NSString stringWithFormat:@"https://%@.%@/api/chats/messages", sdata.tenantKey, baseUrl];
    
    NSString *appIDEncoded = [self convertBased64Encode:appIDappSecret];
    
    NSString *authorization = [NSString stringWithFormat:@"Basic %@", appIDEncoded];
    
    ShareData *sData = [ShareData ShareDataAction];
    sData.restProcess = @"P";  //pending
    
    NSError *nerrorJson = nil;
//    NSMutableArray *keys = [NSArray arrayWithObjects:@"contactNumber", @"email", @"message", @"name", nil];
//    NSArray *objects = [NSArray arrayWithObjects:contactNumber, email, message, name, nil];
    NSMutableArray *keys = [NSMutableArray arrayWithObjects:@"email", @"name", nil];
    NSMutableArray *objects = [NSMutableArray arrayWithObjects:email, name, nil];
    
    if (contactNumber != nil){
        [keys addObject:@"contactNumber"];
        [objects addObject:contactNumber];
    }
    
    if (message != nil){
        [keys addObject:@"message"];
        [objects addObject:message];
    }

    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:&nerrorJson];
    
    NSHTTPURLResponse *response = [self postRestSynchronousBody:url3 method:@"POST" authorization:authorization jsonData:jsonData];
    
    if ([response respondsToSelector:@selector(allHeaderFields)]) {
        
        NSInteger statusCode = response.statusCode;
        
        NSLog(@"%i", response.statusCode);
        
        if (statusCode == 200 || statusCode == 201 || statusCode == 202 || statusCode == 500 || statusCode == 400){
            // OK
            if (data.length > 0 && nerror == nil){
                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:NULL];
                
                if (result == nil){
                    //            NSString *error = [[data2.bytes] Stringvalue;
                }
                else{
                    //                    AppDelegate *a = CurAppDelegate;
                    sData.restReturn = result;
                    sData.restProcess = @"D";  //done
                }
            }
        }
        else{
            [self restErrorReturnCode:statusCode];
        }
    }
}


+(BOOL)api_submitPendingExportChat{
    
    BOOL isSubmitOK = NO;
    
    ShareData *sdata = [ShareData ShareDataAction];
    
    NSString *email = [self readUserDefaultExportEmail];
    
    NSString *conversationID = sdata.conversactionID;
    
    if (email != nil){
    
        isSubmitOK = [self api_submitExportChatByEmail:email conversactionID:conversationID];
    
        if (isSubmitOK){
    
            //clear memory email after submit
            [self storeUserDefaultExportEmail:nil];
        }
    }
    
    return isSubmitOK;
}

+(BOOL)api_submitExportChatByEmail:(NSString *)email conversactionID:(NSString *)conversactionID{
    
    BOOL isRestAPIOK = NO;
    ShareData *sData = [ShareData ShareDataAction];
    
    [self submitExportChatByConversactionID:conversactionID email:email];
    
    if ([sData.restProcess isEqualToString:@"E"]){
        [self showMessageWithType:@"" message:sData.restReturnStructure buttonTitle:@"OK" errorType:@"E"];
    }
    else if ([sData.restProcess isEqualToString:@"D"]){
        
        NSDictionary *postResult = sData.restReturn;
        
        //        NSString *token = [[postResult objectForKey:@"accessToken"] stringValue];
        
        NSString *token, *scope, *errorTitle, *errorDesc;
        
        if ([postResult objectForKey:@"error"]){
            errorTitle = [postResult objectForKey:@"error"];
        }
        
        if ([postResult objectForKey:@"errorDescription"]){
            errorDesc = [postResult objectForKey:@"errorDescription"];
        }
        
        if (errorDesc.length > 0){
            messageTitle = errorTitle;
            messageDesc = errorDesc;
            [self showMessageWithType:messageTitle message:messageDesc buttonTitle:@"OK" errorType:@"E"];
        }
        else{
            
            messageTitle = @"";
            messageDesc = @"submit successfully";
            
            //            [Utilities showMessage:token message:scope];
            
            isRestAPIOK = YES;
        }
    }
    else{
        messageTitle = @"Error";
        messageDesc = @"Email Failed";
        
        [self showMessageWithType:messageTitle message:messageDesc buttonTitle:@"OK" errorType:@"E"];
    }
    
    return isRestAPIOK;
    
}

+(void)submitExportChatByConversactionID:(NSString *)conversactionID
                  email:(NSString *)email{
    
    NSString *baseUrl = [self getPlistPropertiesValue:@"TalkMBaseUrl"];
    
    NSString *url3 = [NSString stringWithFormat:@"https://%@.%@/api/chats/%@/export", sdata.tenantKey, baseUrl, conversactionID];
    
    NSString *authorization = [NSString stringWithFormat:@"%@ %@", sdata.tokenType, sdata.token];
    
    ShareData *sData = [ShareData ShareDataAction];
    sData.restProcess = @"P";  //pending
    
    NSError *nerrorJson = nil;
    //    NSMutableArray *keys = [NSArray arrayWithObjects:@"contactNumber", @"email", @"message", @"name", nil];
    //    NSArray *objects = [NSArray arrayWithObjects:contactNumber, email, message, name, nil];
    NSMutableArray *keys = [NSMutableArray arrayWithObjects:@"email", nil];
    NSMutableArray *objects = [NSMutableArray arrayWithObjects:email, nil];
    
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:&nerrorJson];
    
    NSHTTPURLResponse *response = [self postRestSynchronousBody:url3 method:@"POST" authorization:authorization jsonData:jsonData];
    
    if ([response respondsToSelector:@selector(allHeaderFields)]) {
        
        NSInteger statusCode = response.statusCode;
        
        NSLog(@"%i", response.statusCode);
        
        if (statusCode == 200 || statusCode == 201 || statusCode == 202 || statusCode == 500 || statusCode == 400){
            //

            if (statusCode == 200){
                sData.restProcess = @"D";  //done
            }
            else if (statusCode == 400){
                if (data.length > 0 && nerror == nil){
                    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data
                                                                            options:0
                                                                                error:NULL];
                
                    if (result == nil){
                        //            NSString *error = [[data2.bytes] Stringvalue;
                    }
                    else{
                        //                    AppDelegate *a = CurAppDelegate;
                        sData.restReturn = result;
                        sData.restProcess = @"D";  //done
                    }
                }
            }
        }
        else{
            [self restErrorReturnCode:statusCode];
        }
    }
}

+(void)api_updateChatEndTimeByCsid:(NSString *)csid
                      uid:(NSString *)uid{
    
    NSString *url3 = [NSString stringWithFormat:@"%@get?processor_id=1012&job_id=13&action_id=7&end_user=%@&servicer_uid=%@&visitor_uid=%@&format=jsonp&jsoncallback=?&token=%@", SERVER_CONTROLLER_URL_ROOT, csid, csid, uid, sdata.token];
    
    NSHTTPURLResponse *response = [self postRestSynchronousBody:url3 method:@"GET" authorization:nil jsonData:nil];
    
    if ([response respondsToSelector:@selector(allHeaderFields)]) {
        
        NSInteger statusCode = response.statusCode;
        
        NSLog(@"%li", response.statusCode);
        
        if (statusCode == 200 || statusCode == 201 || statusCode == 202){
        }
        else{
//            [self restErrorReturnCode:statusCode];
        }
    }
}


#pragma mark - user default
//+(void) storeUserDefault : (NSString *) servicerId
//             servicerName: (NSString *) servicerName
//       servicerAvatarType: (NSString *) servicerAvatarType
//     servicerAvatarValue : (NSString *) servicerAvatarValue
//        servicerAvatarUrl: (NSString *) servicerAvatarUrl
//        servicerSignature: (NSString *) servicerSignature{
//    
//    // Store the data
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    [defaults setObject:servicerId              forKey:@"iservicerId"];
//    [defaults setObject:servicerName            forKey:@"iservicerName"];
//    [defaults setObject:servicerAvatarType      forKey:@"iservicerAvatarType"];
//    [defaults setObject:servicerAvatarValue     forKey:@"iservicerAvatarValue"];
//    [defaults setObject:servicerAvatarUrl       forKey:@"iservicerAvatarUrl"];
//    [defaults setObject:servicerSignature       forKey:@"iservicerSignature"];
//    [defaults synchronize];
//}

+(void) storeUserDefaultChatRate: (NSString *) isChatRated{
    
    // Store the data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:isChatRated       forKey:@"ichatRated"];
    [defaults synchronize];
}

+(void) storeUserDefaultChatEndConv: (NSString *) isChatEndConv chatEndConvText:(NSString *)chatEndConvText chatEndConvType:(NSString *)chatEndConvType{
    
    // Store the data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:isChatEndConv       forKey:@"ichatEndConv"];
    if (chatEndConvText.length > 0){
        [defaults setObject:chatEndConvText       forKey:@"ichatEndConvText"];
        [defaults setObject:chatEndConvType       forKey:@"ichatEndConvType"];
    }
    
    [defaults synchronize];
}

+(void) storeUserDefaultLeaveMessage:(NSString *)name email:(NSString *)email{
    
    // Store the data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:name       forKey:@"iLeaveMsgName"];
    [defaults setObject:email       forKey:@"iLeaveMsgEmail"];
    [defaults synchronize];
}

+(void) storeUserDefaultExportEmail: (NSString *) email{
    // Store the data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:email       forKey:@"iExportEmail"];
    if (email != nil){
        [defaults setObject:email       forKey:@"iDisplayExportEmail"];
    }
    
    [defaults synchronize];
}

+(NSString *) readUserDefaultLeaveMessageName{
    
    NSUserDefaults *defaults    = [NSUserDefaults standardUserDefaults];
    NSString *text              = @"";
    text = [defaults objectForKey:@"iLeaveMsgName"];
    
    return text;

}

+(NSString *) readUserDefaultLeaveMessageEmail{
    
    NSUserDefaults *defaults    = [NSUserDefaults standardUserDefaults];
    NSString *text              = @"";
    text = [defaults objectForKey:@"iLeaveMsgEmail"];
    
    return text;
}

+(NSString *) readUserDefaultDisplayLeaveMessageEmail{   //store locally and permenant display
    
    NSUserDefaults *defaults    = [NSUserDefaults standardUserDefaults];
    NSString *text              = @"";
    text = [defaults objectForKey:@"iDisplayExportEmail"];
    
    return text;
}


//+(NSString *)readUserDefault{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *servicerId                = [defaults objectForKey:@"iservicerId"];
//    NSString *servicerName              = [defaults objectForKey:@"iservicerName"];
//    NSString *servicerAvatarType        = [defaults objectForKey:@"iservicerAvatarType"];
//    NSString *servicerAvatarValue       = [defaults objectForKey:@"iservicerAvatarValue"];
//    NSString *servicerAvatarUrl         = [defaults objectForKey:@"iservicerAvatarUrl"];
//    NSString *servicerSignature         = [defaults objectForKey:@"iservicerSignature"];
//    
//    NSString *value = [NSString stringWithFormat:@"%@|%@|%@|%@|%@|%@", servicerId,
//                       servicerName, servicerAvatarType, servicerAvatarValue, servicerAvatarUrl, servicerSignature];
//    
//    return value;
//}

+(NSString *)readUserDefaultChatRate{
    NSUserDefaults *defaults    = [NSUserDefaults standardUserDefaults];
    NSString *isRated           = [defaults objectForKey:@"ichatRated"];

    return isRated;
}

+(NSString *)readUserDefaultChatEndConv{
    NSUserDefaults *defaults    = [NSUserDefaults standardUserDefaults];
    NSString *isChatEnded           = [defaults objectForKey:@"ichatEndConv"];
    
    return isChatEnded;
}

+(NSString *)readUserDefaultChatEndConvText{
    NSUserDefaults *defaults    = [NSUserDefaults standardUserDefaults];
    NSString *text           = [defaults objectForKey:@"ichatEndConvText"];
    
    return text;
}

+(NSString *)readUserDefaultChatEndConvType{
    NSUserDefaults *defaults    = [NSUserDefaults standardUserDefaults];
    NSString *text           = [defaults objectForKey:@"ichatEndConvType"];
    
    return text;
}

+(NSString *)readUserDefaultExportEmail{
    NSUserDefaults *defaults    = [NSUserDefaults standardUserDefaults];
    NSString *email           = [defaults objectForKey:@"iExportEmail"];
    
    return email;
}


+(void)performCSEndChat{
    
    NSLog(@"********check auto respond - start");
    
    ShareData *sdata = [ShareData ShareDataAction];
    sdata.isCSEndChatDone = @"P";  //start and action on pending;
    
    [self fireEndChat:self];
}

#pragma mark - company auto setting (autoRespond, autoEnd, autoTransfer, autoRating

+(void)clearAllAutoTimeOut{
    
    [timerRespond invalidate];
    
    [timerEndChat invalidate];
    
    [timerTransfer invalidate];
    
    ShareData *sdata = [ShareData ShareDataAction];
    sdata.isAutoRespondDone = @"";
    sdata.isAutoTransferDone = @"";
    sdata.isAutoEndConvDone = @"";
}

+(void)clearAutoRespondTimeOut{
    [timerRespond invalidate];
    
    ShareData *sdata = [ShareData ShareDataAction];
    sdata.isAutoRespondDone = @"";
}

+(void)clearAutoEndChatTimeOut{
    [timerEndChat invalidate];
    
    ShareData *sdata = [ShareData ShareDataAction];
    sdata.isAutoEndConvDone = @"";
}

+(void)clearAutoTransferTimeOut{
    [timerTransfer invalidate];
    
    ShareData *sdata = [ShareData ShareDataAction];
    sdata.isAutoTransferDone = @"";
}


+(void)resetCustomerCountDown{
    
    NSLog(@"start reset costomer count down");
    
    [self resetAutoRespondCountDown];
    
    [self resetAutoEndChatCountDown];
    
    [self resetAutoTransferCountDown];
    
}

+(void)resetVisitorCountDown{
    //get auto end chat time out
    [self resetAutoEndChatCountDown];
}

+(void)resetAutoRespondCountDown{
    
    //    When timeout response is enable, if CS doesn't reply after the pre-set time, visitor should see the auto respond message.
    
    
    
    autoRespondTimeOut = [self getAutoRespond];
    
    if (autoRespondTimeOut > 0){   //more than 0 second means auto respond is enable
        
        NSLog(@"********check auto respond - start");
        
//        autoRespondTimeOut = 10; //testing purposes
        
        ShareData *sdata = [ShareData ShareDataAction];
        sdata.isAutoRespondDone = @"P";  //start and action on pending;
        
        [timerRespond invalidate];
        
        timerRespond = [NSTimer scheduledTimerWithTimeInterval:autoRespondTimeOut
                                                        target:self
                                                      selector:@selector(fireRespond:)
                                                      userInfo:nil
                                                       repeats:NO];
    
    
    // problem - block not start after block_cancel
    //        autoRespondBlock = dispatch_block_create(0, ^{
    //            [[NSNotificationCenter defaultCenter] postNotificationName:@"autoRespondNotif" object:nil userInfo:nil];
    //        });
    ////    dispatch_block_cancel(autoEndChatBlock); //cancel the previous and reset
    //
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, autoRespondTimeOut * NSEC_PER_SEC), dispatch_get_main_queue(), autoRespondBlock);
    
    
    //method 2
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, autoRespondTimeOut * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    //
    //        [[NSNotificationCenter defaultCenter] postNotificationName:@"pushToSingle" object:nil userInfo:nil];
    //    });
    }
}

+(void)fireRespond:(id)sender{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"autoRespondNotif" object:nil userInfo:nil];
}



+(void)resetAutoTransferCountDown{
    
    //    When auto transfer chat is enable, if the customer support does not reply to the customer after a certain period of time, the chat will be automatically transfer to another pre-set customer support.
    
    
    
    autoTransferTimeOut = [self getAutoTransfer];
    
    if (autoTransferTimeOut > 0){
        
//        autoTransferTimeOut = 30; //testing purposes
        
        ShareData *sdata = [ShareData ShareDataAction];
        sdata.isAutoTransferDone = @"P";  //start and action on pending;
        
        NSLog(@"********check auto transfer - start");
        
        [timerTransfer invalidate];
        
        timerTransfer = [NSTimer scheduledTimerWithTimeInterval:autoTransferTimeOut
                                                         target:self
                                                       selector:@selector(fireTransfer:)
                                                       userInfo:nil
                                                        repeats:NO];
    }
}

+(void)fireTransfer:(id)sender{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"autoTransferNotif" object:nil userInfo:nil];
}

+(void)resetAutoEndChatCountDown{
    
    //    When automatic end chat is enable, if both CS and visitor don't response after certain period of time, the web chat will end automatically.
    
    autoEndChatTimeOut = [self getAutoEndChat];
    
    if (autoEndChatTimeOut > 0){
        
        NSLog(@"********check auto end chat - start");
        
//        autoEndChatTimeOut = 60; //testing purposes
        
        ShareData *sdata = [ShareData ShareDataAction];
        sdata.isAutoEndConvDone = @"P";  //start and action on pending;
        
        [timerEndChat invalidate];
        
        timerEndChat = [NSTimer scheduledTimerWithTimeInterval:autoEndChatTimeOut
                                                        target:self
                                                      selector:@selector(fireEndChat:)
                                                      userInfo:nil
                                                       repeats:NO];
        
    }
}

+(void)fireEndChat:(id)sender{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"autoEndChatNotif" object:nil userInfo:nil];
}

+(void)initCountDown{
    autoEndChatTimeOut = -1;
    autoRespondTimeOut = -1;
    autoTransferTimeOut = -1;
}

//+(void)startCountDown{
//
//    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerTicked:) userInfo:nil repeats:YES];
//}
//
//+(void)timerTicked:(id)sender{
//
//    ShareData *sdata = [ShareData ShareDataAction];
//    NSDate *startTime = sdata.lastCustomerReplyDate;
//    NSDate *endTime = [NSDate date];
//
//    NSTimeInterval secs = [endTime timeIntervalSinceDate:startTime];
////    NSLog(@"Seconds --------> %f", secs);
//
//    if (secs > autoRespondTimeOut){
//        NSLog(@"perform auto respont");
//
//        sdata.lastCustomerReplyDate = nil;
//
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"pushToSingle" object:nil userInfo:nil];
//    }
//}

+(NSInteger)getAutoRespond{
    
    NSInteger autoTimeOut = -1;
    
    ShareData *sdata = [ShareData ShareDataAction];
    NSDictionary *autoResponse = [sdata.companySetting objectForKey:@"autoResponse"];
    BOOL isAutoEnable = [[autoResponse objectForKey:@"enabled"] boolValue];
    
    if (isAutoEnable){
        NSString *timeout = [autoResponse objectForKey:@"timeout"];
        NSString *message = [autoResponse objectForKey:@"message"];
        
        NSString *customerLastReply = sdata.lastCustomerReplyDate;
        
        NSInteger hour = 0;
        NSInteger minute = 0;
        NSInteger second = 0;
        
        NSCalendar *currentCalendar = [NSCalendar currentCalendar];
        [currentCalendar getHour:&hour minute:&minute second:&second nanosecond:NULL fromDate:sdata.lastCustomerReplyDate];
        
        NSInteger targetStopTime = second + [timeout intValue];
        autoTimeOut = [timeout intValue];
    }
    
//    autoTimeOut = -1;  //testing to disable auto timeout
    
    return autoTimeOut;
}

+(NSInteger)getAutoEndChat{
    
    NSInteger autoTimeOut = -1;
    
    ShareData *sdata = [ShareData ShareDataAction];
    NSDictionary *autoResponse = [sdata.companySetting objectForKey:@"autoEndChat"];
    NSDictionary *iOSResponse = [autoResponse objectForKey:@"ios"];
    BOOL isAutoEnable = [[iOSResponse objectForKey:@"enabled"] boolValue];
    //true means no end chat
    //false means proceed to end chat

    
    if (! isAutoEnable){
        NSString *timeout = [iOSResponse objectForKey:@"waitingTime"];
        
        autoTimeOut = [timeout intValue];
    }
    
//    autoTimeOut = -1;  //testing to disable auto timeout
    
    return autoTimeOut;
}

+(NSInteger)getAutoTransfer{
    
    NSInteger autoTimeOut = -1;
    
    ShareData *sdata = [ShareData ShareDataAction];
    NSDictionary *autoResponse = [sdata.companySetting objectForKey:@"autoTransfer"];
    BOOL isAutoEnable = [[autoResponse objectForKey:@"enabled"] boolValue];
    
    if (isAutoEnable){
        NSString *timeout = [autoResponse objectForKey:@"waitingTime"];
        
        autoTimeOut = [timeout intValue];
    }
    
//    autoTimeOut = -1;  //testing to disable auto timeout
    
    return autoTimeOut;
}





#pragma mark - others

+(void)showMessageWithType:(NSString *) title message : (NSString *) msg buttonTitle:(NSString *)buttonTitle errorType:(NSString *)errorType{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle: title
                                                                   message: msg
                                                            preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction;
    
    if ([errorType isEqualToString:@"E"]){
        defaultAction = [UIAlertAction actionWithTitle: buttonTitle
                                                 style: UIAlertActionStyleDestructive
                                               handler: nil];
    }
    else{
        defaultAction = [UIAlertAction actionWithTitle: buttonTitle
                                                 style: UIAlertActionStyleCancel
                                               handler: nil];
    }
    
    
    [alert addAction: defaultAction];
    
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootViewController presentViewController:alert animated:YES completion:nil];
}

+(void)initCustomBackNavigation:(UINavigationController*) navigationController{
    
    navigationController.navigationItem.hidesBackButton = YES;
    //    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarStyleDefault target:self action:@selector(backBarButton:)];
    navigationController.navigationItem.leftBarButtonItem = newBackButton;
    //    self.navigationItem.leftBarButtonItem = newBackButton;
    
    //    UIBarButtonItemStyleBordered
}

+ (void) backBarButton:(UIBarButtonItem *)sender {
    
    UINavigationController *controller = sender;
    
    
    //    // Perform your custom actions
    //    [self return showMessageYesNo2:sender title:kTicketBackAction message:@"All information will be lost, Are you sure to cancel the ticket?"];
    //
    // Go back to the previous ViewController
    // [self.navigationController popViewControllerAnimated:YES];
}

+(void)returnParentView: (UINavigationController *) navigationController{
    //    [self.navigationController popViewControllerAnimated:YES];
    
    [navigationController popViewControllerAnimated:YES];
}

+(NSString *)convertBased64Encode:(NSString *)appId_appSecret{
    // Create NSData object
    NSData *nsdata = [appId_appSecret
                      dataUsingEncoding:NSUTF8StringEncoding];
    
    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    
    // Print the Base64 encoded string
    NSLog(@"Encoded: %@", base64Encoded);
    
    return base64Encoded;
    
}

+(NSString *)convertBased64Decode:(NSString *)encodedValue{
    // NSData from the Base64 encoded str
    NSData *nsdataFromBase64String = [[NSData alloc]
                                      initWithBase64EncodedString:encodedValue options:0];
    
    // Decoded NSString from the NSData
    NSString *base64Decoded = [[NSString alloc]
                               initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
    
    NSLog(@"Decoded: %@", base64Decoded);
    
    return base64Decoded;
}

+(NSString *) getPlistPropertiesValue:(NSString *) propertiesKey{
    
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:propertiesKey];
}

+ (UIColor *)colorFromHexString2:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

+ (UIColor *)colorFromHexString:(int)color {

    float red = (color & 0xff000000) >> 24;
    float green = (color & 0x00ff0000) >> 16;
    float blue = (color & 0x0000ff00) >> 8;
    float alpha = (color & 0x000000ff);
    
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha/255.0];

}

+ (NSDictionary *)ConverterDictionaryByReplacingNullsWithStrings:(NSMutableDictionary *)dict{
    const NSMutableDictionary *replaced = [dict mutableCopy];
    const id nul = [NSNull null];
    const NSString *blank = @"";
    
    for(NSString *key in dict) {
        const id object = [dict objectForKey:key];
        if(object == nul) {
            //pointer comparison is way faster than -isKindOfClass:
            //since [NSNull null] is a singleton, they'll all point to the same
            //location in memory.
            [replaced setObject:blank
                         forKey:key];
        }
    }
    
    return [replaced copy];
}

+ (NSString *)ConverterStringByReplacingNullsWithStrings:(NSString *)text{
    
    const id nul = [NSNull null];
    if (text == nul || text == nil){
        text = @"";
    }
    
    return text;
}


+ (NSAttributedString *)linkedStringFromFullString:(NSString *)fullString withLinkString:(NSString *)linkString andUrlString:(NSString *)urlString
{
    NSRange range = [fullString rangeOfString:linkString options:NSLiteralSearch];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:fullString];
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{NSForegroundColorAttributeName:HexColor(0x999999) ,
                                 NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Light" size:10],
                                 NSParagraphStyleAttributeName:paragraphStyle};
    [str addAttributes:attributes range:NSMakeRange(0, [str length])];
    [str addAttribute: NSLinkAttributeName value:urlString range:range];
    
    return str;
}

+ (UIImageView *) imageConvertCircle:(UIImageView *)image{
    
    image.layer.cornerRadius = image.frame.size.width / 2;
    image.clipsToBounds = YES;
    
    return image;
}

+(UIImage *)getCustomeSupportAvatar: (NSString *)url{
    
    UIImage *avatar;
    
    //this is custom avatar
    avatar = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL   URLWithString:url]]];
    
    return avatar;
}

+(NSString *)getStandardSupportAvatarBySize:(NSString *) avatarSize{
    
    NSString *avatar = @"";
    
    ShareData *sdata = [ShareData ShareDataAction];
    
    //this is standard avatar
    if ([avatarSize isEqualToString:@"big"]){
        avatar = [self getAvatarBigName:sdata.servicerAvatarValue];
    }
    else{
        avatar = [self getAvatarSmallName:sdata.servicerAvatarValue];
    }
    
    return avatar;
}

+(NSString *)getAvatarBigName:(NSString *)avatarName{
    
    return [NSString stringWithFormat:@"ic_%@_big", avatarName];
}

+(NSString *)getAvatarSmallName:(NSString *)avatarName{
    
    return [NSString stringWithFormat:@"ic_%@_small", avatarName];
}

+(void)hideWindowStatusBar{
    [[[[UIApplication sharedApplication] delegate] window] setWindowLevel:UIWindowLevelStatusBar+1];
}

+(void)showWindowStatusBar{
    [[[[UIApplication sharedApplication] delegate] window] setWindowLevel:UIWindowLevelNormal];
}

+ (BOOL) validateEmail: (NSString *) emailString {
    //email format validation
    
    NSString *emailRegex1 = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *emailRegex2 = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSString *emailRegex3 = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex1];
    
    return [emailTest evaluateWithObject:emailString];
}

+ (BOOL) validateContactlength: (NSString *) contact {
    
    BOOL isContactOK = NO;
    
    if (contact.length > 7){
        isContactOK = YES;
    }
    
    return isContactOK;
}

+(BOOL) checkNavigationVisible{
    
    BOOL isNavigationVisibleOK = NO;
    
    id nav = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([nav isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navc = (UINavigationController *) nav;
        if(navc.navigationBarHidden) {
            NSLog(@"NOOOO NAV BAR");
        } else {
            isNavigationVisibleOK = YES;
        }
    }
    
    return isNavigationVisibleOK;
}

+(BOOL)isIphonePlusDevice{
    if (!IS_PHONE){
        return NO;
    }
    
    if ([UIScreen mainScreen].scale > 2.9){
        return YES;   // Scale is only 3 when not in scaled mode for iPhone 6 Plus
    }
    
    return NO;
}

#pragma mark - MobileIMSDK
+(void)switchToMainViewController
{
    if (_mainViewController == nil)
        _mainViewController	= [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    
    UINavigationController  *navRoot = [[UINavigationController alloc] initWithRootViewController:_mainViewController];
    
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    rootViewController = navRoot;
    
//    [rootViewController presentViewController:alert animated:YES completion:nil];
    
//    self.window.rootViewController = navRoot;
}

+ (UIView *) getMainView
{
    return _mainViewController.view;
}

+ (MainViewController *) getMainViewController
{
    return _mainViewController;
}

+ (void) refreshConnecteStatus
{
    [_mainViewController refreshConnecteStatus];
}

+ (void)showToastInfo:(NSString *)content
{
    //[self showToast:@"友情提示" withContent:content];
    [self showToast:nil withContent:content];
}
+ (void)showToastWarn:(NSString *)content
{
    [self showToast:@"警告" withContent:content];
}
+ (void)showToastError:(NSString *)content
{
    [self showToast:@"出错了" withContent:content];
}
+ (void)showToast:(NSString *)title withContent:(NSString *)content
{
    UIWindow *window = [(AppDelegate*)[[UIApplication sharedApplication]delegate] window];
    
    [window.rootViewController E_showToastInfo:title withContent:content onParent:window];
    
//    [self E_showToastInfo:title withContent:content onParent:window];
}

+ (void) E_showToastInfo:(NSString *)title withContent:(NSString *)content onParent:(UIView *)parentView
{
    // Make toast with an image & title
    // 本方法来自 Toast+UIView catlog实现
    [parentView makeToast:content
                 duration:3.0
                 position:@"center"//@"bottom"
                    title:title
                    image:[UIImage imageNamed:@"info.png"]];
}

+(BOOL)checkCurrentViewIsChatView:(UIViewController *)currentView{
    
    BOOL isChatView = NO;
    
    if([currentView isKindOfClass:[ChatViewController class]]){
        isChatView = YES;
    }
    
    return isChatView;
}

#pragma mark - keyboard
#define kOFFSET_FOR_KEYBOARD 150.0

+(void)keyboardWillShow: (UIView *)view {
    // Animate the current view out of the way
    if (view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES view:view];
    }
}

+(void)keyboardWillHide: (UIView *)view {
    if (view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO view:view];
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
+(void)setViewMovedUp:(BOOL)movedUp view:(UIView *)view
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    //    CGRect rect = self.view.frame;
    CGRect rect = view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    //    self.view.frame = rect;
    view.frame = rect;
    
    [UIView commitAnimations];
}


@end

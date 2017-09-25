//
//  IMLaunchWrapper.m
//  TalkM_visitor
//
//  Created by JackJiang on 17/4/11.
//  Copyright © 2017年 JackJiang. All rights reserved.
//
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

#import "IMLaunchWrapper.h"
#import "OnLoginProgress.h"
#import "CompletionDefine.h"
#import "ChatViewController.h"
#import "IMClientManager.h"
#import "UserDefaultsToolKits.h"
#import "SDKUtils.h"
#import "EVAToolKits.h"
#import "LocalUDPDataSender.h"
//#import "AppDelegate.h"
#import "libsdk.h"
#import "DemoMainViewController.h"

#import "ShareData.h"
#import "NoAgentViewController.h"


////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 私有API
////////////////////////////////////////////////////////////////////////////////////////////

@interface IMLaunchWrapper ()

/* 登陆进度提示 */
@property (nonatomic) OnLoginProgress *onLoginProgress;

/* 收到服务端的登陆完成反馈时要通知的观察者（因登陆是异步实现，本观察者将由
 *  ChatBaseEvent 事件的处理者在收到服务端的登陆反馈后通知之）*/
@property (nonatomic, copy) ObserverCompletion onLoginSucessObserver;// block代码块一定要用copy属性，否则报错！

@property (nonatomic, retain) NSString *tempCachedCid;
@property (nonatomic, retain) NSString *tempCachedUid;
@property (nonatomic, retain) NSString *tempCachedToken;

@property (nonatomic, retain) UIViewController *parentViewController;

@end


/////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 本类的代码实现
/////////////////////////////////////////////////////////////////////////////////////////////

@implementation IMLaunchWrapper

- (id)initWith:(UIViewController *)parentViewController
{
    if(self = [super init])
    {
        // 属性初始化
        self.parentViewController = parentViewController;
    }
    return self;
}

- (void)initConnectToIMServer
{
    // 为了在block代码中安全地使用本类“self”，请在block代码中使用safeSelf
    __weak IMLaunchWrapper *safeSelf = self;
    // 实例化登陆进度提示封装类
    self.onLoginProgress = [[OnLoginProgress alloc] init];
    // 设置登陆超时回调（将在登陆进度提示封装类中使用）
    [self.onLoginProgress setOnLoginTimeoutObserver:^(id observerble ,id data) {
        [[[UIAlertView alloc] initWithTitle:@"超时了"
                                    message:@"登陆超时，可能是网络故障或服务器无法连接，是否重试？"
                                   delegate:safeSelf
                          cancelButtonTitle:@"取消"
                          otherButtonTitles:@"重试！", nil]
         show];
    }];
    // 准备好异步登陆结果回调block（将在登陆方法中使用）
    self.onLoginSucessObserver = ^(id observerble ,id data) {
        // * 已收到服务端登陆反馈则当然应立即取消显示登陆进度条
        [safeSelf.onLoginProgress showProgressing:NO onParent:safeSelf.parentViewController.view];
        // 服务端返回的登陆结果值
        int code = [(NSNumber *)data intValue];
        // 登陆成功
        if(code == 0)
        {
            // TODO 提示：登陆MobileIMSDK服务器成功后的事情在此实现即可
            // 进入聊天界面
            
//            if([safeSelf.parentViewController.navigationController.visibleViewController isKindOfClass:[ChatViewController class]]){
//                NSLog(@"Current view is ChatViewController, no need to fire viewController");
//            }
//            else{
//                [safeSelf gotoChatViewController];
//            }
            
            if ([libsdk checkCurrentViewIsChatView:safeSelf.parentViewController.navigationController.visibleViewController]){

                NSLog(@"**********Current view is ChatViewController, no need to fire viewController");
            }
            else{
                [safeSelf gotoChatViewController];
            }
            
        }
        // 登陆失败
        else
        {
            [[[UIAlertView alloc] initWithTitle:@"友情提示"
                                        message:[NSString stringWithFormat:@"Sorry，登陆失败，错误码=%d", code]
                                       delegate:safeSelf
                              cancelButtonTitle:@"知道了"
                              otherButtonTitles:nil]
             show];
        }

        //## try to bug FIX ! 20160810：此observer本身执行完成才设置为nil，解决之前过早被nil而导致有时怎么也无法跳过登陆界面的问题
        // * 取消设置好服务端反馈的登陆结果观察者（当客户端收到服务端反馈过来的登陆消息时将被通知）【1】
        [[[IMClientManager sharedInstance] getBaseEventListener] setLoginOkForLaunchObserver:nil];
    };
}

- (void)connectToIMServer:(NSString *)cid withUid:(NSString *)uid andToken:(NSString *)token
{
    // * 立即显示登陆处理进度提示（并将同时启动超时检查线程）
//    [self.onLoginProgress showProgressing:YES onParent:self.parentViewController.view];  //20170607
    // * 设置好服务端反馈的登陆结果观察者（当客户端收到服务端反馈过来的登陆消息时将被通知）【2】
    [[[IMClientManager sharedInstance] getBaseEventListener] setLoginOkForLaunchObserver:self.onLoginSucessObserver];

    ServicerUidStore *csid = [SDKUtils tryGetStoredServerUid];//null//"40089"

    // SSO分配的此访客对应的uid
    self.tempCachedUid = uid;
    // SSO返回的安全认证token
    self.tempCachedToken = token;
    // 对应公司id
    self.tempCachedCid = cid;//"1009"
    //
    LoginInfoExtra *extra = [LoginInfoExtra initWith:self.tempCachedUid
                                            andToken:self.tempCachedToken
                                                 cid:self.tempCachedCid
                                                // 20161212后：因启用了排队机制，不传csid即表示将作为排队用户加入到Inline列表中，否则表示指定客服进行服务
                                                csid:(csid!= nil?csid.servicerUid:nil)];
    if(csid != nil)
    {
        // 将之前保存的客服服务记录id恢复出来，以备
        extra.serviceRecordId = csid.serviceRecordId;
    }
    
    //talkmdev 20170614
    else{
        //clear userdefault for user data
//        [libsdk storeUserDefault:@"" servicerName:@"" servicerAvatarType:@"" servicerAvatarValue:@"" servicerAvatarUrl:@"" servicerSignature:@""];
        
        
        [libsdk storeUserDefaultChatRate:@""];
        [libsdk storeUserDefaultChatEndConv:@"" chatEndConvText:@"" chatEndConvType:@""];
    }

    NSString *extraWithJSON = [SDKUtils loginInfoExtraToJSON:extra];
    NSLog(@"EXTA================ %@", extraWithJSON);

    int code = [[LocalUDPDataSender sharedInstance] sendLogin:uid withToken:token andExtra:extraWithJSON];
    if(code == COMMON_CODE_OK)
    {
//        [libsdk showToastInfo:@"登陆请求已发出。。。"];  //20170607
        
    }
    else
    {
        NSString *msg = [NSString stringWithFormat:@"登陆请求发送失败，错误码：%d", code];
        [libsdk showToastError:msg];

        // * 登陆信息没有成功发出时当然无条件取消显示登陆进度条
        [self.onLoginProgress showProgressing:NO onParent:self.parentViewController.view];
    }
}

- (void)gotoChatViewController
{
    ChatViewController *vc = [[ChatViewController alloc] initWithNibName:nil bundle:nil];
    [self.parentViewController.navigationController pushViewController:vc animated:YES];
    
//    //talkmdev - store random number for conversactionID
//    int i = rand()%10000+1;
//    NSString *randomNumber = [NSString stringWithFormat:@"%i", i];
//    ShareData *sdata = [ShareData ShareDataAction];
////    sdata.conversactionID = randomNumber;
//    
////    sdata.conversactionID = SDKUtils.getCurrentLoginExtra.serviceRecordId;
    
//    [[IMClientManager sharedInstance] getLocalUserInfoProvider].csid showToast:YES]
    
    NSString *csid = [[IMClientManager sharedInstance] getLocalUserInfoProvider].csid ;
    
    if (! [BasicTool isStringEmpty:csid]){
        [libsdk resetCustomerCountDown];
    }
//        DemoMainViewController *vc = [[DemoMainViewController alloc] initWithNibName:@"DemoMainViewController" bundle:nil];
//        [self.parentViewController.navigationController pushViewController:vc animated:YES];

}

- (void)gotoNoAgentViewController
{
    NoAgentViewController *vc = [[NoAgentViewController alloc] initWithNibName:nil bundle:nil];
    [self.parentViewController.navigationController pushViewController:vc animated:YES];
    
//    //talkmdev - store random number for conversactionID
//    int i = rand()%10000+1;
//    NSString *randomNumber = [NSString stringWithFormat:@"%i", i];
//    ShareData *sdata = [ShareData ShareDataAction];
//    sdata.conversactionID = randomNumber;
//    
//    //    [[IMClientManager sharedInstance] getLocalUserInfoProvider].csid showToast:YES]
//    
//    NSString *csid = [[IMClientManager sharedInstance] getLocalUserInfoProvider].csid ;
//    
//    if (! [BasicTool isStringEmpty:csid]){
//        [libsdk resetCustomerCountDown];
//    }
//    //        DemoMainViewController *vc = [[DemoMainViewController alloc] initWithNibName:@"DemoMainViewController" bundle:nil];
//    //        [self.parentViewController.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark - UIAlertView delegate

/*
 * 在这里处理登陆超时时的UIAlertView提示对话框中的按钮被单击事件。
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        // 点击了取消按钮
        case 0:
            // 不需要重试则要停止“登陆中”的进度提示哦
            [self.onLoginProgress showProgressing:NO onParent:self.parentViewController.view];
            break;

        // 点确了确认按钮
        case 1:
            // 确认要重试时（再次尝试登陆哦）
            [self connectToIMServer:self.tempCachedCid withUid:self.tempCachedUid andToken:self.tempCachedUid];
            break;

        default:
            break;
    }
}


@end

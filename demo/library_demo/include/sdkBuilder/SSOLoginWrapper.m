//
//  SSOLoginWrapper.m
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

#import "SSOLoginWrapper.h"
#import "IMLaunchWrapper.h"
#import "IMClientManager.h"
#import "SSOReturn.h"
#import "BasicTool.h"
#import "ClientCoreSDK.h"
#import "UserDefaultsToolKits.h"
#import "HttpsGetHelper.h"
#import "EVAToolKits.h"
#import "MBProgressHUD.h"

#import "ShareData.h"
#import "libsdk.h"


///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 私有API
///////////////////////////////////////////////////////////////////////////////////////////

@interface SSOLoginWrapper ()

@property (nonatomic, retain) UIViewController *parentViewController;
/** 是否显示进度提示：true表示提示，否则不提示 */
@property (nonatomic) BOOL showProgress;
@property (nonatomic, retain) IMLaunchWrapper *imLaunchWrapper;
/** 公司id */
@property (nonatomic, retain) NSString *cid;

@end


///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 本类的代码实现
///////////////////////////////////////////////////////////////////////////////////////////

@implementation SSOLoginWrapper

- (id)initWith:(UIViewController *)parentViewController showProgress:(BOOL)showProgress
{
    if(self = [super init])
    {
        // 属性初始化
        self.parentViewController = parentViewController;
        self.showProgress = showProgress;

        // 确保MobileIMSDK被初始化哦（整个APP生生命周期中只需调用一次哦）
        [[IMClientManager sharedInstance] initMobileIMSDK];

        self.imLaunchWrapper = [[IMLaunchWrapper alloc] initWith:parentViewController];
        [self.imLaunchWrapper initConnectToIMServer];
    }
    return self;
}

/**
 * SSO单点登陆核心实现方法。
 *
 * @param ssoReturn SSO服务端返回的信息，为null表示出错了，否则表示成功处理完成并返回
 */
- (void)ssoLoginOK:(SSOReturn *)ssoReturn
{
    // SSO接口连接或处理过程中出错了，SSO单点登陆接口没有成功处理完成
    if(ssoReturn == nil)
    {
        [BasicTool showDialog:@"出错了" message:@"SSO error, please try again!"];
    }
    else
    {
        // SSO认证成功
        if (ssoReturn.code == RET_CODE_OK )
            [self.imLaunchWrapper connectToIMServer:self.cid withUid:ssoReturn.uid andToken:ssoReturn.token];
        else if(ssoReturn.code == RET_CODE_ERROR_INVALID )
        {
            NSString *reson = [NSString stringWithFormat:@"SSO单点登陆失败，原因是：无效的用户uid (%@)", ssoReturn.resultDesc];
            [BasicTool showDialog:@"出错了" message:reson];
        }
        else if(ssoReturn.code == RET_CODE_ERROR_COMMON)
        {
            NSString *reson = [NSString stringWithFormat:@"SSO单点登陆失败，原因是：%@", ssoReturn.resultDesc];
            [BasicTool showDialog:@"出错了" message:reson];
        }
        else
        {
            NSString *reson = [NSString stringWithFormat:@"发生未知SSO单点登陆错误，原因是：%@", ssoReturn.resultDesc];
            [BasicTool showDialog:@"出错了" message:reson];
        }
    }
}

- (void)openIM:(NSString *) cid tel:(NSString *)tel mail:(NSString *)mail appName:(NSString *)appName appVer:(NSString *)appVer
{
    self.cid = cid;

//    if(self.cid == nil || self.cid.length <= 0)
    if([BasicTool isStringEmpty:self.cid])
    {
        [BasicTool showDialog:@"警告" message:@"[TalkMIM-lib]公司ID不可为空！"];
        return;
    }
    
    [libsdk performSelectorOnMainThread:@selector(findCompanySetting) withObject:nil waitUntilDone:YES];
    
//    [libsdk findCompanyAdvertisement];
    
    //            [libsdk findSupportUserDetail:<#(NSString *)#>]   //abcd

    if([ClientCoreSDK sharedInstance].loginHasInit){
        if ([libsdk checkCurrentViewIsChatView:self.parentViewController.navigationController.visibleViewController]){
            
            NSLog(@"Current view is ChatViewController, no need to fire viewController");
        }
        else{
            [self.imLaunchWrapper gotoChatViewController];
        }
    }
    else{
        [self ssoAuth:tel mail:mail appName:appName appVer:appVer];
    }
    
}


-(void)gotoNoChatViewController{
    [self.imLaunchWrapper gotoNoAgentViewController];
}

/**
 SSO网络请求的异步调用实现类。

 @param tel 訪客电话（可选参数）
 @param mail 訪客邮箱（可选参数）
 */
- (void)ssoAuth:(NSString *)tel mail:(NSString *)mail appName:(NSString *)appName appVer:(NSString *)appVer
{
    NSString *url = [IMClientManager getSSOURL:self.cid]; // 20170308起SSO地址是每公司都不一样
    if(tel != nil)
        url = [url stringByAppendingString:[NSString stringWithFormat:@"&tel=%@", tel]];
    if(mail != nil)
        url = [url stringByAppendingString:[NSString stringWithFormat:@"&mail=%@", mail]];
    if(appName != nil)
        url = [url stringByAppendingString:[NSString stringWithFormat:@"&appname=%@", appName]];
    if(tel != nil)
        url = [url stringByAppendingString:[NSString stringWithFormat:@"&tel=%@", tel]];
    if(appVer != nil)
        url = [url stringByAppendingString:[NSString stringWithFormat:@"&appver=%@", appVer]];

    // 尝试从本地缓存中读取之前可能存放的uid（存了uid就表示它之前在此设备登陆过）
    NSString *lastUid = [UserDefaultsToolKits getLastVisitorUid];
    if(lastUid != nil)
        url = [url stringByAppendingString:[NSString stringWithFormat:@"&last_uid=%@", lastUid]];
    
    // 添加上手机设备信息：由Shihao于201707提出要加上的
    url = [url stringByAppendingString:[NSString stringWithFormat:@"&osname=%@%@", @"iOS ", [[UIDevice currentDevice] systemVersion]]];
    url = [url stringByAppendingString:[NSString stringWithFormat:@"&osmodel=%@%@", @"",  [[UIDevice currentDevice] model]]];

    // 显示进度提示
    dispatch_async_main_safe(^{
        [MBProgressHUD showHUDAddedTo:self.parentViewController.view animated:NO];
    });  //20170607
    
    // AF3.0的问题：如果url中有空格这些字符时会崩溃，所以先URLEncode一下
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    // TODO 发布到Talkm正式或测试环境下时使用此https方法哦
    [HttpsGetHelper httpsGetMethod:url progress:nil complete:^(bool sucess, NSString *returnValue) {

        // 结束进度提示
        [MBProgressHUD hideHUDForView:self.parentViewController.view animated:NO];  //20170607

        DDLogDebug(@"[SSOLoginWrapper]【TalkMLib】SSO认证返回原始数据：%@", returnValue);

        if(sucess)
        {
            if(returnValue != nil)
            {
                SSOReturn *ret = [EVAToolKits fromJSON:returnValue withClazz:SSOReturn.class];

                // 将sso服务端返回的uid保存到本地，以便下次登陆时能识别为老用户，从而能加载相应的历史记录等
                if(ret != nil && ret.code == RET_CODE_OK)
                    [UserDefaultsToolKits  setLastVisitorUid:ret.uid];

                // 服务端成功返回了信息
                [self ssoLoginOK:ret];
                
                //store for Talkm
                ShareData *sdata = [ShareData ShareDataAction];
                sdata.token = ret.token;
                sdata.tokenType = @"bearer";
                sdata.visitorID = ret.uid;
            }
            else
            {
                DDLogDebug(@"[SSOLoginWrapper]【TalkMLib】SSO认证返回成功，但奇怪的是数据返回为空！");
            }
        }
        else
        {
            DDLogDebug(@"[SSOLoginWrapper]【TalkMLib】SSO认证出错，原因是：%@", returnValue);
        }
    }];
}

@end

//
//  SSOLoginWrapper.h
//  TalkM_visitor
//
//  Created by JackJiang on 17/4/11.
//  Copyright © 2017年 JackJiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSOLoginWrapper : NSObject

+ (SSOLoginWrapper *)sharedInstance;
- (id)initWith:(UIViewController *)parentViewController;
- (id)initWith:(UIViewController *)parentViewController showProgress:(BOOL)showProgress;


/**
 * 打开IM界面的唯一公开方法。
 *
 * @param cid 公司（租访）的唯一id，本参数不可为空
 * @param tel 客户的电话，非必须参数
 * @param mail 客户的邮箱，非必须参数
 * @param appName 使用SDK的用户自已设定的他的APP名，由Shihao 201707月提出添加
 * @param appVer 使用SDK的用户自已设定的他的APP版本，由Shihao 201707月提出添加
 * @param gid 非必须参数：此访客链接对应的客服组id（可为空，为空表示此访客的分配不需要区分客服组）由Vincent提出，add 20171121
 */
- (void)openIM:(NSString *) cid tel:(NSString *)tel mail:(NSString *)mail appName:(NSString *)appName appVer:(NSString *)appVer gid:(NSString *)gid;

///**
// 进入一对一聊天界面。
// */
//- (void)gotoChatViewController;
//
//- (void)gotoNoAgentViewController;
//
//- (void)gotoLeaveMessageViewController;
//
//- (void)gotoPreSurveyViewController;


//talkmdev - added for reload token after expired
- (void)ssoAuth:(NSString *)tel mail:(NSString *)mail appName:(NSString *)appName appVer:(NSString *)appVer;
@property (nonatomic, retain) NSString *cid;


@end

//
//  SSOLoginWrapper.h
//  TalkM_visitor
//
//  Created by JackJiang on 17/4/11.
//  Copyright © 2017年 JackJiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSOLoginWrapper : NSObject

- (id)initWith:(UIViewController *)parentViewController showProgress:(BOOL)showProgress;

/**
 * 打开IM界面的唯一公开方法。
 *
 * @param cid 公司（租访）的唯一id，本参数不可为空
 * @param tel 客户的电话，非必须参数
 * @param mail 客户的邮箱，非必须参数
 */
- (void)openIM:(NSString *) cid tel:(NSString *)tel mail:(NSString *)mail appName:(NSString *)appName appVer:(NSString *)appVer;

-(void)gotoNoChatViewController;

@end

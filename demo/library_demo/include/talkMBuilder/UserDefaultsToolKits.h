//
//  UserDefaultsToolKits.h
//  TalkM_visitor
//
//  Created by JackJiang on 17/4/11.
//  Copyright © 2017年 JackJiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServicerUidStore.h"

@interface UserDefaultsToolKits : NSObject

/**
 * 获取本地存储的上次使用过的访客uid.
 */

+ (NSString *)getLastVisitorID;
+ (NSString *)getLastChatID;

/**
 * 存储的上次使用过的访客uid.
 */
+ (void)setLastVisitorID:(NSString *)lastVisitorID;
+ (void)setLastChatID:(NSString *)lastChatID;

/**
 * 尝试从cookie中读取存储当前分配的客服id到本地cookie（当前建议生存期30分钟），以便在意外关
 * 闭网页等情况下无需再次进入排队队列，而能正确识别此访客为“老访客”。
 *
 * @returns {ServerResponse|*}
 */
+ (ServicerUidStore *)getServicerUid;

/**
 * 将客服id存储至cookie中，以便在短时间内（比如现在设定的30分钟内）意外关
 * 闭网页等情况下读取到此id而无需再次进入排队队列，而能正确识别此访客为“老访客”。
 *
 * @param servicerId
 * @param serviceRecordId 本次接入对应的客服服务记录id号
 */
+ (void)setServicerUid:(NSString *)servicerUid andSRID:(NSString *)serviceRecordId servicerSignature:(NSString *)servicerSignature servicerAvatarURL:(NSString *)servicerAvatarURL servicerName:(NSString *)servicerName;

@end

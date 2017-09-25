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
+ (NSString *)getLastVisitorUid;

/**
 * 存储的上次使用过的访客uid.
 */
+ (void)setLastVisitorUid:(NSString *)lastVisitorUid;

/**
 * 获取本地存储的分配的客服uid.
 */
+ (ServicerUidStore *)getServicerUid;

/**
 * 存储的上次分配的客服uid.
 *
 * @param serviceRecordId 本次接入对应的客服服务记录id号
 * @return
 */
+ (void)setServicerUid:(NSString *)servicerUid andSRID:(NSString *)serviceRecordId;

@end

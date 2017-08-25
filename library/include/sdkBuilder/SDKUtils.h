//
//  SDKUtils.h
//  TalkM_visitor
//
//  Created by JackJiang on 17/4/4.
//  Copyright © 2017年 JackJiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginInfoExtra.h"
#import "UserDefaultsToolKits.h"
#import "ServicerUidStore.h"
#import "ServicerUidStore.h"

@interface SDKUtils : NSObject

+ (NSString *)loginInfoExtraToJSON:(LoginInfoExtra *)e;

+ (LoginInfoExtra *)loginInfoExtraFromJSON:(NSString *)loginInfoExtraWithJSON;

+ (LoginInfoExtra *)getCurrentLoginExtra;

/**
 * 用于更新loginInfoExtra中的字段并回填。
 *
 * @param latestLoginInfoExtra
 */
+ (void)updateCurrentLoginExtra:(LoginInfoExtra *)latestLoginInfoExtra;

+ (NSString *)getCurrentLoginUserId;

+ (NSString *)getCurrentLoginToken;

/**
 * 尝试从cookie中读取存储当前分配的客服id到本地cookie（当前建议生存期30分钟），以便在意外关
 * 闭网页等情况下无需再次进入排队队列，而能正确识别此访客为“老访客”。
 *
 * @returns {ServerResponse|*}
 */
+ (ServicerUidStore *)readServicerIdFromPreference;

/**
 * 将客服id存储至cookie中，以便在短时间内（比如现在设定的30分钟内）意外关
 * 闭网页等情况下读取到此id而无需再次进入排队队列，而能正确识别此访客为“老访客”。
 *
 * @param servicerId
 * @param serviceRecordId 本次接入对应的客服服务记录id号
 */
+ (void)saveServerIdToPreference:(NSString *)servicerId andSRID:(NSString *)serviceRecordId;

/**
 * 尝试将之前短因果报应存于本地的客服id取出来（因为APP可能意外崩溃或关闭），确保
 * 意外情况下再打开时不需要再次排队，从而保证用户体验。
 *
 * 按照现在的客服分配策略：
 * 1）如果第3方公司在使用IM的访客SDK时，没有硬指定客服id（即没有设定固定的csid）则此
 * 访客后绪将进入排队队列，以通常的新访客的形式进行完整的“排队、分配客服、交谈”逻辑；
 * 2）如果已指定csid，表示像淘宝的网站上的旺旺客服一样，直接为每一个访客链接设定要却是
 * 定的客服从而回归传统的客服模式。
 */
+ (ServicerUidStore *)tryGetStoredServerUid;

+ (void)disconnectToIMServer;

/**
 * 检测当前是否已为本访客分配客服。
 *
 * @returns {boolean} true表示已分配，否则表示未分配
 */
+ (BOOL)hasAllocatedServicer;


@end

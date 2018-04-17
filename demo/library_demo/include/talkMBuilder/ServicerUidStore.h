//
//  ServicerUidStore.h
//  TalkM_visitor
//
//  Created by JackJiang on 17/4/12.
//  Copyright © 2017年 JackJiang. All rights reserved.
//

#import <Foundation/Foundation.h>

// 用于本地存储SSO接口返回分配的uid和客服id等信息的DTO对象
@interface ServicerUidStore : NSObject

@property (nonatomic, copy) NSString *servicerUid;
@property (nonatomic, copy) NSString *servicerName;
@property (nonatomic, copy) NSString *servicerSignature;
@property (nonatomic, copy) NSString *servicerAvatarURL;
@property (nonatomic, assign) long timestamp;
@property (nonatomic, copy) NSString *serviceRecordId;

@end

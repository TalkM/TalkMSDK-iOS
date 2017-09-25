//
//  LoginInfo2.h
//  RainbowChat4i
//
//  Created by JackJiang on 17/3/8.
//  Copyright © 2017年 JackJiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginInfo2 : NSObject

/** 用户登陆名 */
@property (nonatomic, retain) NSString *loginName;
/** 客户端的版本号（ios端为保留字段） */
@property (nonatomic, retain) NSString *clientVersion;
/** 该密码可能是加密后的比特数组 */
@property (nonatomic, retain) NSString *loginPsw;
/**
 * 用于记录用户的登陆设备信息，比如手机登陆时的手机型号等
 * （本字段主要用于信息记录和传递，非核心字段） */
@property (nonatomic, retain) NSString *deviceInfo;
/**
 * 设备系统类型.本字段目前用于有限的场景下，不做硬性要求（ios端为保留字段） */
@property (nonatomic, retain) NSString *osType;

/** 设备标识码：用于唯一标识此设备的id，此体意义由应用层决定（ios端为保留字段） */
@property (nonatomic, retain) NSString *deviceID;

@end

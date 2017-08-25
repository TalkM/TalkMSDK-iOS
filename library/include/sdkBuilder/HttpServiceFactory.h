//
//  HttpServiceFactory.h
//  RainbowChat4i
//
//  Created by JackJiang on 17/3/9.
//  Copyright © 2017年 JackJiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpService.h"

/** 默认服务存放于服务实例列表中的键名 */
#define DEFAULT_SERVICE_NAME "default_service"


@interface HttpServiceFactory : NSObject

/**
 * 添加一个默认服务实例到列表中（默认不允许覆盖列表中的同名服务实例）.
 * serviceName为默认值 DEFAULT_SERVICE_NAME。
 *
 * @param httpURL http rest服务的URL地址，形如: http://127.0.0.1:8080/rest
 * @see #addServices(String, String, String, boolean)
 */
+ (void) addServices:(NSString *)httpURL;

/**
 * 添加一个服务实例到列表中（默认不允许覆盖列表中的同名服务实例）.
 *
 * @param serviceName 服务名
 * @param httpURL http rest服务的URL地址，形如: http://127.0.0.1:8080/rest
 * @see #addServices(String, String, String, boolean)
 */
+ (void) addServices:(NSString *)serviceName withURL:(NSString *)httpURL;

/**
 * 添加一个服务实例到列表中.
 *
 * @param serviceName 服务名
 * @param httpURL http rest服务的URL地址，形如: http://127.0.0.1:8080/rest
 * @param overWrite 如果要添加的服务已经添加到列表中了（据服务名称）
 * 	，是重写还是抛出异常（不允许重写），true表示无条件用新服务实例覆盖已经存在服务实例，否则抛出异常（不允许覆盖）
 */
+ (void) addServices:(NSString *)serviceName withURL:(NSString *)httpURL overWriteIfExists:(bool)overWrite;

/**
 * 获取指定服务名的服务实例引用.
 * @param serviceName 服务名
 * @return  如果该服务实例已经被实例化并放入了列表中则返回它的引用，否则返回null
 */
+ (HttpService *) getService:(NSString *)serviceName;

/**
 * 获得默认的服务实例.
 * @return 如果该默认服务实例已经被实例化并放入了列表中则返回它的引用，否则返回null
 * @see #DEFAULT_SERVICE_NAME
 */
+ (HttpService *) getDefaultService;

/**
 * 获得服务实例列表对象.
 * @return 实例列表
 */
+ (NSMutableDictionary<NSString *, HttpService *> *) getServices;

@end

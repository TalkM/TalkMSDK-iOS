//
//  HttpService.h
//  RainbowChat4i
//
//  Created by JackJiang on 17/3/8.
//  Copyright © 2017年 JackJiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface HttpService : NSObject

// 网络请求超时时间
#define kTimeOutInterval 10

// 网络请求方法define
typedef enum {
    GET,
    POST,
    PUT,
    DELETE,
    HEAD
} HTTPMethod;


- (id)initWithURL:(NSString *)httpURL;

/**
 EVA框架的iOS版HTTP REST数据请求方法。

 @param processorId 必填参数，HTTP REST 框架需要的processorId
 @param jobDispatchId 非必填参数，HTTP REST 框架需要的jobDispatchId，如未无请填-1
 @param actionId 非必填参数，HTTP REST 框架需要的actionId，如未无请填-1
 @param newObj 发送到服务端的newData对象（本方法内部会自动将对象转成JSON文本）
 @param complete 数据回调，参数 sucess表示请求有无处理成功、returnValue表示返回数据（当sucess==YES时为真的数据，否则为错误原因），returnValue返回的一定是NSString文本（可能是JSON文本，也可能只是普通的字串，具体由上层业务逻辑视情况使用）

 */
- (void)sendObjToServer:(int)processorId
            andDispatch:(int)jobDispatchId
              andAction:(int)actionId
            withNewData:(id)newObj
               complete:(void (^)(bool sucess, NSString *returnValue))complete;

/**
 EVA框架的iOS版HTTP REST数据请求方法。

 @param processorId 必填参数，HTTP REST 框架需要的processorId
 @param jobDispatchId 非必填参数，HTTP REST 框架需要的jobDispatchId，如未无请填-1
 @param actionId 非必填参数，HTTP REST 框架需要的actionId，如未无请填-1
 @param newObj 发送到服务端的newData对象（本方法内部会自动将对象转成JSON文本）
 @param progress 上传进度回调block，参数progressValue的值为0~1.0的浮点数（1.0表示上传完成）
 @param complete 数据回调，参数 sucess表示请求有无处理成功、returnValue表示返回数据（当sucess==YES时为真的数据，否则为错误原因），returnValue返回的一定是NSString文本（可能是JSON文本，也可能只是普通的字串，具体由上层业务逻辑视情况使用）
 */
- (void)sendObjToServer:(int)processorId
            andDispatch:(int)jobDispatchId
              andAction:(int)actionId
            withNewData:(id)newObj
               progress:(void (^)(float progressValue))progress
               complete:(void (^)(bool sucess, NSString *returnValue))complete;

/**
 EVA框架的iOS版HTTP REST数据请求方法。

 @param processorId 必填参数，HTTP REST 框架需要的processorId
 @param jobDispatchId 非必填参数，HTTP REST 框架需要的jobDispatchId，如未无请填-1
 @param actionId 非必填参数，HTTP REST 框架需要的actionId，如未无请填-1
 @param newObj 发送到服务端的newData对象（本方法内部会自动将对象转成JSON文本）
 @param oldData 发送到服务端的oldData对象（本方法内部会自动将对象转成JSON文本）
 @param progress 上传进度回调block，参数progressValue的值为0~1.0的浮点数（1.0表示上传完成）
 @param complete 数据回调，参数 sucess表示请求有无处理成功、returnValue表示返回数据（当sucess==YES时为真的数据，否则为错误原因），returnValue返回的一定是NSString文本（可能是JSON文本，也可能只是普通的字串，具体由上层业务逻辑视情况使用）

 */
- (void)sendObjToServer:(int)processorId
            andDispatch:(int)jobDispatchId
              andAction:(int)actionId
            withNewData:(id)newObj
             andOldData:(id)oldData
               progress:(void (^)(float progressValue))progress
               complete:(void (^)(bool sucess, NSString *returnValue))complete;


@end

//
//  HttpsGetHelper.h
//  TalkM_visitor
//
//  Created by JackJiang on 17/4/12.
//  Copyright © 2017年 JackJiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpsGetHelper : NSObject

//+ (void)testHttps;

/**
 一个GET方式实现的HTTPS请求根方法。

 @param urlString https的url地址（可带get参数）
 @param progress 数据上传进度
 @param complete 返回结果回调
 */
+ (void)httpsGetMethod:(NSString *)urlString
              progress:(void (^)(float progressValue))progress
              complete:(void (^)(bool sucess, NSString *returnValue))complete;

@end

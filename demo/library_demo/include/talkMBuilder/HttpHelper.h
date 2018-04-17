//
//  HttpHelper.h
//  RainbowChat4i
//
//  Created by JackJiang on 17/3/4.
//  Copyright © 2017年 JackJiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
//#import "HttpService.h"
//#import "LoginInfo2.h"
//#import "RosterElementEntity.h"

@interface HttpHelper : NSObject

+ (void) uploadFileImpl:(NSString *)filePath
               withName:(NSString *)fileName
                 andUrl:(NSString *)uploadUrl
          andParameters:(NSDictionary *)params
               progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end

//
//  DataFromServer.h
//  RainbowChat4i
//
//  Created by JackJiang on 17/3/8.
//  Copyright © 2017年 JackJiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataFromServer : NSObject

/** 处理成功与否的状态标识：true表示处理成功，反之表示失败 */
@property (nonatomic, assign) bool success;
/** 
 * 处理完成后的返回值（视具体业务而定
 * ，一般来讲，服务器端处理请求时如遇失败，则本对象默认是一个Exception对象）  */
@property (nonatomic, retain) NSString *returnValue;

@end

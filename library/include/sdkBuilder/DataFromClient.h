//
//  DataFromClient.h
//  RainbowChat4i
//
//  Created by JackJiang on 17/3/8.
//  Copyright © 2017年 JackJiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataFromClient : NSObject

/**
 * 客户端是否需要读取服务端返回的数据（对服务端而言就是是否需要写返回写据给客户端
 * ，服务端将据此决定是否要写回数据），本字段对应于 HttpURLConnection.setDoInput(boolean)
 * 并与之保持一致。
 * 注：本字段仅用于底层数据通信，请勿作其它用途！ */
@property (nonatomic, assign) bool doInput;

/** 业务处理器id
 * @see  com.eva.epc.Controller.ends.core.Controller */
@property (nonatomic, assign) int processorId;
/** 作业调度器id
 * @see  com.eva.epc.Controller.ends.core.Controller */
@property (nonatomic, assign) int jobDispatchId;
/** 动作id
 * @see  com.eva.epc.Controller.ends.core.Controller */
@property (nonatomic, assign) int actionId;

/** 具体业务中：客端发送过来的本次修改新数据(可能为空，理论上与oldData不会同时空）*/
@property (nonatomic, retain) NSString *data; // TODO: newData在OC里有特殊意义，所以此处不能写成newData!
/** 具体业务中：客端发送过来的本次修改前的老数据(可能为空，理论上与newData不会同时空）*/
@property (nonatomic, retain) NSString *oldData;

/**
 * 可用于REST请求时客户端携带到服务端作为身份验证之用。
 * <p>
 * 本字段可由框架使用者按需使用，非EVA框架必须的。
 *
 * @since 20170223
 */
@property (nonatomic, retain) NSString *token;

/**
 * 发起HTTP请求的设备类型（默认值为-1，表示未定义）.
 * 此字段为保留字段，具体意义由开发者可自行决定。
 * <p>
 * 当前默认的约定是：0 android平台、1 ios平台、2 web平台。
 */
@property (nonatomic, assign) int device;

@end

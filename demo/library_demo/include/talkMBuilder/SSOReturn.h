//
//  SSOReturn.h
//  TalkM_visitor
//
//  Created by JackJiang on 17/4/12.
//  Copyright © 2017年 JackJiang. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 处理结果码：表示处理成功 */
#define RET_CODE_OK             0
/** 处理结果码： -1：表示非具体意义的失败  */
#define RET_CODE_ERROR_COMMON  -1
/** 处理结果码： -2: 表示该用户不存或者已失败（客户端应据此判
 * 定不允许连接后绪的服务，比如不应让其连接im服务）*/
#define RET_CODE_ERROR_INVALID -2

// 服务端SSO接口返回的原始数据DTO对象
@interface SSOReturn : NSObject

/** 处理结果码 */
@property (nonatomic, assign) int code;// = RET_CODE_ERROR$COMMON;
// 返回的用户uid
@property (nonatomic, retain) NSString *uid;// = "-1";
// 本次生成的token
@property (nonatomic, retain) NSString *token;
@property (nonatomic, retain) NSString *resultDesc;
@property (nonatomic, retain) NSString *expiresIn;

@end

//
//  LoginInfoExtra.h
//  TalkM_visitor
//
//  Created by JackJiang on 17/4/4.
//  Copyright © 2017年 JackJiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginInfoExtra : NSObject

/**
 * 用户登陆Id。
 * 是否必填：是；
 * 使用对象：【1】访客端IM、【2】客服后台端IM。
 */
@property (nonatomic, retain) NSString *loginUserId;
@property (nonatomic, retain) NSString *loginToken;

/**
 * 所属公司id（公司的DB主键id）。
 * 是否必填：是；
 * 使用对象：【1】访客端IM、【2】客服后台端IM。
 */
@property (nonatomic, retain) NSString *cid;
/**
 * 客服id，可能是客服的登陆账号（手机号、邮箱）或DB主键id，具体由业务层决定。
 * 是否必填：是；
 * 使用对象：【1】访客端IM。
 */
@property (nonatomic, retain) NSString *csid;

/**
 * 用户角色：0 访客用户, 1 客服后台用户。
 * 是否必填：是；
 * 使用对象：【1】访客端IM、【2】客服后台端IM；
 */
@property (nonatomic, assign) int role; //= -1;
/**
 * 客户端类型：0 访客-web端, 1 访客-Android端, 2 访客-iOS端, 3 客服后台-Web端, 4 客服后台-Android端, 5 客服后台-iOS端
 * 是否必填：是；
 * 使用对象：【1】访客端IM、【2】客服后台端IM。
 */
@property (nonatomic, assign) int mode;// = -1;

/**
 * 本次接入对应的客服服务记录id号。
 * <p>
 * 本字段目前只用于Android客户端，用于记录分配客服时im服务器送过来的客服服务记录id，
 * 此id将用于后绪的”评价/ratting“功能中。
 *
 * @since 20170309, add by Jack Jiang
 */
@property (nonatomic, retain) NSString *serviceRecordId;

+ (id)initWith:(NSString *)loginUserId andToken:(NSString *)loginToken cid:(NSString *)cid csid:(NSString *)csid;

@end

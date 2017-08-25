//
//  User2.h
//  RainbowChat4i
//
//  Created by JackJiang on 17/3/8.
//  Copyright © 2017年 JackJiang. All rights reserved.
//

/**
 * 本类中用来替换原 {@link User}类的，因原类里用了login_name、login_psw这样的
 * 字段，在使用JSON跨设备进行数据传输时，就无法反射成功了（跟setLoginName、setLoginPsw无法对应起来哦！）。
 * <p>
 * 封装用户认证完成时服务端返回的完整个人用户数据的类.<br>
 * 本类目前仅用于登陆验证时.
 *
 * @author Jack Jiang, 2015-07-24
 * @version 1.0
 */

#import <Foundation/Foundation.h>

@interface User2 : NSObject

/** 登陆账号 */
@property (nonatomic, retain) NSString *loginName;
/** 登陆账号姓名（或称登陆者昵称） */
@property (nonatomic, retain) NSString *trueName;
/** 登陆密码（用户输入的原始密码明文文本） */
@property (nonatomic, retain) NSString *loginPsw;
/** 账号是否可用：0 不可用、1 可用，默认1 */
@property (nonatomic, assign) bool valid;

/**
 * 本字段用于存放用户成功登陆后，服务器当时的系统时间，用于返回给客户端后客户端检查本机时间以
 * 确保客户端的时间与服务器端时间相差太大，以保客户端的单据日期不会太离谱 .
 */
@property (nonatomic, retain) NSString *serverTimeAtLogin;

/**
 * 本客户端的IP地址，目前仅用于登陆成功后，存放服务端读取出的客户端IP地址（理论上是外网IP），
 * 这样返回给客户端后在诸如考勤登记时就可以记下IP地址，以防作弊 。
 *
 * 2011-06-23 add by JS.
 */
@property (nonatomic, retain) NSString *ip;


/**
 * <p>
 * 如果是超级管理员，本方法返回true.
 * 目前只有"admin"是超级管理员，它无权限限制（拥有所有功能的权限）.
 * </p>
 *
 * @return BOOL
 */
- (bool) isSuperMan;

@end

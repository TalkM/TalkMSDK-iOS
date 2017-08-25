//  ----------------------------------------------------------------------
//  Copyright (C) 2015 Jack Jiang The MobileIMSDK Project.
//  All rights reserved.
//  Project URL:  https://github.com/JackJiang2011/MobileIMSDK
//
//  openmob.net PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
//
//  You can contact author with jack.jiang@openmob.net or jb2011@163.com.
//  ----------------------------------------------------------------------
//
//  ToolKits.h
//  MobileIMSDK4i
//
//  Created by JackJiang on 14/10/22.
//  Copyright (c) 2014年 openmob.net. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * 实用工具类。
 *
 * @author Jack Jiang, 2014-10-22
 * @version 1.0
 */
@interface EVAToolKits : NSObject


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 其它实用方法
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///*!
// * 生成 UUID（或者叫GUID）.
// */
//+ (NSString *) generateUUID;
//
///*!
// *  返回系统时间戳（单位：毫秒），浮点表示。
// *
// *  @return 形如：1414074342829.249023
// */
//+ (NSTimeInterval) getTimeStampWithMillisecond;
//
///*!
// *  返回系统时间戳（单位：毫秒），long表示。
// *
// *  @return 形如：1414074342829
// */
//+ (long) getTimeStampWithMillisecond_l;


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - JSON转换相关方法
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


/*
* 一个将JSON文本转成DTO数据内容对象的公开方法.
*
* @param anyObj 一个可以转JSON的数据传输对象
* @retrun 转成JSON后的字符串
* @see getBytesWithString:
* @see fromJSONBytesToDictionary:
* @see fromDictionaryToObject:
*/
+ (id) fromJSON:(NSString *)objWithJSON withClazz:(Class)clazz;

/*
 * 一个将DTO数据内容对象转成JSON文本的的公开方法.
 *
 * @param anyObj 一个可以转JSON的数据传输对象
 * @retrun 转成JSON后的字符串
 * @see toMutableDictionary:
 * @see toJSONBytesWithDictionary:
 * @see toJSONString:
 */
+ (NSString *) toJSON:(id)anyObj;

/*!
 * 将2进制数数据形式的字典对象转换成JSON字符串.
 *
 * @return
 * @see toBytes:
 */
+ (NSString *) toJSONString:(NSData *)datas;

/*!
 * 将字典对象转换成JSON表示的byte数组（以便网络传输）.
 *
 * @return
 * @see toMutableDictionary:
 * @see toGsonString:
 */
+ (NSData *) toJSONBytesWithDictionary:(NSDictionary *)dic;

/*!
 * 将指定对象序列化成NSMutableDictionary。
 *
 * @param obj
 * @return 成功则返回，否则返回nil
 */
+ (NSMutableDictionary *) toMutableDictionary:(id)obj;

/*!
 * 将JSON格式的byte数组转成NSDictionary.
 * 本方法是 toJSONBytesWithDictionary:的逆方法.
 *
 * @param jsonBytes SON格式的byte数组
 * @return 转换成功则返回，否则返回nil
 * @see toJSONBytesWithDictionary:
 */
+ (NSDictionary *) fromJSONBytesToDictionary:(NSData *)jsonBytes;

/*!
 * 将Dictionary描述的Key-values数据反序列化成对象.
 *
 * @param dic key-values
 * @param clazz 要反射的类
 * @return 成功则返回反序列完成的对象，否则返回nil
 */
+ (id) fromDictionaryToObject:(NSDictionary *)dic withClass:(Class)clazz;


@end

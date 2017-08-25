//
//  BasicTool.h
//  CarsDemo
//
//  Created by zoulinlin on 14-4-5.
//
//


//#import "DatePair.h"
//#import "RecordData.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>

#define  HALF_DAY (60*60*12)
#define  ONE_DAY (60*60*24)
#define  ONE_HOUR (60*60)

@interface BasicTool : NSObject

+(void)showDialog:(NSString*)title message:(NSString*)message;
+(void)showDialog:(NSString*)title message:(NSString*)message btnCancel:(NSString*)cancel btnOK:(NSString*)ok withDelegate:(id<UIAlertViewDelegate>)delegate;

+ (BOOL)isStringEmpty:(NSString *)str;

+(NSDate*) updateDate:(NSDate*)date hour:(int)h minute:(int)m second:(int)sec;
//+(DatePair*) getDayDatePair:(NSDate*)day;
//+(DatePair*) getMonthDate:(NSDate*)day;
//+(DatePair*) getWeekDate:(NSDate*)day;

//+ (NSDate*)getDateTimeFromString:(NSString*)timeString;
//+ (NSDate*)getDateFromString:(NSString*)dateString;
//
//+ (NSString*)getDateTimeString:(NSDate*)time;
+ (NSString*)getDateString;//:(NSDate*)date;
+ (NSString*)getTimeString;
+ (NSDate*)getTime;
//+ (NSString*)getMonthString:(NSDate*)date;
//+ (NSString*)getYearAndMonthString:(NSDate*)date;

//+ (NSDateComponents*)getDateComponents:(NSDate*)date;
//+ (NSDate*)clearStartTime:(NSDate*)date;
//+ (NSDate *)secondToDay:(unsigned int)second;
//+ (unsigned long)dayToSecond:(NSDate *)date;

+ (NSMutableAttributedString *)getAttributedText:(NSString *)content contentColor:(UIColor*)contentColor contentFontSize:(int)contentFontSize unit:(NSString*)unit
                                      unitColor:(UIColor*)unitColor unitFontSize:(int)unitFontSize;
//+ (void)addCorner:(UIView*)view;
+ (void)addAvaterCorner:(UIView*)userhead;
+ (void)ajdustScrollViewBaseOnScreenHeight:(UIScrollView*)scrollView;
+ (NSString*)getFileMD5WithPath:(NSString*)path;
+ (NSString*)getCachedPath;
//+ (NSString*)saveImage:(UIImage*)image toFile:(NSString*)fileName;
//+ (NSInteger)calcCaroli:(RecordData*)record;
//+ (NSString*)getSleepHourString:(float)hour unit:(NSString*)unit;
//+ (NSInteger)dayBeginTime:(NSInteger)time;
//+ (NSInteger)dayBeginTimeForDay:(NSDate*)date;
//+ (NSInteger)dayEndTime:(NSInteger)time;
//+ (NSInteger)dayEndTimeForDay:(NSDate*)date;
//+ (NSString*)getDateStringGMT:(NSDate*)date;
//+ (NSString*)getDateTimeStringExt:(NSDate*)time;
//+ (NSDate*)getDateTimeFromStringForServer2:(NSString*)timeString;

//+ (NSString*)getDateTimeStringGMTExt:(NSDate*)time;
//+ (NSString*)getDateTimeGMTString:(NSDate*)time;
//+ (NSDate*)getDateTimeFromStringForServer:(NSString*)timeString;
//+ (NSString*)getDateTimeStringForServer:(NSDate*)time;

//+ (float)calcCurUserCaroli:(int)duration distance:(int)distance;
////durantion 秒,distance 米,weight 千克
//+ (float)calcUserCaroli:(int)duration distance:(int)distance weight:(int)weight;
//
//+ (NSInteger)calcDeviceToday;
//
//+ (NSString*)getUIID:(CBPeripheral *)peripheral;

/**
 *  单个文件的大小.
 *
 *  @param filePath 文件绝对路径
 *
 *  @return 如果文件存在则返回大小，否则返回0
 */
+ (long long) fileSizeAtPath:(NSString*) filePath;

/**
 获取本地沙盒存储的图片.

 @param imageFilePath 图片文件的完整路径
 @return 返回nil表示文件不存在或读取失败，否则返回图片对象
 */
+ (UIImage *)loadImage:(NSString *)imageFilePath;

+ (BOOL)renameFile:(NSString *)originalFilePath toFilePath:(NSString *)newFilePath;

/**
 缩放图片、压缩图片质量的实用方法。

 @param sourceImage 源图
 @param compressionQuality 要压缩的质量
 @param defineWidth 要缩放的最大宽度
 @param savedDir 压缩完成后保存的目录（不带“/”）
 @param savedFileName 压缩完成后要保存的文件名
 @return 返回nil表示压缩过程中出错了，否则返回的是压缩完成后的新文件完整文件路径
 */
+ (NSString *)imageCompressForQualityAndWidth:(UIImage *)sourceImage
                                targetQuality:(CGFloat)compressionQuality
                                  targetWidth:(CGFloat)defineWidth
                                    saveToDir:(NSString *)savedDir
                                    savedName:(NSString *)savedFileName;

/**
 按指定质量压缩图片。

 @param sourceImage 源图
 @param compressionQuality 压缩质量（0~1.0的值）
 @return 压缩后的图片
 */
+ (NSData *)imageCompressForQuality:(UIImage *)sourceImage targetQuality:(CGFloat)compressionQuality;

/**
 按指定宽度等比缩放图片。

 @param sourceImage 源图
 @param defineWidth 指定宽度
 @return 缩放后的图片
 */
+ (UIImage *)imageCompressForWidthScale:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

@end

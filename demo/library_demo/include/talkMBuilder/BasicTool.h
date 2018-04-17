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

+ (NSDate*)getTime;

+ (NSMutableAttributedString *)getAttributedText:(NSString *)content contentColor:(UIColor*)contentColor contentFontSize:(int)contentFontSize unit:(NSString*)unit
                                      unitColor:(UIColor*)unitColor unitFontSize:(int)unitFontSize;


+ (NSString*)getFileMD5WithPath:(NSString*)path;
+ (NSString*)getCachedPath;

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

//
//  NSString+Emojize.h
//  Field Recorder
//
//  Created by Jonathan Beilin on 11/5/12.
//  Copyright (c) 2014 DIY. All rights reserved.
//
//  Inspired by https://github.com/larsschwegmann/Emoticonizer

#import <Foundation/Foundation.h>

@interface NSString (Emojize)

- (NSString *)emojizedString;

- (NSString *)emojized_export_in;
- (NSString *)emojized_export_out;



+ (NSString *)emojizedStringWithString:(NSString *)text;
+ (NSDictionary *)emojiAliases;


+ (NSString *)emojiExport_in:(NSString *)text;
+ (NSString *)emojiExport_out:(NSString *)text;


@end

//
//  JSQRatingMediaItem2.h
//  talkm_visitor_sdk
//
//  Created by Star Systems Internation on 21/06/2017.
//  Copyright © 2017 Star Systems International. All rights reserved.
//

#import "JSQPhotoMediaItem.h"
#import "JSQAudioMediaItem.h"
#import "ChatMsgEntity.h"

@interface JSQRatingMediaItem2 : JSQAudioMediaItem

- (instancetype)initWithCustomView:(UIView *)ratingView msgType:(int)msgType bubbleColor:(NSString *)bubbleColor isNoBubble:(BOOL)isNoBubble webHeight:(NSInteger)webHeight webWidth:(NSInteger)webWidth isSystemMessage:(BOOL)isSystemMessage;


@end

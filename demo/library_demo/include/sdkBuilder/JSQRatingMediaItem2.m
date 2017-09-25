//
//  JSQRatingMediaItem2.m
//  talkm_visitor_sdk
//
//  Created by Star Systems Internation on 21/06/2017.
//  Copyright © 2017 Star Systems International. All rights reserved.
//

//prefix
#import <Availability.h>

#ifndef __IPHONE_3_0
#warning "This project uses features only available in iOS SDK 3.0 and later."
#endif

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Default.h"
#import "BasicTool.h"
#import "CocoaLumberjack.h"
#import "UserMessageType.h"

#ifdef DEBUG
static DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static DDLogLevel ddLogLevel = DDLogLevelInfo;
#endif

#endif
//end prefix

#import "JSQRatingMediaItem2.h"
#import "JSQMessagesMediaViewBubbleImageMasker.h"
#import "ShareData.h"
#import "libsdk.h"

@interface JSQRatingMediaItem2 ()

@property (strong, nonatomic) UIView *cachedMediaView;

@end


@implementation JSQRatingMediaItem2{
    UIView *_showView;
    NSString *_bubbleColor;
    int _msgType;
    BOOL _isRoundBubble;
    BOOL _isNoBubble;
    NSInteger _webHeight;
    NSInteger _webWidth;
}

- (instancetype)initWithCustomView:(UIView *)ratingView msgType:(int)msgType bubbleColor:(NSString *)bubbleColor isRoundBubble:(BOOL)isRoundBubble isNoBubble:(BOOL)isNoBubble webHeight:(NSInteger)webHeight webWidth:(NSInteger)webWidth{

    _showView = ratingView;
    _bubbleColor = bubbleColor;
    _msgType = msgType;
    _cachedMediaView = nil;
    _isRoundBubble = isRoundBubble;
    _isNoBubble = isNoBubble;
    _webHeight = webHeight;
    _webWidth = webWidth;
    
    return self;
}

- (void)setAppliesMediaViewMaskAsOutgoing:(BOOL)appliesMediaViewMaskAsOutgoing
{
    [super setAppliesMediaViewMaskAsOutgoing:appliesMediaViewMaskAsOutgoing];
    _cachedMediaView = nil;
}

#pragma mark - JSQMessageMediaData protocol

- (CGSize)mediaViewDisplaySize
{
    switch (_msgType) {
        case MsgType_RATE:
            return CGSizeMake(220.0f,  //width
                              42.0f   //height
                              );
            break;
            
        case MsgType_END_CONV:   //3 options
            return CGSizeMake(300.0f,  //width
                              75.0f   //height
                              );
            break;
            
        case MsgType_END_CONV_CS:
            return CGSizeMake(300.0f,  //width
                              52.0f   //height
                              );
            break;
        
        case MsgType_END_CONV_AUTO:
            return CGSizeMake(300.0f,  //width
                              75.0f   //height
                              );
            break;
            
        case MsgType_END_CONV_VISITOR:
            return CGSizeMake(300.0f,  //width
                              40.0f   //height
                              );
            break;
            
        case MsgType_COMP_ADV:
            if (_isNoBubble){
                return CGSizeMake(_webWidth,  //width
                                  _webHeight   //height
                                  );
                //            return CGSizeMake(300,  //width
                //                              320   //height
                //                              );
            }
            else{
                return CGSizeMake(0.1f,  //width
                                  0.1f   //height
                                  );
            }
            break;
            
        case MsgType_TRANSFER:
            return CGSizeMake(300,  //width
                              60   //height
                              );
            break;
            
        case UMT_TYPE_CMD_C_SWITCH_SERVICER:   //manual transfer agent from CS
            return CGSizeMake(300,  //width
                              60   //height
                              );
            break;
        default:
            return CGSizeMake(270.0f,  //width
                              42.0f   //height
                              );
            break;
    }
}

-(UIView *)mediaPlaceholderView{
    
    CGRect viewFrame;
    viewFrame.size = self.mediaViewDisplaySize;
    UIView * view = [[UIView alloc] initWithFrame:viewFrame];
    
    return view;
}

- (UIView *)mediaView{
//    CGRect viewFrame;
    CGSize size = [self mediaViewDisplaySize];
    UIView * playView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, size.width, size.height)];
    [playView addSubview:_showView];
    
    //set background color
    //    playView.backgroundColor = [UIColor orangeColor]; // so you can see it
    ShareData *sdata = [ShareData ShareDataAction];
    NSString *strThemeColor = sdata.themeColor;
    if ([_bubbleColor isEqualToString:@"theme"]){
        playView.backgroundColor = [libsdk colorFromHexString2:strThemeColor];
    }
    else if ([_bubbleColor isEqualToString:@"empty"]){
        //no background
        
    }
    else if ([_bubbleColor isEqualToString:@"default"]){
        //default gray color
        //playView.backgroundColor = HexColor(0xe0e0e0);
        playView.backgroundColor = HexColor(0xf2f1f6);
        
    }
    else if (_bubbleColor.length > 0){
        playView.backgroundColor = [libsdk colorFromHexString2:_bubbleColor];
    }
    else{
        
    }
    
    if (! _isNoBubble){
        //show bubble shape
        [JSQMessagesMediaViewBubbleImageMasker applyBubbleImageMaskToMediaView:playView isOutgoing:self.appliesMediaViewMaskAsOutgoing];
        self.cachedMediaView = playView;
    }

    
    return playView;
}

//- (UIView *)mediaView_bk1{
//    CGRect viewFrame;
//    //    viewFrame.size = self.mediaViewDisplaySize;
//    viewFrame.size = CGSizeMake(50.0f, 50.0f);
//    UIView * view = [[UIView alloc] initWithFrame:viewFrame];
////    view.backgroundColor = [UIColor orangeColor]; // so you can see it
//    
//    [view addSubview:_showView];
//    
//    return view;
//}

- (NSUInteger)mediaHash
{
    if (_isRoundBubble){
        return self.hash;
    }
    else{
        return nil;
    }
}

@end

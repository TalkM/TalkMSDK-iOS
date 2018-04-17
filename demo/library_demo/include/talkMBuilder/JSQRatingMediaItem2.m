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
//    BOOL _isRoundBubble;
    BOOL _isNoBubble;
    BOOL _isRatingRequestShow;
//    NSInteger _webHeight;
//    NSInteger _webWidth;
    BOOL _isSystemMessage;
}

- (instancetype)initWithCustomView:(UIView *)ratingView msgType:(int)msgType bubbleColor:(NSString *)bubbleColor isNoBubble:(BOOL)isNoBubble webHeight:(NSInteger)webHeight webWidth:(NSInteger)webWidth isSystemMessage:(BOOL)isSystemMessage{
    
    _showView = [[UIView alloc] init];
    
    _showView = ratingView;
    _bubbleColor = bubbleColor;
    _msgType = msgType;
    _cachedMediaView = nil;
//    _isRoundBubble = isRoundBubble;
    _isNoBubble = isNoBubble;
//    _webHeight = webHeight;
//    _webWidth = webWidth;
    _isSystemMessage = isSystemMessage;
    
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
    int additionalModelHeight = 0;
    
    switch (_msgType) {
        case MsgType_COMP_ADV:
            if (_isNoBubble){
                NSString *model = [libsdk findIphoneModel];
                if ([model isEqualToString:@"iPhone 7 (GSM+CDMA)"] ||
                    [model isEqualToString:@"iPhone 7 (GSM)"]
                    ){  //iphone7
                    additionalModelHeight = 7;
                }
                else if ([model isEqualToString:@"iPhone 7 Plus (GSM+CDMA)"] ||
                         [model isEqualToString:@"iPhone 7 Plus (GSM)"]){  //iphone 7 plus
                    additionalModelHeight = 12;
                }
                else if ([model isEqualToString:@"iPhone 6"]){  //iphone 6
                    additionalModelHeight = 17;
                }
                else{
                    additionalModelHeight = 10;
                }
                
                //            return CGSizeMake(300,  //width
                //                              320   //height
                //                              );
//                return CGSizeMake(_webWidth,  //width
//                                  _webHeight + additionalModelHeight   //height
//                                  );  //20180227 comment
                
                return CGSizeMake(_showView.frame.size.width,                           //width
                                  _showView.frame.size.height + additionalModelHeight   //height
                                  );
            }
            else{
                return CGSizeMake(0.1f,  //width
                                  0.1f   //height
                                  );
            }
            break;
            
        case MsgType_END_CONV_CS:
            //            return CGSizeMake(300.0f,  //width
            //                              52.0f   //height
            //                              );
        case MsgType_END_CONV_AUTO:
            //            return CGSizeMake(300.0f,  //width
            //                              75.0f   //height
            //                              );
        case MsgType_END_CONV_VISITOR:
            //            return CGSizeMake(300.0f,  //width
            //                              40.0f   //height
            //                              );
            return CGSizeMake(_showView.frame.size.width, _showView.frame.size.height + 3);
            break;
            
        case MsgType_RATE:
        //                return CGSizeMake(220.0f,  //width
        //                                  142.0f   //height
        //                                  );
        case MsgType_END_CONV:   //3 options
        //        {
        //            BOOL enable = [libsdk getOfflineMessageEnableSetting];
        //            if (enable){
        //                return CGSizeMake(300.0f,  //width
        //                                  75.0f   //height
        //                                  );
        //
        //            }
        //            else{
        //                return CGSizeMake(280.0f,  //width
        //                                  75.0f   //height
        //                                  );
        //            }
        //        }
        case MsgType_TRANSFER:
        //            return CGSizeMake(300,  //width
        //                              60   //height
        //                              );
        case UMT_TYPE_CMD_C_SWITCH_SERVICER:   //manual transfer agent from CS
        //            return CGSizeMake(300,  //width
        //                              60   //height
        //                              );
        case MsgType_ACTIONABLE_LINK:
        case MsgType_DOCUMENT_PDF:
        case MsgType_DOCUMENT:
        case MsgType_QUEUE_NUMBER:
        case MsgType_QUEUE_NUMBER_LEAVE_MSG:
        case MsgType_BAN_USER:
            return CGSizeMake(_showView.frame.size.width, _showView.frame.size.height);
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
    ShareData *sdata = [ShareData ShareDataAction];
    
    
//    if(CGSizeEqualToSize(CGSizeZero, containerSize)){
        CGSize containerSize = [self mediaViewDisplaySize];
//    }
    
//    NSLog(@"_showView X : %f", _showView.frame.origin.x);
//    NSLog(@"_showView y : %f", _showView.frame.origin.y);
    
    UIView * playView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, containerSize.width, containerSize.height)];
    [playView addSubview:_showView];
    [playView sendSubviewToBack:_showView];
//    playView.backgroundColor = [UIColor redColor]; //testing
    
    //set background color
    //    playView.backgroundColor = [UIColor orangeColor]; // so you can see it
    
    NSString *strThemeColor = sdata.themeColor;
    if ([_bubbleColor isEqualToString:@"theme"]){
        playView.backgroundColor = [libsdk convertColorFromHexString2:strThemeColor];
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
        playView.backgroundColor = [libsdk convertColorFromHexString2:_bubbleColor];
    }
    else{
        
    }
    
    
    if (_isSystemMessage){
        //make the view center in the chat list and no bubble tail
        
        float bubbleMaxWidth = [[libsdk readUserDefaultBubbleWidth] floatValue];
        int systemMsgGapFix = 4;  //20180305 system message cell gap too close
        CGPoint center123 = CGPointMake((bubbleMaxWidth / 2) - 30, _showView.frame.size.height / 2);

        
        playView.center = center123;
        if (_msgType != MsgType_COMP_ADV){  //20171227, somehow it will adjust the _showview for the adverticement eventhought adverticement isSystemMessage = No, so add this line to make sure the center is not apply to webview
            _showView.center = center123;
        }
        
//        NSLog(@"playView.center : %f", center123.x);
//        NSLog(@"playView.center : %f", center123.y);
        
        _isNoBubble = YES;
    }
    
    if (! _isNoBubble){
        //show bubble shape
        [JSQMessagesMediaViewBubbleImageMasker applyBubbleImageMaskToMediaView:playView isOutgoing:self.appliesMediaViewMaskAsOutgoing];
        self.cachedMediaView = playView;
    }
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadAdverticementOnce" object:nil userInfo:nil];
//
//    if ( ![sdata.adverticementProcess isEqualToString:@"D"]){
//        sdata.adverticementProcess = @"P";
//        sdata.adverticementHeight = [NSString stringWithFormat:@"%f", containerSize.height] ;
//        sdata.adverticementWidth = [NSString stringWithFormat:@"%f", containerSize.width] ;
//    }
    

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
//    if (_isRoundBubble){
        return self.hash;
//    }
//    else{
//        return nil;
//    }
}

@end

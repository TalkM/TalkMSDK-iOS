//
//  ChatViewController.h
//  TalkM_visitor
//
//  Created by JackJiang on 17/3/18.
//  Copyright © 2017年 JackJiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSQMessages.h"
#import "NSMutableArrayObservable.h"
#import "JSQMessagesAvatarImage.h"

@interface ChatViewController : JSQMessagesViewController <UIActionSheetDelegate, UIGestureRecognizerDelegate, UIWebViewDelegate, NSURLSessionDelegate>

@property (nonatomic, retain) NSMutableArrayObservable *chattingDatas;

@property (strong, nonatomic) JSQMessagesBubbleImage *outgoingBubbleImageData;

@property (strong, nonatomic) JSQMessagesBubbleImage *incomingBubbleImageData;

@property (strong, nonatomic) JSQMessagesAvatarImage *outgoingAvatarImage;

@property (strong, nonatomic) JSQMessagesAvatarImage *incomingAvatarImage;

@property (nonatomic, assign) bool *isAdvertisement;
@property (retain, nonatomic) UIImage *advImage;


- (void)closePressed:(UIBarButtonItem *)sender;

//+ (void)showActionableScreen:(NSString *)actionID;

//+ (void)showRatingScreen:(NSString *)actionID;

//@property (nonatomic, copy) NSString *endConvChatText;
- (IBAction)abtnCancel:(id)sender;



@end

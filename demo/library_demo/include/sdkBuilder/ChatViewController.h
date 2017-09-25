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

@interface ChatViewController : JSQMessagesViewController <UIActionSheetDelegate, JSQMessagesComposerTextViewPasteDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, retain) NSMutableArrayObservable *chattingDatas;

@property (strong, nonatomic) JSQMessagesBubbleImage *outgoingBubbleImageData;

@property (strong, nonatomic) JSQMessagesBubbleImage *incomingBubbleImageData;

@property (strong, nonatomic) JSQMessagesAvatarImage *outgoingAvatarImage;

@property (strong, nonatomic) JSQMessagesAvatarImage *incomingAvatarImage;

- (void)closePressed:(UIBarButtonItem *)sender;

//+ (void)showRatingScreen:(NSString *)actionID;

//@property (nonatomic, copy) NSString *endConvChatText;


@end

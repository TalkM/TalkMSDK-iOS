//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "JSQMessagesTypingIndicatorFooterView.h"

#import "JSQMessagesBubbleImageFactory.h"

#import "UIImage+JSQMessages.h"

#import "Default.h"
#import "ShareData.h"
#import "libsdk.h"
#import "UIGifImage.h"

const CGFloat kJSQMessagesTypingIndicatorFooterViewHeight = 46.0f;


@interface JSQMessagesTypingIndicatorFooterView ()

@property (weak, nonatomic) IBOutlet UIImageView *bubbleImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bubbleImageViewRightHorizontalConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *typingIndicatorImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typingIndicatorImageViewRightHorizontalConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *incomingAvatarImage;


@end



@implementation JSQMessagesTypingIndicatorFooterView

#pragma mark - Class methods

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([JSQMessagesTypingIndicatorFooterView class])
                          bundle:[NSBundle bundleForClass:[JSQMessagesTypingIndicatorFooterView class]]];
}

+ (NSString *)footerReuseIdentifier
{
    return NSStringFromClass([JSQMessagesTypingIndicatorFooterView class]);
}

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = NO;
    self.typingIndicatorImageView.contentMode = UIViewContentModeScaleAspectFit;
}

#pragma mark - Reusable view

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.bubbleImageView.backgroundColor = backgroundColor;
}

#pragma mark - Typing indicator

- (void)configureWithEllipsisColor:(UIColor *)ellipsisColor
                messageBubbleColor:(UIColor *)messageBubbleColor
               shouldDisplayOnLeft:(BOOL)shouldDisplayOnLeft
                 forCollectionView:(UICollectionView *)collectionView
{
    NSParameterAssert(ellipsisColor != nil);
    NSParameterAssert(messageBubbleColor != nil);
    NSParameterAssert(collectionView != nil);
    
    CGFloat bubbleMarginMinimumSpacing = 6.0f;
    CGFloat indicatorMarginMinimumSpacing = 26.0f;
    
    JSQMessagesBubbleImageFactory *bubbleImageFactory = [[JSQMessagesBubbleImageFactory alloc] init];
    
    if (shouldDisplayOnLeft) {
//        self.bubbleImageView.image = [bubbleImageFactory incomingMessagesBubbleImageWithColor:messageBubbleColor].messageBubbleImage;  //talkmdev - typing border bubble image
        
        self.bubbleImageView.image = [bubbleImageFactory incomingMessagesBubbleImageWithColor:HexColor(0xf2f1f6)].messageBubbleImage;  //talkmdev - typing bubble image
        
        //CGFloat collectionViewWidth = CGRectGetWidth(collectionView.frame);
        CGFloat collectionViewWidth = WINDOW_WIDTH;
        CGFloat bubbleWidth = CGRectGetWidth(self.bubbleImageView.frame);
        CGFloat indicatorWidth = CGRectGetWidth(self.typingIndicatorImageView.frame);
        
        CGFloat bubbleMarginMaximumSpacing = collectionViewWidth - bubbleWidth - bubbleMarginMinimumSpacing;
        CGFloat indicatorMarginMaximumSpacing = collectionViewWidth - indicatorWidth - indicatorMarginMinimumSpacing;
        
//        self.bubbleImageViewRightHorizontalConstraint.constant = bubbleMarginMaximumSpacing;
//        self.typingIndicatorImageViewRightHorizontalConstraint.constant = indicatorMarginMaximumSpacing;
        self.bubbleImageViewRightHorizontalConstraint.constant = WINDOW_WIDTH;
        self.typingIndicatorImageViewRightHorizontalConstraint.constant = WINDOW_WIDTH;
        
    }
    else {
        self.bubbleImageView.image = [bubbleImageFactory outgoingMessagesBubbleImageWithColor:messageBubbleColor].messageBubbleImage;
        
        self.bubbleImageViewRightHorizontalConstraint.constant = bubbleMarginMinimumSpacing;
        self.typingIndicatorImageViewRightHorizontalConstraint.constant = indicatorMarginMinimumSpacing;
    }
    
    [self setNeedsUpdateConstraints];
    
    //talkmdev - typingImage
    NSString *testGifPath = [[[NSBundle bundleForClass:self.class] resourcePath] stringByAppendingPathComponent:@"typing-now-ios.gif"];
    NSData *gifData = [NSData dataWithContentsOfFile:testGifPath];
    
    UIGifImage *gif = [[UIGifImage alloc] initWithData:gifData];
    
    //self.typingIndicatorImageView.image = [[UIImage jsq_defaultTypingIndicatorImage] jsq_imageMaskedWithColor:ellipsisColor];
    self.typingIndicatorImageView.image = gif;
    self.typingIndicatorImageView.layer.cornerRadius = 5;
    
    ShareData *sdata = [ShareData ShareDataAction];
    self.incomingAvatarImage.image = sdata.avatarSmall;
    self.incomingAvatarImage = [libsdk imageConvertCircle:self.incomingAvatarImage];
    
}

@end

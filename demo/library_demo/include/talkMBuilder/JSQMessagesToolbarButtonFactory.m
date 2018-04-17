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

#import "JSQMessagesToolbarButtonFactory.h"

#import "UIColor+JSQMessages.h"
#import "UIImage+JSQMessages.h"
#import "NSBundle+JSQMessages.h"

#import "ShareData.h"
#import "libsdk.h"


@implementation JSQMessagesToolbarButtonFactory

+ (UIButton *)defaultAccessoryButton2Item
{
    UIImage *accessoryImage = [UIImage jsq_defaultAccessoryImage2];
    UIImage *normalImage = accessoryImage;//[accessoryImage jsq_imageMaskedWithColor:[UIColor lightGrayColor]];
//    UIImage *highlightedImage = [UIImage imageNamed:@"ic_im-image-blue"];//[accessoryImage jsq_imageMaskedWithColor:[UIColor darkGrayColor]];  //onclick
    
    UIButton *accessoryButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f
                                                                           , 32.0f//, accessoryImage.size.width
                                                                           , 32.0f)];
    
//    UIButton *accessoryButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f
//                                                                           , accessoryImage.size.width
//                                                                           , accessoryImage.size.height)];
    
    [accessoryButton setImage:normalImage forState:UIControlStateNormal];
//    [accessoryButton setImage:highlightedImage forState:UIControlStateHighlighted];  //20171204 onclick
    
//    accessoryButton.contentMode = UIViewContentModeScaleAspectFit;
    accessoryButton.backgroundColor = [UIColor clearColor];
    accessoryButton.tintColor = [UIColor lightGrayColor];
    
    accessoryButton.accessibilityLabel = [NSBundle jsq_localizedStringForKey:@"accessory_button_accessibility_label"];
    
    return accessoryButton;
}

+ (UIButton *)defaultAccessoryButton3Item
{
//    UIImage *accessoryImage = [UIImage jsq_defaultAccessoryImage2];
//    UIImage *normalImage = accessoryImage;//[accessoryImage jsq_imageMaskedWithColor:[UIColor lightGrayColor]];
    //    UIImage *highlightedImage = [UIImage imageNamed:@"ic_im-image-blue"];//[accessoryImage jsq_imageMaskedWithColor:[UIColor darkGrayColor]];  //onclick
    
    UIButton *accessoryButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f
                                                                           , 32.0f//, accessoryImage.size.width
                                                                           , 32.0f)];
    
    //    UIButton *accessoryButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f
    //                                                                           , accessoryImage.size.width
    //                                                                           , accessoryImage.size.height)];
    
//    [accessoryButton setImage:normalImage forState:UIControlStateNormal];
    //    [accessoryButton setImage:highlightedImage forState:UIControlStateHighlighted];  //20171204 onclick
    
    //    accessoryButton.contentMode = UIViewContentModeScaleAspectFit;
    accessoryButton.backgroundColor = [UIColor clearColor];
    accessoryButton.tintColor = [UIColor lightGrayColor];
    
    accessoryButton.accessibilityLabel = [NSBundle jsq_localizedStringForKey:@"accessory_button_accessibility_label"];
    
    return accessoryButton;
}

+ (UIButton *)defaultAccessoryButtonItem
{
//    UIImage *accessoryImage = [UIImage imageNamed:@"chatting_list_view_tempchat_sendimage_normal_icon"];//[UIImage jsq_defaultAccessoryImage];
    UIImage *accessoryImage = [UIImage jsq_defaultAccessoryImage];
    UIImage *normalImage = accessoryImage;//[accessoryImage jsq_imageMaskedWithColor:[UIColor lightGrayColor]];
    UIImage *highlightedImage = [UIImage imageNamed: @"ic_emoticon-blue"]; //@"chatting_list_view_tempchat_sendimage_pressed_icon"];//[accessoryImage jsq_imageMaskedWithColor:[UIColor darkGrayColor]];

    UIButton *accessoryButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f
                                                                           , 32.0f//, accessoryImage.size.width
                                                                           , 32.0f)];
    [accessoryButton setImage:normalImage forState:UIControlStateNormal];
    [accessoryButton setImage:highlightedImage forState:UIControlStateHighlighted];

    accessoryButton.contentMode = UIViewContentModeScaleAspectFit;
    accessoryButton.backgroundColor = [UIColor clearColor];
    accessoryButton.tintColor = [UIColor lightGrayColor];
    
    accessoryButton.accessibilityLabel = [NSBundle jsq_localizedStringForKey:@"accessory_button_accessibility_label"];

    return accessoryButton;
}

+ (UIButton *)defaultSendButtonItem
{
//    NSString *sendTitle = [NSBundle jsq_localizedStringForKey:@"send"];

    //UIImage *normalImage = [UIImage imageNamed:@"voice_rcd_btn_nor"];// js
    UIImage *normalImage = [UIImage imageNamed:@"ic_send-1"];// js
//    UIImage *highlightedImage = [UIImage imageNamed:@"voice_rcd_btn_pressed"];// js

    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [sendButton setImage:normalImage forState:UIControlStateNormal];// js
//    [sendButton setImage:highlightedImage forState:UIControlStateHighlighted];// js

//    [sendButton setTitle:sendTitle forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor jsq_messageBubbleBlueColor] forState:UIControlStateNormal];
    [sendButton setTitleColor:[[UIColor jsq_messageBubbleBlueColor] jsq_colorByDarkeningColorWithValue:0.1f] forState:UIControlStateHighlighted];
    [sendButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];

    sendButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    sendButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    sendButton.titleLabel.minimumScaleFactor = 0.85f;
    sendButton.contentMode = UIViewContentModeCenter;
    sendButton.tintColor = [UIColor jsq_messageBubbleBlueColor];
    

//    CGFloat maxHeight = 32.0f;
//
//    CGRect sendTitleRect = [sendTitle boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, maxHeight)
//                                                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
//                                                attributes:@{ NSFontAttributeName : sendButton.titleLabel.font }
//                                                   context:nil];
//
//    sendButton.frame = CGRectMake(30.0f,  //0
//                                  30.0f,  //50
//                                  30.0f,//CGRectGetWidth(CGRectIntegral(sendTitleRect)),
//                                  30.0f);  //0
    
//    sendButton = [self setCustomizeSendBackground: sendButton];  //20171129 disable the background

    return sendButton;
}

//+ (UIButton *)defaultSendButtonItem2:(BOOL)isEmojiKeyboard
//{
//    //    NSString *sendTitle = [NSBundle jsq_localizedStringForKey:@"send"];
//
//    //UIImage *normalImage = [UIImage imageNamed:@"voice_rcd_btn_nor"];// js
//    UIImage *normalImage;// js
//    if (isEmojiKeyboard){
//        normalImage = [UIImage imageNamed:@"ic_emoji"];// js
//    }
//    else{
//        normalImage = [UIImage imageNamed:@"ic_keyboard"];// js
//    }
//    //    UIImage *highlightedImage = [UIImage imageNamed:@"voice_rcd_btn_pressed"];// js
//
//    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectZero];
//    [sendButton setImage:normalImage forState:UIControlStateNormal];// js
//    //    [sendButton setImage:highlightedImage forState:UIControlStateHighlighted];// js
//
//    //    [sendButton setTitle:sendTitle forState:UIControlStateNormal];
//    [sendButton setTitleColor:[UIColor jsq_messageBubbleBlueColor] forState:UIControlStateNormal];
//    [sendButton setTitleColor:[[UIColor jsq_messageBubbleBlueColor] jsq_colorByDarkeningColorWithValue:0.1f] forState:UIControlStateHighlighted];
//    [sendButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
//
//    sendButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
//    sendButton.titleLabel.adjustsFontSizeToFitWidth = YES;
//    sendButton.titleLabel.minimumScaleFactor = 0.85f;
//    sendButton.contentMode = UIViewContentModeCenter;
//    sendButton.tintColor = [UIColor jsq_messageBubbleBlueColor];
//
//
//    //    CGFloat maxHeight = 32.0f;
//    //
//    //    CGRect sendTitleRect = [sendTitle boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, maxHeight)
//    //                                                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
//    //                                                attributes:@{ NSFontAttributeName : sendButton.titleLabel.font }
//    //                                                   context:nil];
//    //
//    //    sendButton.frame = CGRectMake(30.0f,  //0
//    //                                  30.0f,  //50
//    //                                  30.0f,//CGRectGetWidth(CGRectIntegral(sendTitleRect)),
//    //                                  30.0f);  //0
//
//    //    sendButton = [self setCustomizeSendBackground: sendButton];  //20171129 disable the background
//
//    return sendButton;
//}

+ (UIButton *)defaultSendButtonItemEnabled
{
    //    NSString *sendTitle = [NSBundle jsq_localizedStringForKey:@"send"];
    
    //UIImage *normalImage = [UIImage imageNamed:@"voice_rcd_btn_nor"];// js
    UIImage *normalImage = [UIImage imageNamed:@"ic_send-2"];// js
    //    UIImage *highlightedImage = [UIImage imageNamed:@"voice_rcd_btn_pressed"];// js
    
    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [sendButton setImage:normalImage forState:UIControlStateNormal];// js
    //    [sendButton setImage:highlightedImage forState:UIControlStateHighlighted];// js
    
    //    [sendButton setTitle:sendTitle forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor jsq_messageBubbleBlueColor] forState:UIControlStateNormal];
    [sendButton setTitleColor:[[UIColor jsq_messageBubbleBlueColor] jsq_colorByDarkeningColorWithValue:0.1f] forState:UIControlStateHighlighted];
    [sendButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    sendButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    sendButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    sendButton.titleLabel.minimumScaleFactor = 0.85f;
    sendButton.contentMode = UIViewContentModeCenter;
    sendButton.tintColor = [UIColor jsq_messageBubbleBlueColor];
    
    
    //    CGFloat maxHeight = 32.0f;
    //
    //    CGRect sendTitleRect = [sendTitle boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, maxHeight)
    //                                                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
    //                                                attributes:@{ NSFontAttributeName : sendButton.titleLabel.font }
    //                                                   context:nil];
    //
    //    sendButton.frame = CGRectMake(30.0f,  //0
    //                                  30.0f,  //50
    //                                  30.0f,//CGRectGetWidth(CGRectIntegral(sendTitleRect)),
    //                                  30.0f);  //0
    
    //    sendButton = [self setCustomizeSendBackground: sendButton];  //20171129 disable the background
    
    return sendButton;
}

+ (UIView *)defaultSendButtonPressArea
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    
    return view;
}

+ (UIButton *)defaultSendButtonItemEnabled2:(BOOL)isEmojiKeyboard
{
    //    NSString *sendTitle = [NSBundle jsq_localizedStringForKey:@"send"];
    
    //UIImage *normalImage = [UIImage imageNamed:@"voice_rcd_btn_nor"];// js
    UIImage *normalImage;
    if (isEmojiKeyboard){
        normalImage = [UIImage imageNamed:@"ic_keyboard"];// js
    }
    else{
        normalImage = [UIImage imageNamed:@"ic_emoji"];// js
    }
    
    //    UIImage *highlightedImage = [UIImage imageNamed:@"voice_rcd_btn_pressed"];// js
    
    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [sendButton setImage:normalImage forState:UIControlStateNormal];// js
    //    [sendButton setImage:highlightedImage forState:UIControlStateHighlighted];// js
    
    //    [sendButton setTitle:sendTitle forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor jsq_messageBubbleBlueColor] forState:UIControlStateNormal];
    [sendButton setTitleColor:[[UIColor jsq_messageBubbleBlueColor] jsq_colorByDarkeningColorWithValue:0.1f] forState:UIControlStateHighlighted];
    [sendButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    sendButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    sendButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    sendButton.titleLabel.minimumScaleFactor = 0.85f;
    sendButton.contentMode = UIViewContentModeCenter;
    sendButton.tintColor = [UIColor jsq_messageBubbleBlueColor];
    
    
    //    CGFloat maxHeight = 32.0f;
    //
    //    CGRect sendTitleRect = [sendTitle boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, maxHeight)
    //                                                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
    //                                                attributes:@{ NSFontAttributeName : sendButton.titleLabel.font }
    //                                                   context:nil];
    //
    //    sendButton.frame = CGRectMake(30.0f,  //0
    //                                  30.0f,  //50
    //                                  30.0f,//CGRectGetWidth(CGRectIntegral(sendTitleRect)),
    //                                  30.0f);  //0
    
    //    sendButton = [self setCustomizeSendBackground: sendButton];  //20171129 disable the background
    
    return sendButton;
}

+ (UIButton *)defaultSendButtonItemEnabled3
{
    
    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectZero];
   // [sendButton setImage:normalImage forState:UIControlStateNormal];// js
    //    [sendButton setImage:highlightedImage forState:UIControlStateHighlighted];// js
    
    //    [sendButton setTitle:sendTitle forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor jsq_messageBubbleBlueColor] forState:UIControlStateNormal];
    [sendButton setTitleColor:[[UIColor jsq_messageBubbleBlueColor] jsq_colorByDarkeningColorWithValue:0.1f] forState:UIControlStateHighlighted];
    [sendButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    sendButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    sendButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    sendButton.titleLabel.minimumScaleFactor = 0.85f;
    sendButton.contentMode = UIViewContentModeCenter;
    sendButton.tintColor = [UIColor jsq_messageBubbleBlueColor];
    
    return sendButton;
}

+(UIButton *) setCustomizeSendBackground: (UIButton *) sendButton{
    
    sendButton.frame = CGRectMake(30, 30, 34, 40);
    
    ShareData *sdata = [ShareData ShareDataAction];
    
    CGFloat padding = 5;
    //    [sendButton setTitleEdgeInsets:UIEdgeInsetsMake(0, padding, 0, -padding)];
    [sendButton setContentEdgeInsets:UIEdgeInsetsMake(padding, 10, padding, padding)];  //talkmdev sendButtonMargin
    sendButton.backgroundColor = [libsdk convertColorFromHexString2:sdata.themeColor]; //talkmdev -send button circle  //[UIColor clearColor];
    sendButton.layer.cornerRadius = sendButton.frame.size.width / 2;   //talkmdev send button radius
    //    sendButton.layer.cornerRadius = 18;   //talkmdev send button radius
    //    sendButton.layer.masksToBounds = true;
    
    return sendButton;
}

@end

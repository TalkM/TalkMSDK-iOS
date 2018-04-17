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

#import "JSQPhotoMediaItem.h"

#import "JSQMessagesMediaPlaceholderView.h"
#import "JSQMessagesMediaViewBubbleImageMasker.h"
#import "libsdk.h"
#import "Default.h"
#import "ShareData.h"


@interface JSQPhotoMediaItem (){
    NSDate *_date;
}

@property (strong, nonatomic) UIImageView *cachedImageView;

@end


@implementation JSQPhotoMediaItem

#pragma mark - Initialization

- (instancetype)initWithImage:(UIImage *)image date:(NSDate *)date
{
    self = [super init];
    if (self) {
        _image = [image copy];
        _cachedImageView = nil;
        _date = date;
    }
    return self;
}

- (void)clearCachedMediaViews
{
    [super clearCachedMediaViews];
    _cachedImageView = nil;
}

#pragma mark - Setters

- (void)setImage:(UIImage *)image
{
    _image = [image copy];
    _cachedImageView = nil;
}

- (void)setAppliesMediaViewMaskAsOutgoing:(BOOL)appliesMediaViewMaskAsOutgoing
{
    [super setAppliesMediaViewMaskAsOutgoing:appliesMediaViewMaskAsOutgoing];
    _cachedImageView = nil;
}

#pragma mark - JSQMessageMediaData protocol

- (UIView *)mediaView
{
    if (self.image == nil) {
        return nil;
    }
    
    if (self.cachedImageView == nil) {
        CGSize size = [self mediaViewDisplaySize];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:self.image];
        imageView.frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
//        imageView.layer.cornerRadius = 10.0;  //set corner will cause the image tail missing
        imageView.layer.masksToBounds = YES;
        
        //display image tail
        [JSQMessagesMediaViewBubbleImageMasker applyBubbleImageMaskToMediaView:imageView isOutgoing:self.appliesMediaViewMaskAsOutgoing];
        
        int timeStampSize = 20;
        int marginRight = 20;
        
        UILabel *lblTimeStamp = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width - marginRight, timeStampSize - 3)];
//        lblTimeStamp.text = @"11:11 PM";
        lblTimeStamp.text  = [libsdk convertDateFormatforBubble:_date];
        lblTimeStamp.textAlignment = NSTextAlignmentRight;
        lblTimeStamp.font = [UIFont systemFontOfSize:11.f];
        
        UIView *vTimeStamp = [[UIView alloc] initWithFrame:CGRectMake(0.0f, size.height - timeStampSize, size.width, timeStampSize)];
        if (self.appliesMediaViewMaskAsOutgoing){
            ShareData *sdata = [ShareData ShareDataAction];
            NSString *strThemeColor = sdata.themeColor;
            
            vTimeStamp.backgroundColor = [libsdk convertColorFromHexString2:strThemeColor];
            
            lblTimeStamp.textColor = [UIColor whiteColor];
        }
        else{
            vTimeStamp.backgroundColor = HexColor(0xf2f1f6);
            lblTimeStamp.textColor = [UIColor blackColor];
        }
        
        [vTimeStamp addSubview:lblTimeStamp];
        [imageView addSubview:vTimeStamp];
        
//        //talkmdev add border
//        CALayer *borderLayer = [CALayer layer];
//        CGRect borderFrame = CGRectMake(0, 0, (imageView.frame.size.width), (imageView.frame.size.height));
//        [borderLayer setBackgroundColor:[[UIColor clearColor] CGColor]];
//        [borderLayer setFrame:borderFrame];
//        [borderLayer setCornerRadius:10.0];
//        [borderLayer setBorderWidth:1.0];
//        [borderLayer setBorderColor:[[UIColor redColor] CGColor]];
////        [borderLayer setBorderColor:[HexColor(0xf2f1f6) CGColor]];
////        [borderLayer setBorderColor:[[libsdk colorFromHexString2:@"f2f1f6"] CGColor]];
//        [imageView.layer addSublayer:borderLayer];
        
        self.cachedImageView = imageView;
    }
    
    return self.cachedImageView;
}

- (NSUInteger)mediaHash
{
    return self.hash;
}

#pragma mark - NSObject

- (NSUInteger)hash
{
    return super.hash ^ self.image.hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: image=%@, appliesMediaViewMaskAsOutgoing=%@>",
            [self class], self.image, @(self.appliesMediaViewMaskAsOutgoing)];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _image = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(image))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.image forKey:NSStringFromSelector(@selector(image))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    
    //JSQPhotoMediaItem *copy = [[JSQPhotoMediaItem allocWithZone:zone] initWithImage:self.image];  //comment 20171204
    JSQPhotoMediaItem *copy = [[JSQPhotoMediaItem allocWithZone:zone] initWithImage:self.image date:_date];
    
//    JSQPhotoMediaItem *copy2 = [[JSQPhotoMediaItem allocWithZone:zone] initWithImage:self.image];
    
    copy.appliesMediaViewMaskAsOutgoing = self.appliesMediaViewMaskAsOutgoing;
    return copy;
}

@end

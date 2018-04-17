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

#import "JSQMessagesTimestampFormatter.h"
#import "libsdk.h"
#import "Default.h"

@interface JSQMessagesTimestampFormatter ()

@property (strong, nonatomic, readwrite) NSDateFormatter *dateFormatter;

@end



@implementation JSQMessagesTimestampFormatter

#pragma mark - Initialization

+ (JSQMessagesTimestampFormatter *)sharedFormatter
{
    static JSQMessagesTimestampFormatter *_sharedFormatter = nil;
    
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        _sharedFormatter = [[JSQMessagesTimestampFormatter alloc] init];
    });
    
    return _sharedFormatter;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setLocale:[NSLocale currentLocale]];
        [_dateFormatter setDoesRelativeDateFormatting:YES];
        
        UIColor *colorDate = [libsdk convertColorFromHexString2:@"2258b0"]; // HexColor(0x2258b0); // today color
        
        //UIColor *color = [UIColor lightGrayColor];
        UIColor *color = HexColor(0x777779);
        
        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        
        _dateTextAttributes = @{ NSFontAttributeName : [UIFont boldSystemFontOfSize:12.0f],
                                 NSForegroundColorAttributeName : colorDate,
                                 NSParagraphStyleAttributeName : paragraphStyle };
        
        _timeTextAttributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:12.0f],
                                 NSForegroundColorAttributeName : color,
                                 NSParagraphStyleAttributeName : paragraphStyle
                                 };
    }
    return self;
}

#pragma mark - Formatter

- (NSString *)timestampForDate:(NSDate *)date
{
    if (!date) {
        return nil;
    }
    
    [self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    return [self.dateFormatter stringFromDate:date];
}

- (NSAttributedString *)attributedTimestampForDate:(NSDate *)date
{
    if (!date) {
        return nil;
    }
    
    NSString *relativeDate = [self relativeDateForDate:date];
    NSString *time = [self timeForDate:date];
    relativeDate = [NSString stringWithFormat:@"   %@", relativeDate];

    //origin
//    NSMutableAttributedString *timestamp = [[NSMutableAttributedString alloc] initWithString:relativeDate
//                                                                                  attributes:self.dateTextAttributes];  //
    
    //    [timestamp appendAttributedString:[[NSAttributedString alloc] initWithString:time
    //                                                                      attributes:self.timeTextAttributes]];
    
    // talkmdev - daily text formating
    NSMutableAttributedString *timestamp = [[NSMutableAttributedString alloc] initWithString:relativeDate attributes:self.timeTextAttributes];
    
    [timestamp appendAttributedString:[[NSAttributedString alloc] initWithString:@", "]];
    
    NSString *dateDD = [libsdk convertDateFormatforTopLabel:date];  //talkmdev - today field
    [timestamp appendAttributedString:[[NSMutableAttributedString alloc] initWithString:dateDD attributes:self.timeTextAttributes]];
    
    [timestamp appendAttributedString:[[NSAttributedString alloc] initWithString:@"   "]];
    
    //daily background attribute
    NSRange range = NSMakeRange(0, [timestamp length]);
    [timestamp addAttribute:NSBackgroundColorAttributeName value:HexColor(0xdddddd) range:range];
    
//    //talkmdev - daily background
//    CGRect bounds = cell.cellTopLabel.bounds;
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds
//                                                   byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(5.0, 5.0)];
//    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    maskLayer.frame = bounds;
//    maskLayer.path = maskPath.CGPath;
//    cell.cellTopLabel.layer.mask = maskLayer;
    
    
    return [[NSAttributedString alloc] initWithAttributedString:timestamp];
}

- (NSString *)timeForDate:(NSDate *)date
{
    if (!date) {
        return nil;
    }
    
    [self.dateFormatter setDateStyle:NSDateFormatterNoStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    return [self.dateFormatter stringFromDate:date];
}

- (NSString *)relativeDateForDate:(NSDate *)date
{
    if (!date) {
        return nil;
    }
    
    [self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    return [self.dateFormatter stringFromDate:date];
}

@end

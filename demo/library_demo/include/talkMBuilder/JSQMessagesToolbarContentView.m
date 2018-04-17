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

#import "JSQMessagesToolbarContentView.h"

#import "UIView+JSQMessages.h"

const CGFloat kJSQMessagesToolbarContentViewHorizontalSpacingDefault = 40.0f;


@interface JSQMessagesToolbarContentView ()

@property (weak, nonatomic) IBOutlet JSQMessagesComposerTextView *textView;

@property (weak, nonatomic) IBOutlet UIView *leftBarButtonContainerView;
@property (weak, nonatomic) IBOutlet UIView *leftBarButton2ContainerView;
@property (weak, nonatomic) IBOutlet UIView *left3BarButtonContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftBarButtonContainerViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftBarButton2ContainerViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left3BarButtonContainerViewWidthConstraint;

@property (weak, nonatomic) IBOutlet UIView *rightBarButtonContainerView;
@property (weak, nonatomic) IBOutlet UIView *right2BarButtonContainerView;
@property (weak, nonatomic) IBOutlet UIView *right3BarButtonContainerView; //for enlarge button press area
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBarButtonContainerViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right2BarButtonContainerViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right3BarButtonContainerViewWidthConstraint; //for enlarge button press area

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftHorizontalSpacingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left2HorizontalSpacingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left3HorizontalSpacingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightHorizontalSpacingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right2HorizontalSpacingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right3HorizontalSpacingConstraint;

@end



@implementation JSQMessagesToolbarContentView

#pragma mark - Class methods

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([JSQMessagesToolbarContentView class])
                          bundle:[NSBundle bundleForClass:[JSQMessagesToolbarContentView class]]];
}

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self setTranslatesAutoresizingMaskIntoConstraints:NO];

    self.leftHorizontalSpacingConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
    self.left2HorizontalSpacingConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
    self.rightHorizontalSpacingConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
    self.right2HorizontalSpacingConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;

    self.backgroundColor = [UIColor clearColor];
}

#pragma mark - Setters

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.leftBarButtonContainerView.backgroundColor = backgroundColor;
    self.leftBarButton2ContainerView.backgroundColor = backgroundColor;
    self.left3BarButtonContainerView.backgroundColor = backgroundColor;
    self.rightBarButtonContainerView.backgroundColor = backgroundColor;
    self.right2BarButtonContainerView.backgroundColor = backgroundColor;
    self.right3BarButtonContainerView.backgroundColor = [UIColor clearColor];
}

- (void)setLeftBarButtonItem:(UIButton *)leftBarButtonItem
{
    if (_leftBarButtonItem) {
        [_leftBarButtonItem removeFromSuperview];
    }

    if (!leftBarButtonItem) {
        _leftBarButtonItem = nil;
        self.leftHorizontalSpacingConstraint.constant = 0.0f;
        self.leftBarButtonItemWidth = 0.0f;
        self.leftBarButtonContainerView.hidden = YES;
        return;
    }

    if (CGRectEqualToRect(leftBarButtonItem.frame, CGRectZero)) {
        leftBarButtonItem.frame = self.leftBarButtonContainerView.bounds;
    }

    self.leftBarButtonContainerView.hidden = NO;
    self.leftHorizontalSpacingConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
    self.leftBarButtonItemWidth = CGRectGetWidth(leftBarButtonItem.frame);

    [leftBarButtonItem setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self.leftBarButtonContainerView addSubview:leftBarButtonItem];
    [self.leftBarButtonContainerView jsq_pinAllEdgesOfSubview:leftBarButtonItem];
    [self setNeedsUpdateConstraints];

    _leftBarButtonItem = leftBarButtonItem;
}

- (void)setLeftBarButton2Item:(UIButton *)leftBarButton2Item
{
    if (_leftBarButton2Item) {
        [_leftBarButton2Item removeFromSuperview];
    }
    
    if (!leftBarButton2Item) {
        _leftBarButton2Item = nil;
        self.left2HorizontalSpacingConstraint.constant = 0.0f;
        self.leftBarButton2ItemWidth = 0.0f;
        self.leftBarButton2ContainerView.hidden = YES;
        return;
    }
    
    if (CGRectEqualToRect(leftBarButton2Item.frame, CGRectZero)) {
        leftBarButton2Item.frame = self.leftBarButton2ContainerView.bounds;
    }
    
    self.leftBarButton2ContainerView.hidden = NO;
    self.left2HorizontalSpacingConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
    self.leftBarButton2ItemWidth = CGRectGetWidth(leftBarButton2Item.frame);
    
    [leftBarButton2Item setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.leftBarButton2ContainerView addSubview:leftBarButton2Item];
    [self.leftBarButton2ContainerView jsq_pinAllEdgesOfSubview:leftBarButton2Item];
    [self setNeedsUpdateConstraints];
    
    _leftBarButton2Item = leftBarButton2Item;
}

- (void)setLeft3BarButtonItem:(UIButton *)left3BarButtonItem
{
    if (_left3BarButtonItem) {
        [_left3BarButtonItem removeFromSuperview];
    }
    
    if (!left3BarButtonItem) {
        _left3BarButtonItem = nil;
        self.left3HorizontalSpacingConstraint.constant = 0.0f;
        self.left3BarButtonItemWidth = 0.0f;
        self.left3BarButtonContainerView.hidden = YES;
        return;
    }
    
    if (CGRectEqualToRect(left3BarButtonItem.frame, CGRectZero)) {
        left3BarButtonItem.frame = self.left3BarButtonContainerView.bounds;
    }
    
    self.left3BarButtonContainerView.hidden = NO;
    self.left3HorizontalSpacingConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
    self.left3BarButtonItemWidth = CGRectGetWidth(left3BarButtonItem.frame);
    
    [left3BarButtonItem setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.left3BarButtonContainerView addSubview:left3BarButtonItem];
    [self.left3BarButtonContainerView jsq_pinAllEdgesOfSubview:left3BarButtonItem];
    [self setNeedsUpdateConstraints];
    
    _left3BarButtonItem = left3BarButtonItem;
}

- (void)setLeftBarButtonItemWidth:(CGFloat)leftBarButtonItemWidth
{
    self.leftBarButtonContainerViewWidthConstraint.constant = leftBarButtonItemWidth;
    [self setNeedsUpdateConstraints];
}

- (void)setLeftBarButton2ItemWidth:(CGFloat)leftBarButton2ItemWidth
{
    self.leftBarButton2ContainerViewWidthConstraint.constant = leftBarButton2ItemWidth;
    [self setNeedsUpdateConstraints];
}

- (void)setLeft3BarButtonItemWidth:(CGFloat)left3BarButtonItemWidth
{
    self.left3BarButtonContainerViewWidthConstraint.constant = left3BarButtonItemWidth;
    [self setNeedsUpdateConstraints];
}

- (void)setRightBarButtonItem:(UIButton *)rightBarButtonItem
{
    if (_rightBarButtonItem) {
        [_rightBarButtonItem removeFromSuperview];
    }

    if (!rightBarButtonItem) {
        _rightBarButtonItem = nil;
        self.rightHorizontalSpacingConstraint.constant = 0.0f;
        self.rightBarButtonItemWidth = 0.0f;
        self.rightBarButtonContainerView.hidden = YES;
        return;
    }

    if (CGRectEqualToRect(rightBarButtonItem.frame, CGRectZero)) {
        rightBarButtonItem.frame = self.rightBarButtonContainerView.bounds;
    }

    self.rightBarButtonContainerView.hidden = NO;
    self.rightHorizontalSpacingConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
    self.rightBarButtonItemWidth = CGRectGetWidth(rightBarButtonItem.frame);

    [rightBarButtonItem setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self.rightBarButtonContainerView addSubview:rightBarButtonItem];
    [self.rightBarButtonContainerView jsq_pinAllEdgesOfSubview:rightBarButtonItem];
    [self setNeedsUpdateConstraints];

    _rightBarButtonItem = rightBarButtonItem;
}

- (void)setRight2BarButtonItem:(UIButton *)right2BarButtonItem
{
    if (_right2BarButtonItem) {
        [_right2BarButtonItem removeFromSuperview];
    }
    
    if (!right2BarButtonItem) {
        _right2BarButtonItem = nil;
        self.rightHorizontalSpacingConstraint.constant = 0.0f;
        self.rightBarButtonItemWidth = 0.0f;
        self.right2BarButtonContainerView.hidden = YES;
        return;
    }
    
    if (CGRectEqualToRect(right2BarButtonItem.frame, CGRectZero)) {
        right2BarButtonItem.frame = self.right2BarButtonContainerView.bounds;
    }
    
    self.right2BarButtonContainerView.hidden = NO;
    self.rightHorizontalSpacingConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
    self.rightBarButtonItemWidth = CGRectGetWidth(right2BarButtonItem.frame);
    
    [right2BarButtonItem setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.right2BarButtonContainerView addSubview:right2BarButtonItem];
    [self.right2BarButtonContainerView jsq_pinAllEdgesOfSubview:right2BarButtonItem];
    [self setNeedsUpdateConstraints];
    
    _right2BarButtonItem = right2BarButtonItem;
}

//20180314 always crash on this
- (void)setRight3BarButtonItem:(UIButton *)right3BarButtonItem
{
    if (_right3BarButtonItem) {
        [_right3BarButtonItem removeFromSuperview];
    }

    if (!right3BarButtonItem) {
        _right3BarButtonItem = nil;
        self.rightHorizontalSpacingConstraint.constant = 0.0f;
        self.right3BarButtonItemWidth = 0.0f;
        self.right3BarButtonContainerView.hidden = YES;
        return;
    }

    if (CGRectEqualToRect(right3BarButtonItem.frame, CGRectZero)) {
        right3BarButtonItem.frame = self.right3BarButtonContainerView.bounds;
    }

    self.right3BarButtonContainerView.hidden = NO;
    self.rightHorizontalSpacingConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
    self.right3BarButtonItemWidth = CGRectGetWidth(right3BarButtonItem.frame);

    [right3BarButtonItem setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self.right3BarButtonContainerView addSubview:right3BarButtonItem];
    [self.right3BarButtonContainerView jsq_pinAllEdgesOfSubview:right3BarButtonItem];
    [self setNeedsUpdateConstraints];

    _right3BarButtonItem = right3BarButtonItem;
}

- (void)setRightBarButtonItemWidth:(CGFloat)rightBarButtonItemWidth
{
    self.rightBarButtonContainerViewWidthConstraint.constant = rightBarButtonItemWidth;
    [self setNeedsUpdateConstraints];
}

- (void)setRightContentPadding:(CGFloat)rightContentPadding
{
    self.rightHorizontalSpacingConstraint.constant = rightContentPadding;
    [self setNeedsUpdateConstraints];
}

- (void)setRight2BarButtonItemWidth:(CGFloat)rightBarButtonItemWidth
{
    self.right2BarButtonContainerViewWidthConstraint.constant = rightBarButtonItemWidth;
    [self setNeedsUpdateConstraints];
}

- (void)setRight2ContentPadding:(CGFloat)rightContentPadding
{
    self.right2HorizontalSpacingConstraint.constant = rightContentPadding;
    [self setNeedsUpdateConstraints];
}

- (void)setRight3BarButtonItemWidth:(CGFloat)rightBarButtonItemWidth
{
    self.right3BarButtonContainerViewWidthConstraint.constant = rightBarButtonItemWidth;
    [self setNeedsUpdateConstraints];
}

- (void)setRight3ContentPadding:(CGFloat)rightContentPadding
{
    self.right3HorizontalSpacingConstraint.constant = rightContentPadding;
    [self setNeedsUpdateConstraints];
}

- (void)setLeftContentPadding:(CGFloat)leftContentPadding
{
    self.leftHorizontalSpacingConstraint.constant = leftContentPadding;
    [self setNeedsUpdateConstraints];
}

- (void)setLeft2ContentPadding:(CGFloat)left2ContentPadding
{
    self.left2HorizontalSpacingConstraint.constant = left2ContentPadding;
    [self setNeedsUpdateConstraints];
}

- (void)setLeft3ContentPadding:(CGFloat)left3ContentPadding
{
    self.left3HorizontalSpacingConstraint.constant = left3ContentPadding;
    [self setNeedsUpdateConstraints];
}

#pragma mark - Getters

- (CGFloat)leftBarButtonItemWidth
{
    return self.leftBarButtonContainerViewWidthConstraint.constant;
}

- (CGFloat)leftBarButton2ItemWidth
{
    return self.leftBarButton2ContainerViewWidthConstraint.constant;
}

- (CGFloat)left3BarButtonItemWidth
{
    return self.left3BarButtonContainerViewWidthConstraint.constant;
}

- (CGFloat)leftContentPadding
{
    return self.leftHorizontalSpacingConstraint.constant;
}

- (CGFloat)left2ContentPadding
{
    return self.left2HorizontalSpacingConstraint.constant;
}

- (CGFloat)left3ContentPadding
{
    return self.left3HorizontalSpacingConstraint.constant;
}


- (CGFloat)rightBarButtonItemWidth
{
    return self.rightBarButtonContainerViewWidthConstraint.constant;
}

- (CGFloat)rightContentPadding
{
    return self.rightHorizontalSpacingConstraint.constant;
}

- (CGFloat)right2BarButtonItemWidth
{
    return self.right2BarButtonContainerViewWidthConstraint.constant;
}

- (CGFloat)right2ContentPadding
{
    return self.right2HorizontalSpacingConstraint.constant;
}

- (CGFloat)right3BarButtonItemWidth
{
    return self.right3BarButtonContainerViewWidthConstraint.constant;
}

- (CGFloat)right3ContentPadding
{
    return self.right3HorizontalSpacingConstraint.constant;
}

#pragma mark - UIView overrides

- (void)setNeedsDisplay
{
    [super setNeedsDisplay];
    [self.textView setNeedsDisplay];
}

@end

//
//  RatingView.h
//  talkm_visitor_sdk
//
//  Created by Star Systems Internation on 07/12/2017.
//  Copyright © 2017 Star Systems International. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RatingView : UIView <UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *vContent;
@property (weak, nonatomic) IBOutlet UIView *vTitle;

@property (weak, nonatomic) IBOutlet UIStackView *svTitle;
@property (weak, nonatomic) IBOutlet UIStackView *svGood;
@property (weak, nonatomic) IBOutlet UIStackView *svNatural;
@property (weak, nonatomic) IBOutlet UIStackView *svBad;
@property (weak, nonatomic) IBOutlet UIView *vGood;
@property (weak, nonatomic) IBOutlet UIView *vNatural;
@property (weak, nonatomic) IBOutlet UIView *vBad;

@property (weak, nonatomic) IBOutlet UIButton *btnGood;
@property (weak, nonatomic) IBOutlet UIButton *btnNatural;
@property (weak, nonatomic) IBOutlet UIButton *btnBad;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblGood;
@property (weak, nonatomic) IBOutlet UILabel *lblNatural;
@property (weak, nonatomic) IBOutlet UILabel *lblBad;

@property (weak, nonatomic) IBOutlet UITextView *txt2;

@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

- (IBAction)abtnGood:(id)sender;
- (IBAction)abtnNatural:(id)sender;
- (IBAction)abtnBad:(id)sender;
- (IBAction)abtnCancel:(id)sender;
- (IBAction)abtnSubmit:(id)sender;

@end


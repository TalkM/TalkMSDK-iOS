//
//  PresurveyViewController.h
//  talkm_visitor_sdk
//
//  Created by Star Systems Internation on 23/03/2018.
//  Copyright © 2018 Star Systems International. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GKActionSheetPicker.h"
#import "CompletionDefine.h"

@interface PresurveyViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate>
//system declare
@property (weak, nonatomic) IBOutlet UITextField *txt1;
@property (weak, nonatomic) IBOutlet UITextField *txt2;
@property (weak, nonatomic) IBOutlet UITextField *txt3;
@property (weak, nonatomic) IBOutlet UITextField *txt4;
@property (weak, nonatomic) IBOutlet UILabel *txtCount;
@property (weak, nonatomic) IBOutlet UITextView *txt5;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

- (IBAction)abtnSubmit:(id)sender;
- (IBAction)abtnSkip:(id)sender;

//self declare
//@property (nonatomic) DownPicker *picker;
@property (nonatomic, strong) GKActionSheetPicker *picker;

@property (nonatomic, copy) ObserverCompletion connectSuccessObserver;
- (void)setConnectSuccessObserver:(ObserverCompletion)connectSuccessObserver;

@end

//
//  ChatLeaveMessageViewController.h
//  talkm_visitor_sdk
//
//  Created by Star Systems Internation on 12/07/2017.
//  Copyright © 2017 Star Systems International. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatLeaveMessageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *view1;  //input field
@property (weak, nonatomic) IBOutlet UIView *view1_1;
@property (weak, nonatomic) IBOutlet UITextField *txt1;
@property (weak, nonatomic) IBOutlet UITextField *txt2;
@property (weak, nonatomic) IBOutlet UITextField *txt3;
@property (weak, nonatomic) IBOutlet UILabel *lbl4;
@property (weak, nonatomic) IBOutlet UITextView *txt4;
@property (weak, nonatomic) IBOutlet UIButton *btnSend;



@property (weak, nonatomic) IBOutlet UIView *view2;  //thank u screen


- (IBAction)abtnSend:(id)sender;

@end

//
//  ChatExportEmailViewController.h
//  talkm_visitor_sdk
//
//  Created by Star Systems Internation on 12/07/2017.
//  Copyright © 2017 Star Systems International. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatExportEmailViewController : UIViewController  <UITextFieldDelegate, UIActionSheetDelegate>
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;

@property (weak, nonatomic) IBOutlet UIButton *btnSend;
- (IBAction)abtnSend:(id)sender;

@end

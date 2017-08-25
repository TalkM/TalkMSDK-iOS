//
//  CompanyProfileViewController.h
//  talkm_visitor_sdk
//
//  Created by Star Systems Internation on 25/07/2017.
//  Copyright © 2017 Star Systems International. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UITextView *lblCompanyDescription;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)abtnBack:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *buttonContainer;


@end

//
//  CompanyProfileViewController.h
//  talkm_visitor_sdk
//
//  Created by Star Systems Internation on 25/07/2017.
//  Copyright © 2017 Star Systems International. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyProfileViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *view0;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *vProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblProfile;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblSignature;
@property (weak, nonatomic) IBOutlet UITextView *lblCompanyDescription;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIStackView *svButton;
@property (weak, nonatomic) IBOutlet UIButton *btnPhone;
@property (weak, nonatomic) IBOutlet UIButton *btnFacebook;
@property (weak, nonatomic) IBOutlet UIButton *btnWeb;
@property (weak, nonatomic) IBOutlet UIButton *btnInstagram;
@property (weak, nonatomic) IBOutlet UIButton *btnEmail;
@property (weak, nonatomic) IBOutlet UIButton *btnTwitter;




@property (weak, nonatomic) IBOutlet UIView *viewBack;
- (IBAction)abtnBack:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *buttonContainer;


@end

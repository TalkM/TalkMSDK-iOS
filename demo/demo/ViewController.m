//
//  ViewController.m
//  demo
//
//  Created by Star Systems Internation on 25/09/2017.
//  Copyright © 2017 Star Systems International. All rights reserved.
//

#import "ViewController.h"
#import "libsdk.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [libsdk initTalkM:self view:self.view tenant:@"2cad7a38-ffb1-11e6-bfaa-080027e52f64" appID:@"5f4f0c42-20a5-4980-8e2e-c6762992c7a0" appSecret:@"z0adR51LPAKdkrpiktlqjQouC2nb42kY21pU5GP3cKLKDNrJvoVvLrB8acZE2CZL" uiViewController:self];
    
    //demo in info
    [libsdk initTalkM:self view:self.view tenant:@"00b4666d-ed43-4f44-9cdb-96dde81adc20" appID:@"2d972dbd-a031-4754-826d-cbd192012366" appSecret:@"XgMGqqoms13frgrAWG4zFYsNPPrePORFwX5scHPHt6TK9nKuTWm0UA7Xsgn0Ptrh" uiViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

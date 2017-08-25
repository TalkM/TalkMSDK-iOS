//
//  ViewController.m
//  demo
//
//  Created by Star Systems Internation on 21/08/2017.
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
    
    NSString *tenantID, *appID,*appSecret;
    
    NSString *baseUrl = [libsdk getPlistPropertiesValue:@"TalkMBaseUrl"];
    
    if ([baseUrl isEqualToString:@"talkm.dev"]){
        //tenant1.dev - iOS client
        tenantID = @"tenant1";
        appID = @"f5592782-1574-4f5b-ba9d-89feefd32682";
        appSecret = @"dXKoXtrxyUkvCYHLWfuC4L9bNREGBgYY5aie8XExXapmFGNp44Uwl8qgRr5HJMnu";
        
    }
    else if([baseUrl isEqualToString:@"talkm.com"]){
        //starsystems.info - iOS2 client
        tenantID = @"starsystems";
        appID = @"4ad84371-584c-48cf-947e-1d1ec70b8a80";
        appSecret = @"0O88lQrGYKj10BccJfWJbFbelTX2sA4ymLHIi5I0jGpdT2yDoMrfG3LOhsOesz6r";
    }
    
    [libsdk initTalkM:self view:self.view tenant:tenantID appID:appID appSecret:appSecret uiViewController:self];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

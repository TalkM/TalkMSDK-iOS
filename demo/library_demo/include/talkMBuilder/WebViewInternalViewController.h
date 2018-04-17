//
//  WebViewInternalViewController.h
//  talkm_visitor_sdk
//
//  Created by Star Systems Internation on 04/01/2018.
//  Copyright © 2018 Star Systems International. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewInternalViewController : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (retain, nonatomic) IBOutlet UIProgressView *pbar;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet NSString *webURL;
@property (retain, nonatomic) NSNumber *messageType;

@end

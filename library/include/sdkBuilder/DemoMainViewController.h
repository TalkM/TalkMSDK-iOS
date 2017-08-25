//
//  DemoMainViewController.h
//  TalkM_visitor
//
//  Created by JackJiang on 17/4/11.
//  Copyright © 2017年 JackJiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoMainViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

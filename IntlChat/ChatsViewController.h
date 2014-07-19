//
//  ChatsViewController.h
//  IntlChat
//
//  Created by Stephani Alves on 7/17/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

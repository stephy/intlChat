//
//  FriendsViewController.h
//  IntlChat
//
//  Created by Stephani Alves on 7/17/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "User.h"
#import "Friend.h"
#import "FriendCell.h"
#import "Chat.h"

@interface FriendsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, CellDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSArray *friendsList;
@property (strong, nonatomic) User *forUser;
@property (assign) BOOL showAllUsers;

- (void)didClickOnCellAtIndex:(NSInteger)cellIndex withData:(id)data;
@end

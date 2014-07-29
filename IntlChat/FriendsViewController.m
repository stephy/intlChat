//
//  FriendsViewController.m
//  IntlChat
//
//  Created by Stephani Alves on 7/17/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//

#import "FriendsViewController.h"
#import "ProfileViewController.h"
#import "ChatViewController.h"

@interface FriendsViewController ()

@end

@implementation FriendsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if (self.forUser == nil) {
            self.forUser = [User currentUser];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableview registerNib:[UINib nibWithNibName:@"FriendCell" bundle:nil] forCellReuseIdentifier:@"FriendCell"];
    self.tableview.rowHeight = 70;
    if (self.showAllUsers == YES) {
        NSLog(@"Loading ALL users");
        [self.forUser allUsersWithCompletion:^(NSArray *friends) {
            self.friendsList = friends;
            [self.tableview reloadData];
        }];
    } else {
        NSLog(@"Loading friends");
        [self.forUser friendsWithCompletion:^(NSArray *friends) {
            self.friendsList = friends;
            [self.tableview reloadData];
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return the number of rows you want in this table view
    return [self.friendsList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Language *lang = [Language instance];
    FriendCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"FriendCell"];
    self.tableview.backgroundColor =[UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    NSDictionary *friend = self.friendsList[indexPath.row];
    cell.usernameLabel.text = friend[@"fullName"];
    cell.languageLabel.text = [lang printableLanguage:friend[@"language"]];
    
    cell.delegate = self;
    cell.cellIndex = indexPath.row;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.showAllUsers == YES) {
        // We'll use this to add users as friends (hack)
        Friend *new = [Friend object];
        new.friender = [User currentUser];
        new.friendee = self.friendsList[indexPath.row];
        new.accepted = YES;
        new.friendshipRequested = [NSDate date];
        new.friendshipStart = [NSDate date];
        [new saveInBackground];
    } else {
        // Normally profile view is shown
        ProfileViewController *pvc = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:[NSBundle mainBundle]];
        pvc.forUser = self.friendsList[indexPath.row];
        
        [self.navigationController pushViewController:pvc animated:YES];
    }
}

- (void)didClickOnCellAtIndex:(NSInteger)cellIndex withData:(id)data {
    // Open a chat for friend at cell index, create one if one doesn't already exist.
    __block Chat *thisChat = nil;
    [Chat chatBetween:[User currentUser] andUser:self.friendsList[cellIndex]
               withCompletion:^(Chat *chat) {
                   thisChat = chat;
                   // initialize and switch to chat view controller
                   ChatViewController *cvc = [[ChatViewController alloc] init];
                   cvc.currentChat = thisChat;
                   [self.navigationController pushViewController:cvc animated:YES];
               }];
}

@end

//
//  FriendsViewController.m
//  IntlChat
//
//  Created by Stephani Alves on 7/17/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//

#import "FriendsViewController.h"
#import "FriendCell.h"
#import "ProfileViewController.h"

@interface FriendsViewController ()

@end

@implementation FriendsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.friendsList = @[ @{@"username": @"Klaus Alves",
                                @"language": @"Portuguese"},
                              @{@"username": @"Marissa Mayer",
                                @"language": @"English"},
                              @{@"username": @"Barry Bishop",
                                @"language": @"English"},
                              @{@"username": @"Bob Storey",
                                @"language": @"English"},
                              @{@"username": @"Kevin Deng",
                                @"language": @"Chinese"}];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableview registerNib:[UINib nibWithNibName:@"FriendCell" bundle:nil] forCellReuseIdentifier:@"FriendCell"];
    self.tableview.rowHeight = 70;
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
    
    FriendCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"FriendCell"];
    self.tableview.backgroundColor =[UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    NSDictionary *friend = self.friendsList[indexPath.row];
    cell.usernameLabel.text = friend[@"username"];
    cell.languageLabel.text = friend[@"language"];
    
    return cell;
}

//on row click open detailed view
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProfileViewController *pvc = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:[NSBundle mainBundle]];
    
    [self.navigationController pushViewController:pvc animated:YES];
}

@end

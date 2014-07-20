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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableview registerNib:[UINib nibWithNibName:@"FriendCell" bundle:nil] forCellReuseIdentifier:@"FriendCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return the number of rows you want in this table view
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FriendCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"FriendCell"];
    
    cell.usernameLabel.text = @"username";
    
    return cell;
}

//on row click open detailed view
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProfileViewController *pvc = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:pvc animated:YES];
}

@end

//
//  MainViewController.m
//  IntlChat
//
//  Created by Stephani Alves on 7/17/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//

#import "MainViewController.h"
#import "ChatsViewController.h"
#import "FriendsViewController.h"
#import "ProfileViewController.h"

@interface MainViewController ()
- (IBAction)onProfileButton:(id)sender;
- (IBAction)onFriendsButton:(id)sender;
- (IBAction)onChatsButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *viewContainer;


@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // Custom initialization
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onProfileButton:(id)sender {
    ProfileViewController *profile = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
    [self.viewContainer addSubview:profile.view];
    [self addChildViewController:profile];
}

- (IBAction)onFriendsButton:(id)sender {
    FriendsViewController *friends = [[FriendsViewController alloc] initWithNibName:@"FriendsViewController" bundle:nil];
    [self.viewContainer addSubview:friends.view];
    [self addChildViewController:friends];
}

- (IBAction)onChatsButton:(id)sender {
    ChatsViewController *chats = [[ChatsViewController alloc] initWithNibName:@"ChatsViewController" bundle:nil];
    [self.viewContainer addSubview:chats.view];
    [self addChildViewController:chats];
}
@end

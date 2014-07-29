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

#import "User.h"
#import "Language.h"

@interface MainViewController ()
@property (strong, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *languageLabel;
@property (strong, nonatomic) IBOutlet UILabel *subscriptLabel;
@property (strong, nonatomic) IBOutlet UIView *viewContainer;

- (IBAction)onProfileButton:(id)sender;
- (IBAction)onFriendsButton:(id)sender;
- (IBAction)onChatsButton:(id)sender;



@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Do stuff.
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    User *myuser = [User currentUser];
    Language *lang = [Language instance];
    
    self.fullNameLabel.text = myuser.fullName;
    self.languageLabel.text = [lang printableLanguage:myuser.language];
    self.subscriptLabel.text = [NSString
      stringWithFormat:@"%@ %@",
      @"All your chats will be displayed in",
      [lang printableLanguage:myuser.language]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onProfileButton:(id)sender {
    ProfileViewController *profile = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
    [self setTitle:@"Profile"];
    [self.viewContainer addSubview:profile.view];
    [self addChildViewController:profile];
}

- (IBAction)onFriendsButton:(id)sender {
    FriendsViewController *friends = [[FriendsViewController alloc] initWithNibName:@"FriendsViewController" bundle:nil];
    [self setTitle:@"Contacts"];
//    friends.showAllUsers = YES; // hack to add users
    [self.viewContainer addSubview:friends.view];
    [self addChildViewController:friends];
}

- (IBAction)onChatsButton:(id)sender {
    ChatsViewController *chats = [[ChatsViewController alloc] initWithNibName:@"ChatsViewController" bundle:nil];
    [self setTitle:@"Chats"];
    [self.viewContainer addSubview:chats.view];
    [self addChildViewController:chats];
}
@end

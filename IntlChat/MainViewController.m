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
//        ChatsViewController *cvc = [[ChatsViewController alloc] init];
//        UINavigationController *cnv = [[UINavigationController alloc] initWithRootViewController:cvc];
//        FriendsViewController *fvc = [[FriendsViewController alloc] init];
//        UINavigationController *fnv = [[UINavigationController alloc] initWithRootViewController:fvc];
//        ProfileViewController *pvc = [[ProfileViewController alloc] init];
//        
//        self.tabBarController = [[UITabBarController alloc] init];
//        self.tabBarController.viewControllers = [NSArray arrayWithObjects:cnv, fnv, pvc, nil];
//        
//        //adding images to tabs
//        UIImage *iconChats = [UIImage imageNamed:@"734-chat.png"];
//        UIImage *iconFriends = [UIImage imageNamed:@"779-users.png"];
//        UIImage *iconProfile = [UIImage imageNamed:@"769-male.png"];
//        
//        UITabBar *tabBar = self.tabBarController.tabBar;
//        UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
//        UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
//        UITabBarItem *item2 = [tabBar.items objectAtIndex:2];
//        
//        [item0 initWithTitle:@"Chats" image:iconChats selectedImage:iconChats];
//        [item1 initWithTitle:@"Friends" image:iconFriends selectedImage:iconFriends];
//        [item2 initWithTitle:@"Profile" image:iconProfile selectedImage:iconProfile];
//        
//        //changing nav bar color / looks
//        //[[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x067AB5)];
//        
//        NSShadow *shadow = [[NSShadow alloc] init];
//        shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
//        shadow.shadowOffset = CGSizeMake(0, 1);
//        [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
//                                                               [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
//                                                               shadow, NSShadowAttributeName,
//                                                               [UIFont fontWithName:@"HelveticaNeue" size:21.0], NSFontAttributeName, nil]];
//        
//        
//        
//        self.window.rootViewController = self.tabBarController;
        
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

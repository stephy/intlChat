//
//  LoginViewController.m
//  IntlChat
//
//  Created by Stephani Alves on 7/17/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//

#import "LoginViewController.h"
#import "SignUpViewController.h"
#import "MainViewController.h"
#import "User.h"

@interface LoginViewController ()
- (IBAction)onLoginButton:(id)sender;
- (IBAction)onSignUpButton:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[UITextField appearance] setTintColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.passwordField.secureTextEntry = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLoginButton:(id)sender {
    [User logInWithUsernameInBackground:self.usernameField.text
           password:self.passwordField.text
           block:^(PFUser *user, NSError *error) {
               if (user) {
                   // Do stuff after successful login.
                   MainViewController *mvc = [[MainViewController alloc] init];
                   UINavigationController *navBar = [[UINavigationController alloc] initWithRootViewController:mvc];
                   [self presentViewController:navBar animated:YES completion:nil];
                   
               } else {
                   // The login failed. Check error to see why.
                   NSLog(@"Login failed: %@", [error description]);
               }
           }];
}

- (IBAction)onSignUpButton:(id)sender {
    SignUpViewController *svc = [[SignUpViewController alloc] init];
    [self presentViewController:svc animated:YES completion:nil];
}
@end

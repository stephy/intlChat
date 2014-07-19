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

@interface LoginViewController ()
- (IBAction)onLoginButton:(id)sender;
- (IBAction)onSignUpButton:(id)sender;

@end

@implementation LoginViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLoginButton:(id)sender {
    MainViewController *mvc = [[MainViewController alloc] init];
    [self presentViewController:mvc animated:YES completion:nil];
}

- (IBAction)onSignUpButton:(id)sender {
    SignUpViewController *svc = [[SignUpViewController alloc] init];
    [self presentViewController:svc animated:YES completion:nil];
}
@end

//
//  SignUpViewController.m
//  IntlChat
//
//  Created by Stephani Alves on 7/17/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//

#import "SignUpViewController.h"
#import "MainViewController.h"

@interface SignUpViewController ()
- (IBAction)onSignUpFormButton:(id)sender;

@end

@implementation SignUpViewController

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

- (IBAction)onSignUpFormButton:(id)sender {
    MainViewController *mvc = [[MainViewController alloc] init];
    UINavigationController *navBar = [[UINavigationController alloc] initWithRootViewController:mvc];
    
    [self presentViewController:navBar animated:YES completion:nil];
}
@end

//
//  SignUpViewController.m
//  IntlChat
//
//  Created by Stephani Alves on 7/17/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//

#import "SignUpViewController.h"
#import "MainViewController.h"

#import "User.h"


@interface SignUpViewController()

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *password1TextField;
@property (strong, nonatomic) IBOutlet UITextField *password2TextField;
@property (strong, nonatomic) IBOutlet UIPickerView *languagePickerView;

@property (strong, nonatomic) NSString *lang;
@property (strong, nonatomic) NSDictionary *pickerOptions;
@property (strong, nonatomic) NSArray *pickerDisplayOptions;

- (IBAction)onSignUpFormButton:(id)sender;

@end

@implementation SignUpViewController


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
    self.pickerOptions = @{ @"English" : @"en",
                            @"Portuguese" : @"pt",
                            @"Spanish" : @"es"
                            };
    self.pickerDisplayOptions = [self.pickerOptions allKeys];
    self.languagePickerView.delegate = self;
    self.languagePickerView.dataSource = self;
    [self.languagePickerView reloadAllComponents];

    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSignUpFormButton:(id)sender {
    if (! [self.password1TextField.text isEqual: self.password2TextField.text]) {
        NSLog(@"Passwords didn't match, try again");
    } else {
        int row = [self.languagePickerView selectedRowInComponent:0];
        
        [User signupNewUser:self.usernameTextField.text withPassword:self.password1TextField.text
                  withEmail:self.emailTextField.text withLanguage: [self.pickerOptions valueForKey: self.pickerDisplayOptions[row]] withFullName:self.nameTextField.text];
        
        
        MainViewController *mvc = [[MainViewController alloc] init];
        UINavigationController *navBar = [[UINavigationController alloc] initWithRootViewController:mvc];
        [self presentViewController:navBar animated:YES completion:nil];
    }
}

#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerDisplayOptions.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return self.pickerDisplayOptions[row];
}

@end

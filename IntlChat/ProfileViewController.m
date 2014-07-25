//
//  ProfileViewController.m
//  IntlChat
//
//  Created by Stephani Alves on 7/17/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//

#import "UIImageView+AFNetworking.h"

#import "ProfileViewController.h"

@interface ProfileViewController ()
@property (strong, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UILabel *languageLabel;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;

@end

@implementation ProfileViewController

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
    
    Language *lang = [Language instance];
    
    if (self.forUser == nil) {
        self.forUser = [User currentUser];
    }
    self.emailLabel.text = self.forUser.email;
    self.languageLabel.text = [lang printableLanguage:self.forUser.language];
    self.firstNameLabel.text = [self.forUser firstName];
    self.lastNameLabel.text = [self.forUser lastName];    

    if (self.profileImageView != nil) {
        [self.profileImageView setImageWithURL:
          [NSURL URLWithString:self.forUser.profileImageURL]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

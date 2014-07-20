//
//  MessageViewController.m
//  IntlChat
//
//  Created by Stephani Alves on 7/20/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()
@property (strong, nonatomic) IBOutlet UILabel *originalMessageLabel;
@property (strong, nonatomic) IBOutlet UILabel *translatedMessageText;

@end

@implementation MessageViewController

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

@end

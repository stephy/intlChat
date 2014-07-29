//
//  ChatViewController.h
//  IntlChat
//
//  Created by Stephani Alves on 7/17/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chat.h"

@interface ChatViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSDictionary *chat;
@property (nonatomic, strong) NSString *currentUser; //needs to change to PF USER?
@property (strong, nonatomic) IBOutlet UITextField *messageTextfield;
@property (nonatomic, strong) NSString *friendUser;

@property (strong,nonatomic) Chat *currentChat;

///- (BOOL)cellIsSelected:(NSIndexPath *)indexPath;
- (IBAction)onSendButton:(id)sender;

@end

//
//  ChatViewController.m
//  IntlChat
//
//  Created by Stephani Alves on 7/17/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//

#import "ChatViewController.h"
#import "MessageCell.h"
#import "MessageViewController.h"
#import "MessageFriendCell.h"

int const MESSAGE_BAR_OFFSET = 10;

@interface ChatViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *messageField;
@property (strong, nonatomic) NSMutableArray *messages;
@property (strong, nonatomic) MessageCell *msgCell;
@property (strong, nonatomic) MessageFriendCell *msgFriendCell;
@property BOOL keyboardIsShown;

@end

@implementation ChatViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.currentUser = @"Bruce Wayne";
        // Custom initialization
        
        NSArray *messages = @[ @{ @"username": @"Stephani Alves",
                              @"original_message": @"Oi Tudo bom?",
                              @"translated_message": @"Hi, how are you? Hi, how are you? Hi, how are you?  It is a diet shake... It is pretty good.. it is supposed to be really good for you. You can read more about it here: Stephani It is a diet shake... It is pretty good.. it is supposed to be really good for you. You can read more about it here:" },
                           @{ @"username": @"Bruce Wayne",
                              @"original_message": @"I am doing great, How about you?",
                              @"translated_message": @"I am doing great, How about you?" },
                           @{ @"username": @"Stephani Alves",
                              @"original_message": @"Eu tive um otimo final de semana",
                              @"translated_message": @"I had a great weekend!" },
                           @{ @"username": @"Stephani Alves",
                              @"original_message": @"nao",
                              @"translated_message": @"no" },
                              ];
        self.messages = [[NSMutableArray alloc] initWithArray:messages];
                           
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //load personalized cell
    //registration process
    [self.tableView registerNib:[UINib nibWithNibName:@"MessageCell" bundle:nil] forCellReuseIdentifier:@"MessageCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MessageFriendCell" bundle:nil] forCellReuseIdentifier:@"MessageFriendCell"];
    //dismiss keyboard
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                          action:@selector(dismissKeyboard)];
//    
//    [self.view addGestureRecognizer:tap];
    //move chat view when keyboard shows
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
    self.keyboardIsShown = NO;
    //make contentSize bigger than your scrollSize
    CGSize scrollContentSize = CGSizeMake(320, 345);
    self.scrollView.contentSize = scrollContentSize;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSendButton:(id)sender {
    NSLog(@"send %@", self.messageField.text);
    [self.messages addObject:@{ @"username": @"Bruce Wayne",
                               @"original_message": self.messageField.text ,
                                @"translated_message": self.messageField.text }];
    [self.tableView reloadData];
    
    //clean textbox
    self.messageField.text =@"";
    
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return the number of rows you want in this table view
    return [self.messages count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *messageDetails = self.messages[indexPath.row];
    self.tableView.backgroundColor =[UIColor clearColor];
    
    //current user cell
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
    //no flashing on the cell
    //this will prevent the cell to highlight for a bit before the will select returns nil
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.messageLabel.text = messageDetails[@"translated_message"];
    
    // friend cell settings
    MessageFriendCell *friendCell = [tableView dequeueReusableCellWithIdentifier:@"MessageFriendCell"];
    
    //no flashing on the cell
    //this will prevent the cell to highlight for a bit before the will select returns nil
    friendCell.selectionStyle = UITableViewCellSelectionStyleNone;
    friendCell.backgroundColor = [UIColor clearColor];
    friendCell.messageLabel.text = messageDetails[@"translated_message"];
    
    
    //add gesture recognizer to show translation
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [friendCell.messageView addGestureRecognizer:singleFingerTap];
    
    //load cell depending on the user
    if ([messageDetails[@"username"] isEqualToString:self.currentUser]) {
        return cell;
    } else {
        return friendCell;
    }
}

//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    
    //Do stuff here..
    NSLog(@"tapped");
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //don't allow the cell to be clicked
    return nil;
}

//calculate cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *messageDetails = self.messages[indexPath.row];
    
    //load cell depending on the user
    if ([messageDetails[@"username"] isEqualToString:self.currentUser]) {
        //calculate height based on cell
        if (!self.msgCell){
            self.msgCell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
        }
        //configure the cell
        self.msgCell.messageLabel.text = messageDetails[@"translated_message"];
        //layout the cell
        [self.msgCell layoutIfNeeded];
        CGFloat height = [self.msgCell.contentView systemLayoutSizeFittingSize:(UILayoutFittingCompressedSize)].height;
        //get the height
        NSLog(@"height: %1.f", height);
        return height;
    } else {
        //calculate height based on cell
        if (!self.msgFriendCell){
            self.msgFriendCell = [tableView dequeueReusableCellWithIdentifier:@"MessageFriendCell"];
        }
        
        //configure the cell
        self.msgFriendCell.messageLabel.text = messageDetails[@"translated_message"];
        //layout the cell
        [self.msgFriendCell layoutIfNeeded];

        CGFloat height = [self.msgFriendCell.contentView systemLayoutSizeFittingSize:(UILayoutFittingCompressedSize)].height;
        //get the height
        NSLog(@"height: %1.f", height);
        return height;

    }

}

- (void)keyboardWillHide:(NSNotification *)n
{
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // resize the scrollview
    CGRect viewFrame = self.scrollView.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height += (keyboardSize.height + MESSAGE_BAR_OFFSET);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.scrollView setFrame:viewFrame];
    [UIView commitAnimations];
    
    self.keyboardIsShown = NO;
}

- (void)keyboardWillShow:(NSNotification *)n
{
    // This is an ivar I'm using to ensure that we do not do the frame size adjustment on the `UIScrollView` if the keyboard is already shown.  This can happen if the user, after fixing editing a `UITextField`, scrolls the resized `UIScrollView` to another `UITextField` and attempts to edit the next `UITextField`.  If we were to resize the `UIScrollView` again, it would be disastrous.  NOTE: The keyboard notification will fire even when the keyboard is already shown.
    if (self.keyboardIsShown) {
        return;
    }
    
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // resize the noteView
    CGRect viewFrame = self.scrollView.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height -= (keyboardSize.height + MESSAGE_BAR_OFFSET);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.scrollView setFrame:viewFrame];
    [UIView commitAnimations];
    self.keyboardIsShown = YES;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(void)dismissKeyboard {
    [self.messageField resignFirstResponder];
}

@end

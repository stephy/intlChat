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

int const MESSAGE_BAR_OFFSET = 10;

@interface ChatViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *messageField;
@property (strong, nonatomic) NSMutableArray *messages;
@property (strong, nonatomic) MessageCell *msgCell;
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
                              @"translated_message": @"Hi, how are you?" },
                           @{ @"username": @"Bruce Wayne",
                              @"original_message": @"I am doing great, How about you?",
                              @"translated_message": @"I am doing great, How about you?" },
                           @{ @"username": @"Stephani Alves",
                              @"original_message": @"Eu tive um otimo final de semana",
                              @"translated_message": @"I had a great weekend!" },
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
    //make contentSize bigger than your scrollSize (you will need to figure out for your own use case)
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

    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
    self.tableView.backgroundColor =[UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    
    NSDictionary *messageDetails = self.messages[indexPath.row];
    
    if ([messageDetails[@"username"] isEqualToString:self.currentUser]) {
        
        NSLog(@"SAME");
        
    }
    cell.usernameLabel.text = messageDetails[@"username"];
    cell.messageLabel.text = messageDetails[@"translated_message"];
    
    return cell;
}

//on row click open detailed view
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    MessageViewController *mvc = [[MessageViewController alloc] initWithNibName:@"MessageViewController" bundle:[NSBundle mainBundle]];
    mvc.currentMessage = self.messages[indexPath.row];
    [self.navigationController pushViewController:mvc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //calculate height based on cell
    if (!self.msgCell){
        self.msgCell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
    }
    NSDictionary *messageDetails = self.messages[indexPath.row];
    //configure the cell
    self.msgCell.usernameLabel.text = messageDetails[@"username"];
    self.msgCell.messageLabel.text = messageDetails[@"translated_message"];
    
    
    //layout the cell
    [self.msgCell layoutIfNeeded];
    CGFloat height = [self.msgCell.contentView systemLayoutSizeFittingSize:(UILayoutFittingCompressedSize)].height;
    //get the height
    
    return height;
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

@end

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

int const MESSAGE_BAR_OFFSET = 8;
int const MAX_CALLS = 2;

@interface ChatViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *messageField;
@property (strong, nonatomic) NSMutableArray *messages;
@property (strong, nonatomic) MessageCell *msgCell;
@property (strong, nonatomic) MessageFriendCell *msgFriendCell;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;
@property int currentIndexPathRow;
@property (strong, nonatomic) NSIndexPath *currentIndexPath;
@property (strong, nonatomic) NSMutableArray *rowShowingTranslation;
@property (strong, nonatomic) NSMutableDictionary *selectedIndexes;
@property CGRect translationTopFrame;

@property BOOL keyboardIsShown;

@end

@implementation ChatViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.currentUser = [User currentUser];

        NSArray *rowTranslationSelected = @[@NO, @NO, @NO, @NO];
        self.rowShowingTranslation = [[NSMutableArray alloc] initWithArray:rowTranslationSelected];
        
        
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
    
    [self.currentChat getChatMessagesWithCompletion:^(NSArray *messages) {
        self.messages = [NSMutableArray arrayWithArray:messages];
        NSLog(@"Got %d messages:\n %@", self.messages.count, self.messages);
        // Make sure rowShowingTranslation is as long as messages array
        for (int i=self.rowShowingTranslation.count; i <= self.messages.count; i++) {
            [self.rowShowingTranslation addObject:@NO];
        }
        
        [self.tableView reloadData];
    }];
    
    
    //send a message every too seconds for testing
//    NSTimer* myTimer = [NSTimer scheduledTimerWithTimeInterval: 2.0 target: self
//                                                      selector: @selector(onReceiveMessage) userInfo: nil repeats: YES];
    
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
    
    self.selectedIndexes = [[NSMutableDictionary alloc] init];
    
    //set cursor color
    [[UITextView appearance] setTintColor:[UIColor colorWithRed:1 green:0 blue:0.376 alpha:1] /*#1ad4fd*/];
}

- (void)viewDidUnload {
	self.selectedIndexes = nil;
	
	[super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


////create random chat from another person for test purposes
//- (void) onReceiveMessage{
//    [self.messages addObject: @{ @"username": @"Stephani Alves",
//                                 @"original_message": @"Eu tive um otimo final de semana",
//                                 @"translated_message": @"I had a great weekend!" }];
//    [self.tableView reloadData];
//}

- (IBAction)onSendButton:(id)sender {
    if (! [self.messageField.text isEqualToString:@""]) {
        // Only send if there's something other than blank text
        NSLog(@"send %@", self.messageField.text);
        Message *new = [Message object];
        new.sender = self.currentUser;
        new.chat = self.currentChat;
        new.messageSent = [NSDate date];
        new.messageOriginal = self.messageField.text;
        new.messageTranslated = self.messageField.text;
        new.messageOriginalLanguage = self.currentUser.language;
        new.messageTranslatedLanguage = [self.currentChat chatPartner].language;
        [new saveInBackground];
        [self.messages addObject: new];
        [self.rowShowingTranslation addObject:@NO];
        [self.tableView reloadData];
        
        //scroll to top
        [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentOffset.y + 20) animated:YES];
        
        //clear textbox
        self.messageField.text =@"";
    }
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return the number of rows you want in this table view
    return [self.messages count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Message *message = self.messages[indexPath.row];
    self.tableView.backgroundColor =[UIColor clearColor];
    
    //current user cell
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
    //no flashing on the cell
    //this will prevent the cell to highlight for a bit before the will select returns
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.messageLabel.text = message.messageTranslated;
    
    // friend cell settings
    MessageFriendCell *friendCell = [tableView dequeueReusableCellWithIdentifier:@"MessageFriendCell"];
    
    //no flashing on the cell
    //this will prevent the cell to highlight for a bit before the will select returns nil
    friendCell.selectionStyle = UITableViewCellSelectionStyleNone;
    friendCell.backgroundColor = [UIColor clearColor];
    friendCell.messageLabel.text = message.messageTranslated;
    friendCell.translationLabel.text = message.messageOriginal;
    friendCell.translationView.hidden = YES;
    
    //add gesture recognizer to message, so user can tap to see translation
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    
    [friendCell.messageView addGestureRecognizer:singleFingerTap];
    
    //load cell depending on the user
    if ([message.sender.username isEqualToString: self.currentUser.username]) {
        return cell;
    } else {
        return friendCell;
    }
}

////The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer{
    
    UIView *tappedView = [recognizer.view hitTest:[recognizer locationInView:recognizer.view] withEvent:nil];
    
    CGPoint location = [recognizer locationInView:[recognizer.view self]];
    

    NSIndexPath *currentIndexPath = [self.tableView indexPathForRowAtPoint:[recognizer locationInView:self.tableView]];
    
    //set selected path
    self.selectedIndexPath = currentIndexPath;

    NSDictionary *message = self.messages[currentIndexPath.row];
    if(currentIndexPath != nil){
        // remove the cell from tableview
        //Do stuff here..
        NSLog(@"tapped view # %d", currentIndexPath.row);
        NSLog(@"x: %f", location.x);
        NSLog(@"y: %f", location.y);
        NSLog(@"message %@", message);
        MessageFriendCell *selectedCell = [self.tableView cellForRowAtIndexPath:self.selectedIndexPath];
        
        //check to see if message is showing translation already
        if ([self.rowShowingTranslation[currentIndexPath.row]  isEqual: @NO]) {
            //show translation
            selectedCell.translationView.hidden = NO;
            CGRect newFrame = selectedCell.translationView.frame;
            newFrame.origin.y = selectedCell.messageView.frame.size.height;    // shift right by 500pts
            NSLog(@"click newFrame.origin.y %f", newFrame.origin.y);
            [UIView animateWithDuration:0.2
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 selectedCell.translationView.frame = newFrame;
                             }
                             completion:^(BOOL finished) {
                                 self.rowShowingTranslation[currentIndexPath.row] = @YES;
                             }];
            
            
        } else {
            //dismiss translation
            //remove translation view
            NSLog(@"remove tranlation");
            CGRect newFrame = selectedCell.translationView.frame;
            newFrame.origin.y = selectedCell.messageView.frame.size.height - selectedCell.translationView.frame.size.height;
            NSLog(@"unclick newFrame.origin.y %f", newFrame.origin.y);
            [UIView animateWithDuration:0.2
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 selectedCell.translationView.frame = newFrame;
                             }
                             completion:^(BOOL finished) {
                                 selectedCell.translationView.hidden = YES;
                                 self.rowShowingTranslation[currentIndexPath.row] = @NO;
                             }];
            
            
        }//end else
        
        
    }//end if currentIndexPath !=null
    

}

//- (BOOL)cellIsSelected:(NSIndexPath *)indexPath {
//	// Return whether the cell at the specified index path is selected or not
//	NSNumber *selectedIndex = [self.selectedIndexes objectForKey:indexPath];
//    NSLog(@"selected xxx index %@", selectedIndex);
//	return selectedIndex == nil ? FALSE : [selectedIndex boolValue];
//}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"dismissing keyboard");
    //dismiss keyboard
    [self.messageField resignFirstResponder];
    
//    // Deselect cell
//	[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
//	
//	// Toggle 'selected' state
//	BOOL isSelected = ![self cellIsSelected:indexPath];
//	
//	// Store cell 'selected' state keyed on indexPath
//	NSNumber *selectedIndex = [NSNumber numberWithBool:isSelected];
//	[self.selectedIndexes setObject:selectedIndex forKey:indexPath];
//    
//	// This is where magic happens...
//	[self.tableView beginUpdates];
//	[self.tableView endUpdates];

}

//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    return indexPath;
//    //return nil;
//}

//////calculate cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Message *message = self.messages[indexPath.row];
    
//    if ([self cellIsSelected:indexPath]) {
//        //If our cell is selected, return height with translation
//        NSLog(@"cell is selected?");
//        return 800;
//    }
    
    CGFloat height = 0;

    // Cell isn't selected so return single height
    //load cell depending on the user
    if ([message.sender.username isEqualToString:self.currentUser.username]) {
        //calculate height based on cell
        if (!self.msgCell){
            self.msgCell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
        }
        
        //configure the cell
        self.msgCell.messageLabel.text = message.messageTranslated;
        //layout the cell
        [self.msgCell layoutIfNeeded];
        height = [self.msgCell.contentView systemLayoutSizeFittingSize:(UILayoutFittingCompressedSize)].height;
        //get the height
        NSLog(@"MESSAGE: %@", message.messageTranslated);
        NSLog(@"height: %1.f %d", height, indexPath.row);

    } else {
        //calculate height based on cell
        if (!self.msgFriendCell){
            self.msgFriendCell = [tableView dequeueReusableCellWithIdentifier:@"MessageFriendCell"];
        }
        
        //configure the cell
        self.msgFriendCell.messageLabel.text = message.messageTranslated;
        self.msgFriendCell.translationLabel.text = message.messageOriginal;
        self.msgFriendCell.translationView.hidden = YES;
        //layout the cell
        [self.msgFriendCell layoutIfNeeded];
        
        height = [self.msgFriendCell.contentView systemLayoutSizeFittingSize:(UILayoutFittingCompressedSize)].height;
        //get the height
        NSLog(@"height: %1.f %d", height, indexPath.row);
    }
//
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

//trigger heightForRowAtIndexPath
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(void)dismissKeyboard {
    [self.messageField resignFirstResponder];
}


#pragma Mark
#pragma Auto Resize Cells

@end

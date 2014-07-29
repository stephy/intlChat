//
//  ChatsViewController.m
//  IntlChat
//
//  Created by Stephani Alves on 7/17/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//

#import "ChatsViewController.h"
#import "ChatCell.h"

#import "ChatViewController.h"


//@interface ChatsViewController ()
//
//@end

@implementation ChatsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if (self.forUser == nil) {
            self.forUser = [User currentUser];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //load personalized cell
    //registration process
    [self.tableView registerNib:[UINib nibWithNibName:@"ChatCell" bundle:nil] forCellReuseIdentifier:@"ChatCell"];
    //set row height
    self.tableView.rowHeight = 80;
    // Load chats
    User *me = [User currentUser];
    [me chatsWithCompletion:^(NSArray *chats) {
        self.chats = chats;
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return the number of rows you want in this table view
    return [self.chats count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCell"];
    self.tableView.backgroundColor =[UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    
    Chat *chat = [self.chats objectAtIndex:indexPath.row];
    User *partner = [chat chatPartner];
    Language *lang = [Language instance];
    
    cell.friendLabel.text = partner.fullName;
    cell.languageLabel.text = [lang printableLanguage:partner.language];
    // wire in profile images here
    //UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    //imgView.image = [UIImage imageNamed:@"769-male.png"];

    //[cell.userIcon setImageWithURL:chat[@"image_url"] placeholderImage:placeholder];
    //cell.userIcon = imgView;
    
    return cell;
}

//on row click open detailed view
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Chat *chat = [self.chats objectAtIndex:indexPath.row];
    User *partner = [chat chatPartner];

    ChatViewController *cvc = [[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:[NSBundle mainBundle]];
    cvc.currentChat = chat;
    [cvc setTitle:partner.username];
    [self.navigationController pushViewController:cvc animated:YES];
}


@end

//
//  ChatsViewController.m
//  IntlChat
//
//  Created by Stephani Alves on 7/17/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//

#import "ChatsViewController.h"
#import "ChatCell.h"

@interface ChatsViewController ()
@property (nonatomic, strong) NSArray *chats;

@end

@implementation ChatsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.chats = @[ @{ @"buddy"     : @"Stephani Alves",
                        @"language" : @"Portuguese" },
                        @{ @"buddy"     : @"Daniel Avalone",
                           @"language" : @"Portuguese" },
                        @{ @"buddy"     : @"Bruce Wayne",
                           @"language" : @"English" },
                       ];
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
    
    NSDictionary *chat = [self.chats objectAtIndex:indexPath.row];
    cell.friendLabel.text = chat[@"buddy"];
    cell.languageLabel.text = chat[@"language"];
    return cell;
}

//on row click open detailed view
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


@end

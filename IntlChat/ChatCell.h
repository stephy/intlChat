//
//  ChatCell.h
//  IntlChat
//
//  Created by Stephani Alves on 7/19/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ChatCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *friendLabel;
@property (strong, nonatomic) IBOutlet UILabel *languageLabel;
@property (strong, nonatomic) IBOutlet UIImageView *userIcon;
@end

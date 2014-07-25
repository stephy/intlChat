//
//  Chat.h
//  IntlChat
//
//  Created by Osvaldo Sabina on 7/22/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface Chat : PFObject<PFSubclassing>

@property (retain) User *user;
@property (retain) NSString *chatName;

+ (NSString *)parseClassName;

@end

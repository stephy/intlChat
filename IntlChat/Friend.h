//
//  Friend.h
//  IntlChat
//
//  Created by Osvaldo Sabina on 7/22/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface Friend : PFObject<PFSubclassing>

@property (retain) User *friender;
@property (retain) User *friendee;
@property (retain) NSDate *friendshipRequested;
@property (retain) NSDate *friendshipStart;
@property BOOL accepted;

+ (Friend *) instance;

+ (NSString *) parseClassName;

@end

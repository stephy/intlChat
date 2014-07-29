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

// Data structure here would be different if we could have N people in
// a chat, but we will assume there are only two.
@property (retain) User *chatter; // who initiated
@property (retain) User *chattee; // other member
@property (retain) NSString *chatName;

+ (NSString *)parseClassName;

+ (void)chatBetween:(User *)chatter andUser:(User *)chattee withCompletion:(void (^)(Chat *chat))callback;
@end

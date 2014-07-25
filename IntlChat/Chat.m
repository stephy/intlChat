//
//  Chat.m
//  IntlChat
//
//  Created by Osvaldo Sabina on 7/22/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//

#import "Chat.h"
#import <Parse/PFObject+Subclass.h>

@implementation Chat

@dynamic user;
@dynamic chatName;


+ (NSString *)parseClassName {
    return @"Chat";
}
@end

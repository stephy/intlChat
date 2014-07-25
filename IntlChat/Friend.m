//
//  Friend.m
//  IntlChat
//
//  Created by Osvaldo Sabina on 7/22/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//

#import "Friend.h"
#import <Parse/PFObject+Subclass.h>

@implementation Friend

@dynamic friender;
@dynamic friendee;
@dynamic friendshipRequested;
@dynamic friendshipStart;
@dynamic accepted;

+ (NSString *)parseClassName {
    return @"Friend";
}
@end

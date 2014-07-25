//
//  Message.m
//  IntlChat
//
//  Created by Osvaldo Sabina on 7/22/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//

#import "Message.h"
#import <Parse/PFObject+Subclass.h>


@implementation Message

@dynamic chat;
@dynamic sender;
@dynamic messageSent;
@dynamic messageOriginal;
@dynamic messageTranslated;
@dynamic messageOriginalLanguage;
@dynamic messageTranslatedLanguage;

+ (NSString *)parseClassName {
    return @"Message";
}
@end

//
//  Message.h
//  IntlChat
//
//  Created by Osvaldo Sabina on 7/22/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Chat.h"

@interface Message : PFObject<PFSubclassing>

@property (retain) User *sender;
@property (retain) Chat *chat;
@property (retain) NSDate *messageSent;
@property (retain) NSString *messageOriginal;
@property (retain) NSString *messageTranslated;
@property (retain) NSString *messageOriginalLanguage;
@property (retain) NSString *messageTranslatedLanguage;

+ (NSString *)parseClassName;

@end

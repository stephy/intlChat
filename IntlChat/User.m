//
//  User.m
//  IntlChat
//
//  Created by Osvaldo Sabina on 7/20/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//


#import <Parse/PFObject+Subclass.h>
#import "User.h"

@implementation User

//@dynamic userid;
//@dynamic password;
//@dynamic emailAddr;
@dynamic language;
@dynamic fullName;

//+ (NSString *)parseClassName {
//    return @"User";
//}

+ (User *)user {
    return (User *) [super user];
}

+ (void) signupNewUser: (NSString *)username withPassword: (NSString *)password
            withEmail: (NSString *)email withLanguage: (NSString *)lang
           withFullName: (NSString *) name {
    
    User *myuser = (User *) [User user];
    myuser.username = username;
    myuser.password = password;
    myuser.email = email;
    myuser.language = lang;
    myuser.fullName = name;

    [myuser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
        } else {
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"Error signing up: %@", errorString);
        }
    }];
}


@end

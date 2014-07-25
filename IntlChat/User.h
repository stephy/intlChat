//
//  User.h
//  IntlChat
//
//  Created by Osvaldo Sabina on 7/20/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface User : PFUser <PFSubclassing>

@property (retain) NSString *fullName;
@property (retain) NSString *language;
@property (retain) NSString *profileImageURL;
// Rest are covered by PFUser
//@property (retain) NSString *emailAddr;
//@property (retain) NSString *userid;
//@property (retain) NSString *password;
// probably want to add things like
// avatarURL
// otherLanguagesSpoken

//+ (NSString *)parseClassName;
+ (void) signupNewUser: (NSString *)username withPassword: (NSString *)password
             withEmail: (NSString *)email withLanguage: (NSString *)lang
          withFullName: (NSString *) name;

-(NSString *)firstName;
-(NSString *)lastName;

@end

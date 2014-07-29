//
//  User.h
//  IntlChat
//
//  Created by Osvaldo Sabina on 7/20/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@protocol FriendsDelegate <NSObject>
@required
- (void) friendsHandler: (NSArray *)friends;
@end


@interface User : PFUser <PFSubclassing>

@property (retain) NSString *fullName;
@property (retain) NSString *language;
@property (retain) NSString *profileImageURL;
// Rest are covered by PFUser
//@property (retain) NSString *emailAddr;
//@property (retain) NSString *userid;
//@property (retain) NSString *password;
// probably want to add things like
// otherLanguagesSpoken

//+ (NSString *)parseClassName;
+ (void) signupNewUser: (NSString *)username withPassword: (NSString *)password
             withEmail: (NSString *)email withLanguage: (NSString *)lang
          withFullName: (NSString *) name;

// User specific methods
-(NSString *)firstName;
-(NSString *)lastName;

-(void)friendsWithCompletion:(void(^)(NSArray *friends))callback;
-(void)allUsersWithCompletion:(void(^)(NSArray *users))callback;

-(void)chatsWithCompletion:(void(^)(NSArray *chats))callback;


@end

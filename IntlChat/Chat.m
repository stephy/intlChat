//
//  Chat.m
//  IntlChat
//
//  Created by Osvaldo Sabina on 7/22/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//

#import "Chat.h"
#import <Parse/PFObject+Subclass.h>

@interface Chat()

+ (void)existingChatBetween: (User *) user1 andUser: (User *) user2 withCompletion:(void(^)(Chat *chat))callback;

@end

@implementation Chat

@dynamic chatter;
@dynamic chattee;
@dynamic chatName;


+ (NSString *)parseClassName {
    return @"Chat";
}

+ (void)existingChatBetween:(User *)user1 andUser:(User *)user2 withCompletion:(void (^)(Chat *chat))callback
{
    PFQuery *wasChatter = [PFQuery queryWithClassName:@"Chat"];
    [wasChatter whereKey:@"chatter" equalTo:user1];
    [wasChatter whereKey:@"chattee" equalTo:user2];

    PFQuery *wasChattee = [PFQuery queryWithClassName:@"Chat"];
    [wasChatter whereKey:@"chattee" equalTo:user1];
    [wasChatter whereKey:@"chatter" equalTo:user2];
    
    PFQuery *query = [PFQuery orQueryWithSubqueries:@[wasChatter,wasChattee]];
    [query includeKey:@"chatter"];
    [query includeKey:@"chattee"];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!error) {
            if (object != nil) {
                NSLog(@"Successfully retrieved chat");
                callback((Chat *)object);
            } else {
                NSLog(@"No existing chat");
                callback(nil);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

+ (void)chatBetween:(User *)chatter andUser:(User *)chattee withCompletion:(void (^)(Chat *chat))callback
{
    __block Chat *thisChat = nil;

    [Chat existingChatBetween: chatter andUser: chattee
               withCompletion:^(Chat *chat) {
                   thisChat = chat;
               }];

    if (thisChat == nil) {
        // create new one
        NSLog(@"Creating new chat between %@ and %@", chatter.username, chattee.username);
        thisChat = [Chat object];
        thisChat.chattee = chattee;
        thisChat.chatter = chatter;
        thisChat.chatName = @"(unused for now)";
        [thisChat saveInBackground];
    } else {
        NSLog(@"Chat already exists");
    }
    callback(thisChat);
}

- (User *)chatPartner {
    // Given a Chat, return the user that's not me
    return (self.chattee == [User currentUser]) ? self.chatter : self.chattee;
}

@end

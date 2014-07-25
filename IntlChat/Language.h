//
//  Language.h
//  IntlChat
//
//  Created by Osvaldo Sabina on 7/24/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Language : NSObject

@property (strong, nonatomic) NSDictionary *languages;

+(Language *) instance;

-(NSString *) printableLanguage: (NSString *)forCode;

@end

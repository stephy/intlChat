//
//  Language.m
//  IntlChat
//
//  Created by Osvaldo Sabina on 7/24/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//

#import "Language.h"

@interface Language ()


@end

@implementation Language

static Language *instance;

+(Language *) instance {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[Language alloc] init];
    });
    
    return instance;
}

-(id) init {
    self = [super init];
    self.languages = @{ @"English" : @"en",
                     @"Portuguese" : @"pt",
                     @"Spanish" : @"es"
                     };
    return self;
}

- (NSString *)printableLanguage: (NSString *)forCode {
    NSArray *results = [self.languages allKeysForObject: forCode];
    if ([results count] == 1) {
        return results[0];
    } else {
        return @"(unknown)";
    }
}


@end

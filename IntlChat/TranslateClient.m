//
//  TranslateClient.m
//  IntlChat
//
//  Created by Osvaldo Sabina on 7/29/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//

#import "TranslateClient.h"

#import <AFNetworking/AFHTTPRequestOperationManager.h>

#define TRANSLATE_BASE_URL @"https://www.googleapis.com"

@interface TranslateClient ()

@property (strong,nonatomic) NSString *APIKey;

@end

@implementation TranslateClient

static TranslateClient *instance;

+(TranslateClient *) instance {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[TranslateClient alloc] init];
    });
    
    return instance;
}

- (AFHTTPRequestOperation *)getTranslationForString: (NSString *)input fromLang: (NSString *)from toLang: (NSString *)to
                                              withSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {

    //Don't translate unnecessarily
    if ([from isEqualToString:to]) {
        success((AFHTTPRequestOperation *)nil, input);
        return (AFHTTPRequestOperation *)nil;
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    //Example URL: https://www.googleapis.com/language/translate/v2?key=INSERT-YOUR-KEY&q=hello%20world&source=en&target=de
    NSString *inputEsc = [input stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // Should be escaping from and to if we didn't totally control what they might be...
    NSDictionary *params = @{ @"source" : from,
                              @"target" : to,
                              @"key" : self.APIKey,
                              @"q" : inputEsc };

    NSString *url = [NSString stringWithFormat:@"%@/language/translate/v2", TRANSLATE_BASE_URL];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSLog(@"Making call with bundle identifier '%@'", [[NSBundle mainBundle] bundleIdentifier]);
    return [manager GET:url parameters: params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        // This is where we'd manipulate the object to return whatever we wanted, probably a string
        // and then return it instead of the object itself.
        success(self, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        failure(self, error);
    }];
    
}

-(id) init {
    self = [super init];
    self.APIKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"GoogleAPIKey"];
    return self;
}

@end

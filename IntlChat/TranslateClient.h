//
//  TranslateClient.h
//  IntlChat
//
//  Created by Osvaldo Sabina on 7/29/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//

#import <AFNetworking/AFHTTPRequestOperation.h>

@interface TranslateClient : AFHTTPRequestOperation

+ (TranslateClient *)instance;

- (AFHTTPRequestOperation *)getTranslationForString: (NSString *)input fromLang: (NSString *)from toLang: (NSString *)to
                                        withSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end

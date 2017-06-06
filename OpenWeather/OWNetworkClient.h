//
//  OWNetworkClient.h
//  OpenWeather
//
//  Created by Surendran Thiyagarajan on 6/6/17.
//  Copyright © 2017 suren. All rights reserved.
//


#import <Foundation/Foundation.h>

typedef void(^networkClientcompletionBlock)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error);

@interface OWNetworkClient : NSObject

- (void)get:( NSString * _Nonnull )path completionBlock:(_Nonnull networkClientcompletionBlock)callBackBlock;

@end

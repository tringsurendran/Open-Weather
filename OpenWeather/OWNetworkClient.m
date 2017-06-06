//
//  OWNetworkClient.m
//  OpenWeather
//
//  Created by Surendran Thiyagarajan on 6/6/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import "OWNetworkClient.h"

@interface  OWNetworkClient ()

@property (nonatomic) NSURLSession *urlSession;

@end

@implementation OWNetworkClient

- (instancetype)init {
    self = [super init];
    if (self) {
        self.urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return self;
}

- (void)get:(NSString *)path completionBlock:(networkClientcompletionBlock)callBackBlock {
    NSString *percentEncodedString = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:percentEncodedString]];
    request.HTTPMethod = @"GET";
    [self sendRequest:request callBack:callBackBlock];
}

- (void)sendRequest:(NSMutableURLRequest *)request callBack:(networkClientcompletionBlock)callBackBlock {
    [[self.urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        callBackBlock(data,response,error);
    }] resume];
}


@end

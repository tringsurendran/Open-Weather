//
//  OWNetworkManager.m
//  OpenWeather
//
//  Created by Surendran Thiyagarajan on 6/6/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import "OWNetworkManager.h"

@interface OWNetworkManager ()

@property (nonatomic) OWNetworkClient *client;

@end

@implementation OWNetworkManager

+ (instancetype)sharedInstance {
    static OWNetworkManager *networkManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkManager = [[OWNetworkManager alloc] init];
    });
    return networkManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.client = [[OWNetworkClient alloc] init];
    }
    return self;
}

- (void)getWeatheInfoForCity:(NSString *)city  completionHandler:(networkClientcompletionBlock)callBackBlock {
    // TODO : Handle temp metrics dynamically, °C, °F
    NSString *country = @"US";
    NSString *urlString = [NSString stringWithFormat:WEATHER_API, city, country, WEATHER_API_KEY];
    [self.client get:urlString completionBlock:callBackBlock];
}

@end

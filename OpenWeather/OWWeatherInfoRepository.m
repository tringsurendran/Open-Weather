//
//  OWWeatherInfoRepository.m
//  OpenWeather
//
//  Created by Surendran Thiyagarajan on 6/6/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import "OWWeatherInfoRepository.h"
#import "OWNetworkManager.h"
#import "WeatherInfoObject.h"

@interface OWWeatherInfoRepository ()

@property (nonatomic, readwrite) NSString *location;

@end

@implementation OWWeatherInfoRepository

- (void)getWeatheInfoForCity:(NSString *)location completionHandler:(void (^)(NSString *, WeatherInfoObject *, NSError *))callbackBlock {
    self.location = location;
    __weak OWWeatherInfoRepository *weakSelf = self;
    [[OWNetworkManager sharedInstance] getWeatheInfoForCity:location completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (weakSelf) {
            WeatherInfoObject *info;
            if (!error) {
                id result =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if ([result isKindOfClass:[NSDictionary class]]) {
                    info = [[WeatherInfoObject alloc] initWithDict:result];
                }
                if (info == nil) {
                    error = [NSError errorWithDomain:@"Weathe API" code:10001 userInfo:@{@"Message" : @"City not found"}];
                }
            }
            callbackBlock(weakSelf.location, info, error);
        }
    }];
    
}

@end

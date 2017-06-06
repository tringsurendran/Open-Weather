//
//  OWWeatherInfoRepository.h
//  OpenWeather
//
//  Created by Surendran Thiyagarajan on 6/6/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherInfoObject.h"

@interface OWWeatherInfoRepository : NSObject

@property (nonatomic, readonly) NSString *location;

- (void)getWeatheInfoForCity:(NSString *)city completionHandler:(void (^)(NSString *, WeatherInfoObject *, NSError *))callbackBlock;

@end

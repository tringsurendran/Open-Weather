//
//  WeatherInfoObject.h
//  OpenWeather
//
//  Created by Surendran Thiyagarajan on 6/6/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherInfoObject : NSObject

@property (nonatomic, readonly) NSString *locationName;
@property (nonatomic, readonly) NSNumber *maxTemp;
@property (nonatomic, readonly) NSNumber *minTemp;
@property (nonatomic, readonly) NSNumber *currentTemp;
@property (nonatomic, readonly) NSString *iconName;
@property (nonatomic, readonly) NSString *weatherDescription;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

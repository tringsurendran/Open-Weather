//
//  WeatherInfoObject.m
//  OpenWeather
//
//  Created by Surendran Thiyagarajan on 6/6/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import "WeatherInfoObject.h"

@interface WeatherInfoObject ()

@property (nonatomic, readwrite) NSString *locationName;
@property (nonatomic, readwrite) NSNumber *maxTemp;
@property (nonatomic, readwrite) NSNumber *minTemp;
@property (nonatomic, readwrite) NSNumber *currentTemp;
@property (nonatomic, readwrite) NSString *iconName;
@property (nonatomic, readwrite) NSString *weatherDescription;

@end

@implementation WeatherInfoObject

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        if (dict[@"name"] == nil) {
            return nil;
        }
        self.locationName = dict[@"name"];
        NSDictionary *mainDict = dict[@"main"];
        self.maxTemp = mainDict[@"temp_max"];
        self.minTemp = mainDict[@"temp_min"];
        self.currentTemp = mainDict[@"temp"];
        NSDictionary *weatherDict = [dict[@"weather"] lastObject];
        self.iconName = weatherDict[@"icon"];
        self.weatherDescription = weatherDict[@"description"];
    }
    return self;
}


@end

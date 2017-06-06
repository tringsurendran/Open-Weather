//
//  OWNetworkManager.h
//  OpenWeather
//
//  Created by Surendran Thiyagarajan on 6/6/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OWNetworkClient.h"

#define WEATHER_API_KEY @"a377d137c200ceae9fde045a23249fd5"
#define WEATHER_API @"http://api.openweathermap.org/data/2.5/weather?q=%@,%@&APPID=%@&units=Imperial"

@interface OWNetworkManager : NSObject

+ (instancetype)sharedInstance;

- (void)getWeatheInfoForCity:(NSString *)city  completionHandler:(networkClientcompletionBlock)callBackBlock;

@end

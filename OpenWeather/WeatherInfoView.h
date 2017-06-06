//
//  WeatherInfoView.h
//  OpenWeather
//
//  Created by Surendran Thiyagarajan on 6/6/17.
//  Copyright © 2017 suren. All rights reserved.
//

// WeatherInfoView displays weather details

#import <UIKit/UIKit.h>
#import "WeatherInfoObject.h"

@interface WeatherInfoView : UIView

@property (nonatomic) WeatherInfoObject *weatherInfoObject;

@end

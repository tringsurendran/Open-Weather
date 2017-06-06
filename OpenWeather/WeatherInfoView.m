//
//  WeatherInfoView.m
//  OpenWeather
//
//  Created by Surendran Thiyagarajan on 6/6/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import "WeatherInfoView.h"
#import "WeatherInfoObject.h"

@interface WeatherInfoView ()

@property (nonatomic) UILabel *locationLabel;
@property (nonatomic) UILabel *minTempLabel;
@property (nonatomic) UILabel *maxTempLabel;
@property (nonatomic) UILabel *currentTempLabel;
@property (nonatomic) UILabel *weatherDescriptionLabel;
@property (nonatomic) UIImageView *iconView;

@end

@implementation WeatherInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:27/255.0 green:166/255.0 blue:223/255.0 alpha:1.0];
        
        self.locationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.locationLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.locationLabel.textColor = [UIColor whiteColor];
        self.locationLabel.textAlignment = NSTextAlignmentCenter;
        self.locationLabel.font = [UIFont boldSystemFontOfSize:16];
        [self addSubview:self.locationLabel];
        
        self.minTempLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.minTempLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.minTempLabel.textColor = [UIColor whiteColor];
        self.minTempLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.minTempLabel];
        
        self.maxTempLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.maxTempLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.maxTempLabel.textColor = [UIColor whiteColor];
        self.maxTempLabel.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:self.maxTempLabel];
        
        self.currentTempLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.currentTempLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.currentTempLabel.textColor = [UIColor whiteColor];
        self.currentTempLabel.font = [UIFont boldSystemFontOfSize:24];
        self.currentTempLabel.textAlignment = NSTextAlignmentCenter;
        self.currentTempLabel.numberOfLines = 0;
        [self addSubview:self.currentTempLabel];
        
        self.weatherDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.weatherDescriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.weatherDescriptionLabel.textColor = [UIColor whiteColor];
        self.weatherDescriptionLabel.font = [UIFont systemFontOfSize:12];
        self.weatherDescriptionLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.weatherDescriptionLabel];
        
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.iconView.translatesAutoresizingMaskIntoConstraints = NO;
        self.iconView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.iconView];
        
        NSDictionary *views = @{@"locationLabel" : self.locationLabel, @"weatherDescriptionLabel" : self.weatherDescriptionLabel, @"currentTempLabel" : self.currentTempLabel, @"minTempLabel" : self.minTempLabel, @"maxTempLabel" : self.maxTempLabel, @"iconView" : self.iconView};
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[locationLabel]-10-|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[weatherDescriptionLabel]-10-|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[currentTempLabel]-10-|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[minTempLabel]" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[maxTempLabel]-10-|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[iconView(40)]" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[locationLabel(<=18)]-5-[weatherDescriptionLabel(<=15)]-10-[iconView(40)]-5-[currentTempLabel(<=30)]" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[maxTempLabel]-10-|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[minTempLabel]-10-|" options:0 metrics:nil views:views]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.iconView
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.f constant:0.f]];
    }
    return self;
}

- (void)setWeatherInfoObject:(WeatherInfoObject *)weatherInfoObject {
    // TODO : Handle temp metrics dynamically, °C, °F
    _weatherInfoObject = weatherInfoObject;
    if (weatherInfoObject && weatherInfoObject.locationName != nil) {
        self.locationLabel.text = weatherInfoObject.locationName;
        self.weatherDescriptionLabel.text = weatherInfoObject.weatherDescription != nil ? [weatherInfoObject.weatherDescription capitalizedString] : @"";
        self.currentTempLabel.text = weatherInfoObject.currentTemp != nil ? [NSString stringWithFormat:@"%d °F",[weatherInfoObject.currentTemp intValue]] : @"-/-";
        self.minTempLabel.text = weatherInfoObject.minTemp != nil ? [NSString stringWithFormat:@"Min Temp: %d °F",[weatherInfoObject.minTemp intValue]] : @"-/-";
        self.maxTempLabel.text = weatherInfoObject.maxTemp != nil ? [NSString stringWithFormat:@"Max Temp: %d °F",[weatherInfoObject.maxTemp intValue]] : @"-/-";
        [self updateImage];
    } else {
        self.currentTempLabel.text = @"Are you sure the location you entered is in earth :)";
        self.weatherDescriptionLabel.text = @"";
        self.minTempLabel.text = @"";
        self.maxTempLabel.text = @"";
        self.iconView.image = nil;
    }
}

- (void)updateImage {
    // TODO : have image downloader class for these operations
    __weak WeatherInfoView *weakSelf = self;
    self.iconView.image = nil;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *imageUrlString = [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", self.weatherInfoObject.iconName];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:[NSURL URLWithString:imageUrlString]
                                                completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                    if(location != nil) {
                                                        dispatch_sync(dispatch_get_main_queue(), ^{
                                                            UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:location]];
                                                            if([image isKindOfClass:[UIImage class]]) {
                                                                [weakSelf.iconView setImage:image];
                                                            }
                                                        });
                                                    }
                                                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                                }];
    [task resume];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end


//
//  WeatherViewController.m
//  OpenWeather
//
//  Created by Surendran Thiyagarajan on 6/6/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import "WeatherViewController.h"
#import "OWWeatherInfoRepository.h"
#import "WeatherInfoObject.h"
#import "WeatherInfoView.h"

NSString *KRecentlySearchedCity = @"Last Searched Location";

@interface WeatherViewController () <UISearchBarDelegate>

@property (nonatomic) UISearchBar *searchBar;
@property (nonatomic) OWWeatherInfoRepository *repository;
@property (nonatomic) NSString *searchText;
@property (nonatomic) WeatherInfoView *weatherInfoView;
@property (nonatomic) UIActivityIndicatorView *activityIndicator;

@end

@implementation WeatherViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // load weatherInfoView and searchbar

    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    self.searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.searchBar];
    self.searchBar.layer.cornerRadius = 5;
    self.searchBar.clipsToBounds = YES;
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"Enter a US city";
    
    self.weatherInfoView = [[WeatherInfoView alloc] initWithFrame:CGRectZero];
    self.weatherInfoView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.weatherInfoView];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self.weatherInfoView addSubview:self.activityIndicator];
    
    
    // Autolayouts for serachbar and weatherInfoView
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[searchBar]-15-|" options:0 metrics:nil views:@{@"searchBar" : self.searchBar}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[weatherInfoView]-15-|" options:0 metrics:nil views:@{@"weatherInfoView" : self.weatherInfoView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-35-[searchBar(45)]-15-[weatherInfoView(250)]" options:0 metrics:nil views:@{@"searchBar" : self.searchBar, @"weatherInfoView" : self.weatherInfoView}]];
    
    NSString *recentSearch = [[NSUserDefaults standardUserDefaults] objectForKey:KRecentlySearchedCity];
    if (recentSearch) { // prefill recently searched city
        self.searchBar.text = recentSearch;
        [self.activityIndicator startAnimating];
        [self getWeatherInfo];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // set spinner center point
    self.activityIndicator.center = CGPointMake(CGRectGetWidth(self.weatherInfoView.frame) / 2, CGRectGetHeight(self.weatherInfoView.frame) / 2);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getWeatherInfo {
    // get weather info details if there is a search text
    if (self.searchText.length > 0) {
        self.repository = [[OWWeatherInfoRepository alloc] init];
        __weak WeatherViewController *weakSelf = self;
        [self.repository getWeatheInfoForCity:self.searchBar.text completionHandler:^(NSString *location, WeatherInfoObject * weatherInfoObject, NSError * error) {
            if (weakSelf) {
                NSString *searchText = weakSelf.searchText;
                if ([searchText isEqualToString:location]) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self.activityIndicator stopAnimating];
                        if (weatherInfoObject == nil || error != nil) {
                            // TODO : show error message to user
                        } else {
                            weakSelf.weatherInfoView.weatherInfoObject = weatherInfoObject;
                            [[NSUserDefaults standardUserDefaults] setObject:searchText forKey:KRecentlySearchedCity];
                        }
                    });
                }
            }
        }];
    }
}

- (NSString *)searchText {
    // returns searchbar text
    return [self.searchBar.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    // getWeatherInfo on search bar search button action
    [searchBar resignFirstResponder];
    [self.activityIndicator startAnimating];
    [self getWeatherInfo];
}


@end

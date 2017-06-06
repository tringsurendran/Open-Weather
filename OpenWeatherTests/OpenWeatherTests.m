//
//  OpenWeatherTests.m
//  OpenWeatherTests
//
//  Created by Surendran Thiyagarajan on 6/6/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WeatherInfoObject.h"
#import "OWNetworkManager.h"

@interface OpenWeatherTests : XCTestCase

@end

@implementation OpenWeatherTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testCreateWeatherInfoObject {
    // test case to confirm the WeatherInfoObject creation and reading structure from expected json response
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"WeatherResponse" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    BOOL success = YES;
    if ([result isKindOfClass:[NSDictionary class]]) {
        WeatherInfoObject *info = [[WeatherInfoObject alloc] initWithDict:result];
        if (success && ![info.locationName isEqualToString:@"Concord"]) {
            success = NO;
        }
        if (success && [info.maxTemp intValue] != 87) {
            success = NO;
        }
        if (success && [info.minTemp intValue] != 57) {
            success = NO;
        }
        if (success && [info.currentTemp intValue] != 75) {
            success = NO;
        }
        if (success && ![info.iconName isEqualToString:@"50d"]) {
            success = NO;
        }
        if (success && ![info.weatherDescription isEqualToString:@"haze"]) {
            success = NO;
        }
    } else {
        success = NO;
    }
    XCTAssertTrue(success);
}

- (void)testNetworkTask {
    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request"];
    [[OWNetworkManager sharedInstance] getWeatheInfoForCity:@"New York" completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(data);
            if (!error && data) {
                id result =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                XCTAssertTrue([result isKindOfClass:[NSDictionary class]]);
            }
        [expectation fulfill];
        }
    ];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}



- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

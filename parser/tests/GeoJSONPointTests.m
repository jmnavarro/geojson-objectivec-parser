//
//  GeoJSONPointTests.h
//  geojson-parser
//
//  Created by JM on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GeoJSONPointTests.h"
#import "GeoJSONPoint.h"

@implementation GeoJSONPointTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testShouldWorkIfCoordinatesAreOK
{
    NSArray *coord = [NSArray arrayWithObjects:[NSNumber numberWithDouble:102.0], [NSNumber numberWithDouble:0.5], nil];
    
    GeoJSONPoint *point = [[GeoJSONPoint alloc] initWithGeoJSONCoordinates:coord];

    STAssertNotNil(point, @"Point can't be nil");
    STAssertEqualsWithAccuracy(102.0, point.longitude, 0.001, @"Longitude is not valid");
    STAssertEqualsWithAccuracy(0.5, point.latitude, 0.001, @"Longitude is not valid");
    STAssertEqualsWithAccuracy(-1.0, point.altitude, 0.001, @"Altitude is not valid");
}


- (void)testShouldWorkIfWithAltitude
{
    NSArray *coord = [NSArray arrayWithObjects:[NSNumber numberWithDouble:102.0], [NSNumber numberWithDouble:0.5], [NSNumber numberWithDouble:1.1], nil];
    
    GeoJSONPoint *point = [[GeoJSONPoint alloc] initWithGeoJSONCoordinates:coord];
    
    STAssertNotNil(point, @"Point can't be nil");
    STAssertEqualsWithAccuracy(102.0, point.longitude, 0.001, @"Longitude is not valid");
    STAssertEqualsWithAccuracy(0.5, point.latitude, 0.001, @"Longitude is not valid");
    STAssertEqualsWithAccuracy(1.1, point.altitude, 0.001, @"Altitude is not valid");
}


- (void)testShouldFailIfCoordinatesAreNil
{
    GeoJSONPoint *point = [[GeoJSONPoint alloc] initWithGeoJSONCoordinates:nil];
    STAssertNil(point, @"Point must be nil");
}


- (void)testShouldFailIfCoordinatesDontHaveTwoElements
{
    NSArray *coord = [NSArray arrayWithObjects:[NSNumber numberWithDouble:102.0], nil];

    GeoJSONPoint *point = [[GeoJSONPoint alloc] initWithGeoJSONCoordinates:coord];
    STAssertNil(point, @"Point must be nil");
    
    coord = [NSArray array];
    STAssertNil(point, @"Point must be nil");
}


@end

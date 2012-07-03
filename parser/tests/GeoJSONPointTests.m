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
    [_fixture release];
    
    [super tearDown];
}

- (void)testShouldWorkIfCoordinatesAreOK
{
    NSArray *coord = [NSArray arrayWithObjects:[NSNumber numberWithDouble:102.0], [NSNumber numberWithDouble:0.5], nil];
    
    _fixture = [[GeoJSONPoint alloc] initWithGeoJSONCoordinates:coord];

    STAssertNotNil(_fixture, @"Point can't be nil");
    STAssertEqualsWithAccuracy(102.0, _fixture.longitude, 0.001, @"Longitude is not valid");
    STAssertEqualsWithAccuracy(0.5, _fixture.latitude, 0.001, @"Longitude is not valid");
    STAssertEqualsWithAccuracy(-1.0, _fixture.altitude, 0.001, @"Altitude is not valid");
    
}


- (void)testShouldWorkIfWithAltitude
{
    NSArray *coord = [NSArray arrayWithObjects:[NSNumber numberWithDouble:102.0], [NSNumber numberWithDouble:0.5], [NSNumber numberWithDouble:1.1], nil];
    
    _fixture = [[GeoJSONPoint alloc] initWithGeoJSONCoordinates:coord];
    
    STAssertNotNil(_fixture, @"Point can't be nil");
    STAssertEqualsWithAccuracy(102.0, _fixture.longitude, 0.001, @"Longitude is not valid");
    STAssertEqualsWithAccuracy(0.5, _fixture.latitude, 0.001, @"Longitude is not valid");
    STAssertEqualsWithAccuracy(1.1, _fixture.altitude, 0.001, @"Altitude is not valid");
}


- (void)testShouldFailIfCoordinatesAreNil
{
    _fixture = [[GeoJSONPoint alloc] initWithGeoJSONCoordinates:nil];
    STAssertNil(_fixture, @"Point must be nil");
}


- (void)testShouldFailIfCoordinatesDontHaveTwoElements
{
    NSArray *coord = [NSArray arrayWithObjects:[NSNumber numberWithDouble:102.0], nil];

    _fixture = [[GeoJSONPoint alloc] initWithGeoJSONCoordinates:coord];
    STAssertNil(_fixture, @"Point must be nil");
    
    _fixture = [[GeoJSONPoint alloc] initWithGeoJSONCoordinates:[NSArray array]];
    STAssertNil(_fixture, @"Point must be nil");
}


@end

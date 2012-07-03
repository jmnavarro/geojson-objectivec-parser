//
//  GeoJSONMultiPointTests.m
//  geojson-parser
//
//  Created by JM on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GeoJSONMultiPointTests.h"
#import "GeoJSONMultiPoint.h"
#import "GeoJSONPoint.h"

@implementation GeoJSONMultiPointTests

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
    NSArray *p1 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:102.0], [NSNumber numberWithDouble:0.5], nil];
    NSArray *p2 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:2.0], [NSNumber numberWithDouble:0.25], nil];
    NSArray *coords = [NSArray arrayWithObjects:p1, p2, nil];
    
    _fixture = [[GeoJSONMultiPoint alloc] initWithGeoJSONCoordinates:coords];

    STAssertNotNil(_fixture, @"MultiPoint can't be nil");
    STAssertEquals(2, _fixture.count, @"Count is not valid");
    
    GeoJSONPoint *p1a = [_fixture pointAt:0];
    STAssertEqualsWithAccuracy(102.0, p1a.longitude, 0.001, @"Longitude is not valid");
    STAssertEqualsWithAccuracy(0.5, p1a.latitude, 0.001, @"Longitude is not valid");
    
    GeoJSONPoint *p2a = [_fixture pointAt:1];
    STAssertEqualsWithAccuracy(2.0, p2a.longitude, 0.001, @"Longitude is not valid");
    STAssertEqualsWithAccuracy(0.25, p2a.latitude, 0.001, @"Longitude is not valid");
}


- (void)testShouldWorkWithZeroPoints
{
    NSArray *coords = [NSArray array];
    
    _fixture = [[GeoJSONMultiPoint alloc] initWithGeoJSONCoordinates:coords];
    
    STAssertNotNil(_fixture, @"MultiPoint can't be nil");
    STAssertEquals(0, _fixture.count, @"Count is not valid");    
}


- (void)testShouldIgnoreInvalidPoints
{
    NSArray *p1 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:102.0], [NSNumber numberWithDouble:0.5], nil];
    NSArray *p2 = [NSArray array];
    NSArray *coords = [NSArray arrayWithObjects:p1, p2, nil];
    
    _fixture = [[GeoJSONMultiPoint alloc] initWithGeoJSONCoordinates:coords];
    
    STAssertNotNil(_fixture, @"MultiPoint can't be nil");
    STAssertEquals(1, _fixture.count, @"Count is not valid");
    
    GeoJSONPoint *p1a = [_fixture pointAt:0];
    STAssertEqualsWithAccuracy(102.0, p1a.longitude, 0.001, @"Longitude is not valid");
    STAssertEqualsWithAccuracy(0.5, p1a.latitude, 0.001, @"Longitude is not valid");
    
    STAssertNil([_fixture pointAt:1], @"Point #2 must be nil");
}


@end

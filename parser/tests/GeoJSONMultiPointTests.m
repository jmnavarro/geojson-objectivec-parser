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
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testShouldWorkIfCoordinatesAreOK
{
    NSArray *p1 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:102.0], [NSNumber numberWithDouble:0.5], nil];
    NSArray *p2 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:2.0], [NSNumber numberWithDouble:0.25], nil];
    NSArray *coords = [NSArray arrayWithObjects:p1, p2, nil];
    
    GeoJSONMultiPoint *multi = [[GeoJSONMultiPoint alloc] initWithGeoJSONCoordinates:coords];

    STAssertNotNil(multi, @"MultiPoint can't be nil");
    STAssertEquals(2, multi.count, @"Count is not valid");
    
    GeoJSONPoint *p1a = [multi pointAt:0];
    STAssertEqualsWithAccuracy(102.0, p1a.longitude, 0.001, @"Longitude is not valid");
    STAssertEqualsWithAccuracy(0.5, p1a.latitude, 0.001, @"Longitude is not valid");
    
    GeoJSONPoint *p2a = [multi pointAt:1];
    STAssertEqualsWithAccuracy(2.0, p2a.longitude, 0.001, @"Longitude is not valid");
    STAssertEqualsWithAccuracy(0.25, p2a.latitude, 0.001, @"Longitude is not valid");
}


- (void)testShouldWorkWithZeroPoints
{
    NSArray *coords = [NSArray array];
    
    GeoJSONMultiPoint *multi = [[GeoJSONMultiPoint alloc] initWithGeoJSONCoordinates:coords];
    
    STAssertNotNil(multi, @"MultiPoint can't be nil");
    STAssertEquals(0, multi.count, @"Count is not valid");    
}


- (void)testShouldIgnoreInvalidPoints
{
    NSArray *p1 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:102.0], [NSNumber numberWithDouble:0.5], nil];
    NSArray *p2 = [NSArray array];
    NSArray *coords = [NSArray arrayWithObjects:p1, p2, nil];
    
    GeoJSONMultiPoint *multi = [[GeoJSONMultiPoint alloc] initWithGeoJSONCoordinates:coords];
    
    STAssertNotNil(multi, @"MultiPoint can't be nil");
    STAssertEquals(1, multi.count, @"Count is not valid");
    
    GeoJSONPoint *p1a = [multi pointAt:0];
    STAssertEqualsWithAccuracy(102.0, p1a.longitude, 0.001, @"Longitude is not valid");
    STAssertEqualsWithAccuracy(0.5, p1a.latitude, 0.001, @"Longitude is not valid");
    
    STAssertNil([multi pointAt:1], @"Point #2 must be nil");
}




@end

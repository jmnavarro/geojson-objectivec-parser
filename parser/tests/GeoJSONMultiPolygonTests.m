//
//  GeoJSONMultiPolygonTests.m
//  geojson-parser
//
//  Created by JM on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GeoJSONMultiPolygonTests.h"
#import "GeoJSONMultiPolygon.h"
#import "GeoJSONPolygon.h"
#import "GeoJSONMultiPoint.h"
#import "GeoJSONPoint.h"

@implementation GeoJSONMultiPolygonTests

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

- (void)testShouldWorkForTwoPolygons
{
    NSArray *p1 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:0.5], [NSNumber numberWithDouble:0.5], nil];
    NSArray *p2 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:1.5], [NSNumber numberWithDouble:0.5], nil];
    NSArray *p3 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:1.5], [NSNumber numberWithDouble:1.5], nil];
    NSArray *p4 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:0.5], [NSNumber numberWithDouble:1.5], nil];
    NSArray *multiPoint1 = [NSArray arrayWithObjects:p1, p2, p3, p4, nil];
    NSArray *poly1 = [NSArray arrayWithObject:multiPoint1];

    NSArray *p5 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:1.0], [NSNumber numberWithDouble:1.0], nil];
    NSArray *p6 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:2.0], [NSNumber numberWithDouble:2.0], nil];
    NSArray *p7 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:0.0], [NSNumber numberWithDouble:2.0], nil];
    NSArray *multiPoint2 = [NSArray arrayWithObjects:p5, p6, p7, nil];
    NSArray *poly2 = [NSArray arrayWithObject:multiPoint2];
    
    NSArray *multi = [NSArray arrayWithObjects:poly1, poly2, nil];

    _fixture = [[GeoJSONMultiPolygon alloc] initWithGeoJSONCoordinates:multi];
    
    STAssertNotNil(_fixture, @"MultiPolygon can't be nil");
    STAssertEquals(2, _fixture.count, @"Count is not valid");
    
    GeoJSONPolygon *p = [_fixture polygonAt:0];
    STAssertNotNil(p, @"Polygon can't be nil");
    STAssertEquals(4, p.vertexCount, @"Vertex count is not valid");
    STAssertEquals(0, p.holeCount, @"Vertex count is not valid");

    p = [_fixture polygonAt:1];
    STAssertNotNil(p, @"Polygon can't be nil");
    STAssertEquals(3, p.vertexCount, @"Vertex count is not valid");
    STAssertEquals(0, p.holeCount, @"Vertex count is not valid");

    p = [_fixture polygonAt:2];
    STAssertNil(p, @"Polygon must be nil");
}


@end

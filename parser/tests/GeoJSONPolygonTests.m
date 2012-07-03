//
//  GeoJSONPolygonTests.m
//  geojson-parser
//
//  Created by JM on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GeoJSONPolygonTests.h"
#import "GeoJSONPolygon.h"
#import "GeoJSONMultiPoint.h"
#import "GeoJSONPoint.h"

@implementation GeoJSONPolygonTests

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

- (void)testShouldWorkForSquare
{
    NSArray *p1 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:0.5], [NSNumber numberWithDouble:0.5], nil];
    NSArray *p2 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:1.5], [NSNumber numberWithDouble:0.5], nil];
    NSArray *p3 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:1.5], [NSNumber numberWithDouble:1.5], nil];
    NSArray *p4 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:0.5], [NSNumber numberWithDouble:1.5], nil];
    NSArray *multiPoint = [NSArray arrayWithObjects:p1, p2, p3, p4, nil];
    NSArray *poly = [NSArray arrayWithObject:multiPoint];
    
    _fixture = [[GeoJSONPolygon alloc] initWithGeoJSONCoordinates:poly];
    
    STAssertNotNil(_fixture, @"Polygon can't be nil");
    STAssertEquals(4, _fixture.vertexCount, @"Vertex count is not valid");
    STAssertEquals(0, _fixture.holeCount, @"Holes count is not valid");
    
    GeoJSONPoint *v = [_fixture vertexAt:0];
    STAssertNotNil(v, @"Vertex can't be nil");
    STAssertEqualsWithAccuracy(0.5, v.longitude, 0.001, @"Longitude is not valid");
    STAssertEqualsWithAccuracy(0.5, v.latitude, 0.001, @"Latitude is not valid");

    v = [_fixture vertexAt:1];
    STAssertNotNil(v, @"Vertex can't be nil");
    STAssertEqualsWithAccuracy(1.5, v.longitude, 0.001, @"Longitude is not valid");
    STAssertEqualsWithAccuracy(0.5, v.latitude, 0.001, @"Latitude is not valid");

    v = [_fixture vertexAt:2];
    STAssertNotNil(v, @"Vertex can't be nil");
    STAssertEqualsWithAccuracy(1.5, v.longitude, 0.001, @"Longitude is not valid");
    STAssertEqualsWithAccuracy(1.5, v.latitude, 0.001, @"Latitude is not valid");
    
    v = [_fixture vertexAt:3];
    STAssertNotNil(v, @"Vertex can't be nil");
    STAssertEqualsWithAccuracy(0.5, v.longitude, 0.001, @"Longitude is not valid");
    STAssertEqualsWithAccuracy(1.5, v.latitude, 0.001, @"Latitude is not valid");

    v = [_fixture vertexAt:4];
    STAssertNil(v, @"Vertex must be nil");
}


- (void)testShouldWorkForSquareAndHole
{
    NSArray *p1 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:0.5], [NSNumber numberWithDouble:0.5], nil];
    NSArray *p2 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:1.5], [NSNumber numberWithDouble:0.5], nil];
    NSArray *p3 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:1.5], [NSNumber numberWithDouble:1.5], nil];
    NSArray *p4 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:0.5], [NSNumber numberWithDouble:1.5], nil];
    NSArray *multiPoint = [NSArray arrayWithObjects:p1, p2, p3, p4, nil];

    NSArray *h1 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:0.75], [NSNumber numberWithDouble:0.75], nil];
    NSArray *h2 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:1.25], [NSNumber numberWithDouble:0.75], nil];
    NSArray *h3 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:1.25], [NSNumber numberWithDouble:1.25], nil];
    NSArray *h4 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:0.75], [NSNumber numberWithDouble:1.25], nil];
    NSArray *multiPointH = [NSArray arrayWithObjects:h1, h2, h3, h4, nil];

    NSArray *poly = [NSArray arrayWithObjects:multiPoint, multiPointH, nil];
    
    _fixture = [[GeoJSONPolygon alloc] initWithGeoJSONCoordinates:poly];
    
    STAssertNotNil(_fixture, @"Polygon can't be nil");
    STAssertEquals(4, _fixture.vertexCount, @"Vertex count is not valid");
    STAssertEquals(1, _fixture.holeCount, @"Holes count is not valid");
    
    GeoJSONMultiPoint *hole = [_fixture holeAt:0];
    STAssertNotNil(hole, @"Hole can't be nil");
    STAssertEquals(4, hole.count, @"Vertex count is not valid");

    GeoJSONPoint *p = [hole pointAt:0];
    STAssertNotNil(p, @"Vertex can't be nil");
    STAssertEqualsWithAccuracy(0.75, p.longitude, 0.001, @"Longitude is not valid");
    STAssertEqualsWithAccuracy(0.75, p.latitude, 0.001, @"Latitude is not valid");
    
    p = [hole pointAt:1];
    STAssertNotNil(hole, @"Vertex can't be nil");
    STAssertEqualsWithAccuracy(1.25, p.longitude, 0.001, @"Longitude is not valid");
    STAssertEqualsWithAccuracy(0.75, p.latitude, 0.001, @"Latitude is not valid");
    
    p = [hole pointAt:2];
    STAssertNotNil(p, @"Vertex can't be nil");
    STAssertEqualsWithAccuracy(1.25, p.longitude, 0.001, @"Longitude is not valid");
    STAssertEqualsWithAccuracy(1.25, p.latitude, 0.001, @"Latitude is not valid");
    
    p = [hole pointAt:3];
    STAssertNotNil(p, @"Vertex can't be nil");
    STAssertEqualsWithAccuracy(0.75, p.longitude, 0.001, @"Longitude is not valid");
    STAssertEqualsWithAccuracy(1.25, p.latitude, 0.001, @"Latitude is not valid");
    
    p = [hole pointAt:4];
    STAssertNil(p, @"Vertex must be nil");
    
    hole = [_fixture holeAt:1];
    STAssertNil(hole, @"Hole must be nil");
}





@end

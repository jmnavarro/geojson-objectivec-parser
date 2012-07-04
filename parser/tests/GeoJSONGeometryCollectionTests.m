//
//  GeoJSONGeometryCollectionTests.m
//  geojson-parser
//
//  Created by JM on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GeoJSONGeometryCollectionTests.h"
#import "GeoJSONGeometryCollection.h"
#import "GeoJSONPoint.h"

@implementation GeoJSONGeometryCollectionTests

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

- (void)testShouldWorkEverythingIsOK
{
    NSArray *p1 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:0.5], [NSNumber numberWithDouble:0.5], nil];
    NSDictionary *geom1 = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"Point", @"type",
                          p1, @"coordinates",
                          nil];
    
    NSArray *p2 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:2.5], [NSNumber numberWithDouble:2.5], nil];
    NSDictionary *geom2 = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"Point", @"type",
                          p2, @"coordinates",
                          nil];
    NSDictionary *collection = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"GeometryCollection", @"type",
                           [NSArray arrayWithObjects:geom1, geom2, nil], @"geometries",
                           nil];

    
    _fixture = [[GeoJSONGeometryCollection alloc] initWithGeoJSONGeometryCollection:collection];

    STAssertNotNil(_fixture, @"GeometryCollection can't be nil");
    STAssertEquals(2, _fixture.count, @"Count is not valid");
    
    id g1 = [_fixture geometryAt:0];
    STAssertNotNil(g1, @"Geometry can't be nil");
    STAssertEquals(GeoJSONType_GeometryPoint, [_fixture typeAt:0], @"Type is not valid");
    STAssertTrue([g1 isKindOfClass:[GeoJSONPoint class]], @"Instance is not valid");
    
    id g2 = [_fixture geometryAt:1];
    STAssertNotNil(g2, @"Geometry can't be nil");
    STAssertEquals(GeoJSONType_GeometryPoint, [_fixture typeAt:1], @"Type is not valid");
    STAssertTrue([g2 isKindOfClass:[GeoJSONPoint class]], @"Instance is not valid");
    
    STAssertNil([_fixture geometryAt:2], @"Geometry must be nil");
    STAssertEquals(GeoJSONType_Undefined, [_fixture typeAt:2], @"Type is not valid");
}




@end

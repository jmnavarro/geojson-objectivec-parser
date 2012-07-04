//
//  GeoJSONFeatureTests.m
//  geojson-parser
//
//  Created by JM on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GeoJSONFeatureTests.h"
#import "GeoJSONFeature.h"
#import "GeoJSONPoint.h"

@implementation GeoJSONFeatureTests

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

- (void)testShouldWorkWithCompleteFeature
{
    NSArray *p1 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:0.5], [NSNumber numberWithDouble:0.5], nil];
    NSDictionary *geom = [NSDictionary dictionaryWithObjectsAndKeys:
                                            @"Point", @"type",
                                            p1, @"coordinates",
                                            nil];
    NSDictionary *properties = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", nil];
    NSDictionary *feat = [NSDictionary dictionaryWithObjectsAndKeys:
                                            @"Feature", @"type",
                                            geom, @"geometry",
                                            properties, @"properties",
                                            @"the-id", @"id",
                                            nil];

    _fixture = [[GeoJSONFeature alloc] initWithGeoJSONFeature:feat];
    
    STAssertNotNil(_fixture, @"Feature can't be nil");
    STAssertEquals(GeoJSONType_GeometryPoint, _fixture.geometryType, @"Geometry type is not valid");
    STAssertTrue([@"the-id" isEqualToString:_fixture.featureId], @"Id is not valid");
    STAssertTrue([_fixture.geometry isKindOfClass:[GeoJSONPoint class]], @"Geomtry instance is not valid");
    STAssertTrue(1 == _fixture.properties.count, @"Property count is not valid");
}


- (void)testShouldWorkWithoutId
{
    NSArray *p1 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:0.5], [NSNumber numberWithDouble:0.5], nil];
    NSDictionary *geom = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"Point", @"type",
                          p1, @"coordinates",
                          nil];
    NSDictionary *properties = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", nil];
    NSDictionary *feat = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"Feature", @"type",
                          geom, @"geometry",
                          properties, @"properties",
                          nil];
    
    _fixture = [[GeoJSONFeature alloc] initWithGeoJSONFeature:feat];
    
    STAssertNotNil(_fixture, @"Feature can't be nil");
    STAssertEquals(GeoJSONType_GeometryPoint, _fixture.geometryType, @"Geometry type is not valid");
    STAssertNil(_fixture.featureId, @"Id must be null");
    STAssertNotNil(_fixture.geometry, @"Geomtry instance is not valid");
    STAssertNotNil(_fixture.properties, @"Property count is not valid");
}


- (void)testShouldFailWithoutProperties
{
    NSArray *p1 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:0.5], [NSNumber numberWithDouble:0.5], nil];
    NSDictionary *geom = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"Point", @"type",
                          p1, @"coordinates",
                          nil];
    NSDictionary *feat = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"Feature", @"type",
                          geom, @"geometry",
                          nil];
    
    _fixture = [[GeoJSONFeature alloc] initWithGeoJSONFeature:feat];
    
    STAssertNil(_fixture, @"Feature must be nil");
}


- (void)testShouldFailWithoutGeom
{
    NSDictionary *properties = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", nil];
    NSDictionary *feat = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"Feature", @"type",
                          properties, @"properties",
                          nil];
    
    _fixture = [[GeoJSONFeature alloc] initWithGeoJSONFeature:feat];
    
    STAssertNil(_fixture, @"Feature must be nil");
}

@end

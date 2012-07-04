//
//  GeoJSONFeatureTests.m
//  geojson-parser
//
//  Created by JM on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GeoJSONFactoryTests.h"
#import "GeoJSONFactory.h"
#import "GeoJSONPoint.h"
#import "GeoJSONMultiPoint.h"
#import "GeoJSONPolygon.h"
#import "GeoJSONMultiPolygon.h"
#import "GeoJSONFeature.h"

@implementation GeoJSONFactoryTests

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

- (void)testShouldWorkWithPoint
{
    NSArray *coord = [NSArray arrayWithObjects:[NSNumber numberWithDouble:0.5], [NSNumber numberWithDouble:0.5], nil];
    NSDictionary *geom = [NSDictionary dictionaryWithObjectsAndKeys:
                                            @"Point", @"type",
                                            coord, @"coordinates",
                                            nil];

    _fixture = [[GeoJSONFactory alloc] init];
    
    STAssertTrue([_fixture createObject:geom], @"Create object is not valid");

    STAssertEquals(GeoJSONType_GeometryPoint, _fixture.type, @"Object type is not valid");
    STAssertTrue([_fixture.object isKindOfClass:[GeoJSONPoint class]], @"Object instance is not valid");
}


- (void)testShouldWorkWithMultiPoint
{
    NSArray *p1 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:102.0], [NSNumber numberWithDouble:0.5], nil];
    NSArray *p2 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:2.0], [NSNumber numberWithDouble:0.25], nil];
    NSArray *coords = [NSArray arrayWithObjects:p1, p2, nil];
    NSDictionary *geom = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"MultiPoint", @"type",
                          coords, @"coordinates",
                          nil];
    
    _fixture = [[GeoJSONFactory alloc] init];
    
    STAssertTrue([_fixture createObject:geom], @"Create object is not valid");
    
    STAssertEquals(GeoJSONType_GeometryMultiPoint, _fixture.type, @"Object type is not valid");
    STAssertTrue([_fixture.object isKindOfClass:[GeoJSONMultiPoint class]], @"Object instance is not valid");
    
    [_fixture release];
    
    // now with LineString
    geom = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"LineString", @"type",
                          coords, @"coordinates",
                          nil];
    
    _fixture = [[GeoJSONFactory alloc] init];
    
    STAssertTrue([_fixture createObject:geom], @"Create object is not valid");
    
    STAssertEquals(GeoJSONType_GeometryMultiPoint, _fixture.type, @"Object type is not valid");
    STAssertTrue([_fixture.object isKindOfClass:[GeoJSONMultiPoint class]], @"Object instance is not valid");
}


- (void)testShouldWorkWithPolygon
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

    NSDictionary *geom = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"Polygon", @"type",
                          poly, @"coordinates",
                          nil];
    
    _fixture = [[GeoJSONFactory alloc] init];
    
    STAssertTrue([_fixture createObject:geom], @"Create object is not valid");
    
    STAssertEquals(GeoJSONType_GeometryPolygon, _fixture.type, @"Object type is not valid");
    STAssertTrue([_fixture.object isKindOfClass:[GeoJSONPolygon class]], @"Object instance is not valid");
    
    [_fixture release];
    
    // now with MultiLineString
    geom = [NSDictionary dictionaryWithObjectsAndKeys:
            @"MultiLineString", @"type",
            poly, @"coordinates",
            nil];
    
    _fixture = [[GeoJSONFactory alloc] init];
    
    STAssertTrue([_fixture createObject:geom], @"Create object is not valid");
    
    STAssertEquals(GeoJSONType_GeometryPolygon, _fixture.type, @"Object type is not valid");
    STAssertTrue([_fixture.object isKindOfClass:[GeoJSONPolygon class]], @"Object instance is not valid");
}



- (void)testShouldWorkWithMultiPolygon
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
    
    NSDictionary *geom = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"MultiPolygon", @"type",
                          multi, @"coordinates",
                          nil];
    
    _fixture = [[GeoJSONFactory alloc] init];
    
    STAssertTrue([_fixture createObject:geom], @"Create object is not valid");
    
    STAssertEquals(GeoJSONType_GeometryMultiPolygon, _fixture.type, @"Object type is not valid");
    STAssertTrue([_fixture.object isKindOfClass:[GeoJSONMultiPolygon class]], @"Object instance is not valid");    
}



- (void)testShouldWorkWithFeature
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
    
    _fixture = [[GeoJSONFactory alloc] init];
    
    STAssertTrue([_fixture createObject:feat], @"Create object is not valid");
    
    STAssertEquals(GeoJSONType_Feature, _fixture.type, @"Object type is not valid");
    STAssertTrue([_fixture.object isKindOfClass:[GeoJSONFeature class]], @"Object instance is not valid");
    
    GeoJSONFeature *feature = (GeoJSONFeature*)_fixture.object;
    STAssertEquals(GeoJSONType_GeometryPoint, feature.geometryType, @"Geometry type is not valid");
}



@end

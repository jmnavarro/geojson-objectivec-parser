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
#import "GeoJSONFeatureCollection.h"
#import "GeoJSONGeometryCollection.h"



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



- (void)testShouldWorkWithFeatureCollection
{
    NSArray *p1 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:0.5], [NSNumber numberWithDouble:0.5], nil];
    NSDictionary *geom1 = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"Point", @"type",
                           p1, @"coordinates",
                           nil];
    NSDictionary *properties1 = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", nil];
    NSDictionary *feat1 = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"Feature", @"type",
                           geom1, @"geometry",
                           properties1, @"properties",
                           nil];
    
    NSArray *p2 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:2.5], [NSNumber numberWithDouble:2.5], nil];
    NSDictionary *geom2 = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"Point", @"type",
                           p2, @"coordinates",
                           nil];
    NSDictionary *properties2 = [NSDictionary dictionaryWithObjectsAndKeys:@"value2", @"key2", nil];
    NSDictionary *feat2 = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"Feature", @"type",
                           geom2, @"geometry",
                           properties2, @"properties",
                           nil];
    NSArray *features = [NSArray arrayWithObjects:feat1, feat2, nil];
    NSDictionary *collection = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"FeatureCollection", @"type",
                                features, @"features",
                                nil];
    
    _fixture = [[GeoJSONFactory alloc] init];
    
    STAssertTrue([_fixture createObject:collection], @"Create object is not valid");
    
    STAssertEquals(GeoJSONType_FeatureCollection, _fixture.type, @"Object type is not valid");
    STAssertTrue([_fixture.object isKindOfClass:[GeoJSONFeatureCollection class]], @"Object instance is not valid");
    
    GeoJSONFeatureCollection *coll = (GeoJSONFeatureCollection*)_fixture.object;
    STAssertEquals(2, coll.count, @"Count is not valid");
}



- (void)testShouldWorkWithGeometryCollection
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
    
    _fixture = [[GeoJSONFactory alloc] init];
    
    STAssertTrue([_fixture createObject:collection], @"Create object is not valid");
    
    STAssertEquals(GeoJSONType_GeometryCollection, _fixture.type, @"Object type is not valid");
    STAssertTrue([_fixture.object isKindOfClass:[GeoJSONGeometryCollection class]], @"Object instance is not valid");
    
    GeoJSONGeometryCollection *coll = (GeoJSONGeometryCollection*)_fixture.object;
    STAssertEquals(2, coll.count, @"Count is not valid");
}



- (void)testShouldWorkReusingSameFactory
{
    // same factory
    _fixture = [[GeoJSONFactory alloc] init];

    // first create: point
    NSArray *coord1 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:0.5], [NSNumber numberWithDouble:0.5], nil];
    NSDictionary *geom1 = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"Point", @"type",
                          coord1, @"coordinates",
                          nil];
    
    STAssertTrue([_fixture createObject:geom1], @"Create object is not valid");
    
    STAssertEquals(GeoJSONType_GeometryPoint, _fixture.type, @"Object type is not valid");
    STAssertTrue([_fixture.object isKindOfClass:[GeoJSONPoint class]], @"Object instance is not valid");
    
    // second object: multipoint
    NSArray *p1 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:102.0], [NSNumber numberWithDouble:0.5], nil];
    NSArray *p2 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:2.0], [NSNumber numberWithDouble:0.25], nil];
    NSArray *coord2 = [NSArray arrayWithObjects:p1, p2, nil];
    NSDictionary *geom2 = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"MultiPoint", @"type",
                          coord2, @"coordinates",
                          nil];

    STAssertTrue([_fixture createObject:geom2], @"Create object is not valid");
    
    STAssertEquals(GeoJSONType_GeometryMultiPoint, _fixture.type, @"Object type is not valid");
    STAssertTrue([_fixture.object isKindOfClass:[GeoJSONMultiPoint class]], @"Object instance is not valid");
}


- (void)testShouldWorkReusingSameFactoryWithInvalidObject
{
    // same factory
    _fixture = [[GeoJSONFactory alloc] init];
    
    // first create: point
    NSArray *coord1 = [NSArray arrayWithObjects:[NSNumber numberWithDouble:0.5], [NSNumber numberWithDouble:0.5], nil];
    NSDictionary *geom1 = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"Point", @"type",
                           coord1, @"coordinates",
                           nil];
    
    STAssertTrue([_fixture createObject:geom1], @"Create object is not valid");
    
    STAssertEquals(GeoJSONType_GeometryPoint, _fixture.type, @"Object type is not valid");
    STAssertTrue([_fixture.object isKindOfClass:[GeoJSONPoint class]], @"Object instance is not valid");
    
    // second object: invalid
    NSDictionary *geom2 = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"INVALID_TYPE", @"type",
                           @"foo", @"coordinates",
                           nil];
    
    STAssertFalse([_fixture createObject:geom2], @"Create object is not valid");
    
    STAssertEquals(GeoJSONType_Undefined, _fixture.type, @"Object type is not valid");
    STAssertNil(_fixture.object, @"Object instance is not valid");
}



- (void)testShouldWorkWithJSONString
{
    NSString *json = @"{ \"type\": \"GeometryCollection\",\"geometries\": [{ \"type\": \"Point\",\"coordinates\": [100.0, 0.0]},{ \"type\": \"LineString\",\"coordinates\": [ [101.0, 0.0], [102.0, 1.0] ]}]}";
    
    _fixture = [[GeoJSONFactory alloc] init];
    
    STAssertTrue([_fixture createObjectFromJSON:json], @"Create object is not valid");
    
    STAssertEquals(GeoJSONType_GeometryCollection, _fixture.type, @"Object type is not valid");
    STAssertTrue([_fixture.object isKindOfClass:[GeoJSONGeometryCollection class]], @"Object instance is not valid");
    
    GeoJSONGeometryCollection *coll = (GeoJSONGeometryCollection*)_fixture.object;
    STAssertEquals(2, coll.count, @"Count is not valid");
}


- (void)testShouldWorkWithFeatureCollectionJSONStringAndNullGeometry
{
    NSString* json = @"{\"type\": \"FeatureCollection\",\"features\": [{\"type\": \"Feature\",\"properties\": {\"cartodb_id\": 1, \"name\": \"centro\",\"description\": \"el centro del universo\",\"created_at\": \"2012-06-21T16:56:24.827Z\",\"updated_at\": \"2012-06-21T16:56:46.903Z\"},\"geometry\": \"<null>\"}]}";
    
    _fixture = [[GeoJSONFactory alloc] init];
    
    STAssertTrue([_fixture createObjectFromJSON:json], @"Create object is not valid");
    
    STAssertEquals(GeoJSONType_FeatureCollection, _fixture.type, @"Object type is not valid");
    STAssertTrue([_fixture.object isKindOfClass:[GeoJSONFeatureCollection class]], @"Object instance is not valid");
    
    GeoJSONFeatureCollection *coll = (GeoJSONFeatureCollection*)_fixture.object;
    STAssertEquals(1, coll.count, @"Count is not valid");
    GeoJSONFeature *feat = [coll featureAt:0];
    STAssertNotNil(feat, @"Feature must be not null");
    STAssertNil(feat.geometry, @"Geometry must be null");
    STAssertEquals(GeoJSONType_Undefined, feat.geometryType, @"Geometry type must be undefined");
}


- (void)testShouldFailWithInvalidJSONString
{
    NSString *json = @"{ \"type234\": \"GeometryCollection\",\"geometries\": [{ \"type\": \"Point\",\"coordinates\": [100.0, 0.0]},{ \"type\": \"LineString\",\"coordinates\": [ [101.0, 0.0], [102.0, 1.0] ]}]}";
    
    _fixture = [[GeoJSONFactory alloc] init];
    
    STAssertFalse([_fixture createObjectFromJSON:json], @"Create object is not valid");
    
    STAssertEquals(GeoJSONType_Undefined, _fixture.type, @"Object type is not valid");
    STAssertNil(_fixture.object, @"Object instance is not valid");
}


- (void)testShouldFailWithEmptyJSONString
{
    NSString *json = @"";
    
    _fixture = [[GeoJSONFactory alloc] init];
    
    STAssertFalse([_fixture createObjectFromJSON:json], @"Create object is not valid");
    
    STAssertEquals(GeoJSONType_Undefined, _fixture.type, @"Object type is not valid");
    STAssertNil(_fixture.object, @"Object instance is not valid");
}

- (void)testShouldFailWithNilJSONString
{
    NSString *json = nil;
    
    _fixture = [[GeoJSONFactory alloc] init];
    
    STAssertFalse([_fixture createObjectFromJSON:json], @"Create object is not valid");
    
    STAssertEquals(GeoJSONType_Undefined, _fixture.type, @"Object type is not valid");
    STAssertNil(_fixture.object, @"Object instance is not valid");
}

- (void)testInitialStatus
{
    _fixture = [[GeoJSONFactory alloc] init];
    
    STAssertEquals(GeoJSONType_Undefined, _fixture.type, @"Object type is not valid");
    STAssertNil(_fixture.object, @"Object instance is not valid");
}

- (void)testShouldWorkWithEmptyFeatureCollection
{
    NSString *json = @"{\"type\":\"FeatureCollection\",\"features\":[]}";

    _fixture = [[GeoJSONFactory alloc] init];
    
    STAssertTrue([_fixture createObjectFromJSON:json], @"Create object is not valid");
    
    STAssertEquals(GeoJSONType_FeatureCollection, _fixture.type, @"Object type is not valid");
    STAssertNotNil(_fixture.object, @"Object instance is not valid");
    STAssertTrue([_fixture.object isKindOfClass:[GeoJSONFeatureCollection class]], @"Object instance is not valid");
    
    GeoJSONFeatureCollection *coll = (GeoJSONFeatureCollection*)_fixture.object;
    STAssertEquals(0, coll.count, @"Count is not valid");
    STAssertNil([coll featureAt:0], @"Feature must be null");
}

@end

//
//  GeoJSONMultiPointTests.m
//  geojson-parser
//
//  Created by JM on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GeoJSONFeatureCollectionTests.h"
#import "GeoJSONFeatureCollection.h"
#import "GeoJSONFeature.h"

@implementation GeoJSONFeatureCollectionTests

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

    
    _fixture = [[GeoJSONFeatureCollection alloc] initWithGeoJSONFeatureCollection:collection];

    STAssertNotNil(_fixture, @"FeatureCollection can't be nil");
    STAssertEquals(2, _fixture.count, @"Count is not valid");
    
    GeoJSONFeature *f1 = [_fixture featureAt:0];
    STAssertNotNil(f1, @"Feature can't be nil");
    STAssertEquals(GeoJSONType_GeometryPoint, f1.geometryType, @"Longitude is not valid");
    
    GeoJSONFeature *f2 = [_fixture featureAt:1];
    STAssertNotNil(f2, @"Feature can't be nil");
    STAssertEquals(GeoJSONType_GeometryPoint, f2.geometryType, @"Longitude is not valid");
    
    STAssertNil([_fixture featureAt:2], @"Feature must be nil");
}

- (void) testShouldWorkWithEmptyCollection
{
    NSDictionary *collection = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"FeatureCollection", @"type",
                                [NSArray array], @"features",
                                nil];

    _fixture = [[GeoJSONFeatureCollection alloc] initWithGeoJSONFeatureCollection:collection];
    
    STAssertNotNil(_fixture, @"FeatureCollection can't be nil");
    STAssertEquals(0, _fixture.count, @"Count is not valid");
    
    STAssertNil([_fixture featureAt:0], @"Feature must be nil");
}




@end

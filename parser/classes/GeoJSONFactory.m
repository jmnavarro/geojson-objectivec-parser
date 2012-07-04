//
//  GeoJSONParser.m
//  GeoJSONParserSample
//
//  Created by JM on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GeoJSONFactory.h"
#import "GeoJSONPoint.h"
#import "GeoJSONMultiPoint.h"
#import "GeoJSONPolygon.h"
#import "GeoJSONMultiPolygon.h"
#import "GeoJSONFeature.h"
#import "GeoJSONFeatureCollection.h"
#import "GeoJSONGeometryCollection.h"

#import "SBJsonParser.h"



GeoJSONObjectType GeoJSONTypeFromString(NSString* str)
{
    if ([GeoJSONPoint isType:str]) {
        return GeoJSONType_GeometryPoint;
    } else if ([GeoJSONMultiPoint isType:str]) {
        return GeoJSONType_GeometryMultiPoint;
    } else if ([GeoJSONPolygon isType:str]) {
        return GeoJSONType_GeometryPolygon;
    } else if ([GeoJSONMultiPolygon isType:str]) {
        return GeoJSONType_GeometryMultiPolygon;
    } else if ([GeoJSONFeature isType:str]) {
        return GeoJSONType_Feature;
    } else if ([GeoJSONFeatureCollection isType:str]) {
        return GeoJSONType_FeatureCollection;
    } else if ([GeoJSONGeometryCollection isType:str]) {
        return GeoJSONType_GeometryCollection;
    }
    
    return GeoJSONType_Undefined;
}

NSString* NSStringFromGeoJSONType(GeoJSONObjectType type)
{
    switch (type) {
        case GeoJSONType_GeometryPoint:
            return @"Point";
            break;
        case GeoJSONType_GeometryMultiPoint:
            return @"MultiPoint";
        case GeoJSONType_GeometryPolygon:
            return @"Polygon";
        case GeoJSONType_GeometryMultiPolygon:
            return @"MultiPolygon";
        case GeoJSONType_GeometryCollection:
            return @"GeometryCollection";
        case GeoJSONType_Feature:
            return @"Feature";
        case GeoJSONType_FeatureCollection:
            return @"FeatureCollection";
        case GeoJSONType_Undefined:
            return @"Undefined";
    }
    return @"Unknown";
}



@implementation GeoJSONFactory

@synthesize object = _object;
@synthesize type = _type;



- (NSDictionary*) parseJSON:(NSString*)json
{
    if (json.length == 0) {
        return nil;
    }
    
#ifdef DEBUG
    NSLog(@"Parsing %@...", json);
#endif
    
	SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSError *error = nil;
	NSDictionary *dict = [parser objectWithString:json error:&error];
	[parser release];
    
    return (error != nil) ? nil : dict;
}


- (bool) createObjectFromJSON:(NSString*)geojson
{
    NSDictionary *dict = [self parseJSON:geojson];
    return [self createObject:dict];
}


- (bool) createObject:(NSDictionary*)geojson
{
    if (geojson.count == 0) {
        return NO;
    }
    
    NSString *objType = [geojson objectForKey:@"type"];

    _type = GeoJSONTypeFromString(objType);
    [_object release]; _object = nil;

    NSArray* coord = [geojson objectForKey:@"coordinates"];
    switch (_type) {
        case GeoJSONType_GeometryPoint:
            _object = [[GeoJSONPoint alloc] initWithGeoJSONCoordinates:coord];
            break;
        case GeoJSONType_GeometryMultiPoint:
            _object = [[GeoJSONMultiPoint alloc] initWithGeoJSONCoordinates:coord];
            break;
        case GeoJSONType_GeometryPolygon:
            _object = [[GeoJSONPolygon alloc] initWithGeoJSONCoordinates:coord];
            break;
        case GeoJSONType_GeometryMultiPolygon:
            _object = [[GeoJSONMultiPolygon alloc] initWithGeoJSONCoordinates:coord];
            break;
        case GeoJSONType_GeometryCollection:
            _object = [[GeoJSONGeometryCollection alloc] initWithGeoJSONGeometryCollection:geojson];
            break;
        case GeoJSONType_Feature:
            _object = [[GeoJSONFeature alloc] initWithGeoJSONFeature:geojson];
            break;
        case GeoJSONType_FeatureCollection:
            _object = [[GeoJSONFeatureCollection alloc] initWithGeoJSONFeatureCollection:geojson];
            break;
        default:
            _type = GeoJSONType_Undefined;
            _object = nil;
            break;
    }
    
    return (_object != nil);
}



                
- (void) dealloc
{
    [_object release];
    [super dealloc];
}

@end

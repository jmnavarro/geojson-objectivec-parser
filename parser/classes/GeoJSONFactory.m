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



@implementation GeoJSONFactory

@synthesize object = _object;
@synthesize type = _type;

- (bool) createObject:(NSDictionary*)geojson
{
    NSString *objType = [geojson objectForKey:@"type"];

    _type = [self geoJSONTypeFromString:objType];
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
/*
        case GeoJSONType_GeometryCollection:
        {
            NSDictionary *geometries = [geojson objectForKey:@"geometries"];
            _object = [[GeoJSONGeometryCollection alloc] initWithGeoJSONGeometries:geometries];
            break;
        }
 */
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


- (GeoJSONObjectType) geoJSONTypeFromString:(NSString*)str
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
    }
                //"GeometryCollection"
    return GeoJSONType_Undefined;
}
                
- (void) dealloc
{
    [_object release];
    [super dealloc];
}

@end

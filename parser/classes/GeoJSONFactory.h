//
//  GeoJSONParser.h
//  GeoJSONParserSample
//
//  Created by JM on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    GeoJSONType_Undefined = 0,
    GeoJSONType_GeometryPoint,
    GeoJSONType_GeometryMultiPoint,
    GeoJSONType_GeometryPolygon,
    GeoJSONType_GeometryMultiPolygon,
    GeoJSONType_GeometryCollection,
    GeoJSONType_Feature,
    GeoJSONType_FeatureCollection
} GeoJSONObjectType;


@interface GeoJSONFactory : NSObject

@property (nonatomic, readonly) id object;
@property (nonatomic, readonly) GeoJSONObjectType type;

- (bool) createObject:(NSDictionary*)geojson;
- (bool) createObjectFromJSON:(NSString*)geojson;

@end

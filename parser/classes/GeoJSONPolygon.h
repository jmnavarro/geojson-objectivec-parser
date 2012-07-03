//
//  GeoJSONPolygon.h
//  geojson-parser
//
//  Created by JM on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GeoJSONPoint;
@class GeoJSONMultiPoint;

@interface GeoJSONPolygon : NSObject
{
    GeoJSONMultiPoint *_points;
    NSArray* _holes;
}

@property (nonatomic, readonly) int vertexCount;
@property (nonatomic, readonly) int holeCount;

- (id) initWithGeoJSONCoordinates:(NSArray*)coords;

- (GeoJSONPoint*) vertexAt:(int)index;
- (GeoJSONMultiPoint*) holeAt:(int)index;

+ (bool) isType:(NSString*)type;

@end

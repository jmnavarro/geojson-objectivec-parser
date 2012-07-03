//
//  GeoJSONMultiPolygon.h
//  geojson-parser
//
//  Created by JM on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GeoJSONPolygon;

@interface GeoJSONMultiPolygon : NSObject
{
    NSArray* _polygons;
}

@property (nonatomic, readonly) int count;

- (id) initWithGeoJSONCoordinates:(NSArray*)coords;
- (GeoJSONPolygon*) polygonAt:(int)index;

+ (bool) isType:(NSString*)type;

@end

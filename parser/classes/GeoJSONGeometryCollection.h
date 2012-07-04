//
//  GeoJSONGeometryCollection.h
//  geojson-parser
//
//  Created by JM on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeoJSONFactory.h"

@class GeoJSONGeometry;

@interface GeoJSONGeometryCollection : NSObject
{
    NSArray* _geometries;
    NSArray* _types;
}

@property (nonatomic, readonly) int count;

- (id) initWithGeoJSONGeometryCollection:(NSDictionary*)collection;
- (id) geometryAt:(int)index;
- (GeoJSONObjectType) typeAt:(int)index;

+ (bool) isType:(NSString*)type;

@end

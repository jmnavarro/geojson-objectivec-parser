//
//  GeoJSONFeatureCollection.h
//  geojson-parser
//
//  Created by JM on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GeoJSONFeature;

@interface GeoJSONFeatureCollection : NSObject
{
    NSArray* _features;
}

@property (nonatomic, readonly) int count;

- (id) initWithGeoJSONFeatureCollection:(NSDictionary*)coords;
- (GeoJSONFeature*) featureAt:(int)index;

+ (bool) isType:(NSString*)type;

@end

//
//  GeoJSONMultiPoint.h
//  geojson-parser
//
//  Created by JM on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GeoJSONPoint;

@interface GeoJSONMultiPoint : NSObject
{
    NSArray* _points;
}

@property (nonatomic, readonly) int count;

- (id) initWithGeoJSONCoordinates:(NSArray*)coords;

- (GeoJSONPoint*) pointAt:(int)index;


@end

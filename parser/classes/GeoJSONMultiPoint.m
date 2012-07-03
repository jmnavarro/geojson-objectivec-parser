//
//  GeoJSONMultiPoint.m
//  geojson-parser
//
//  Created by JM on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GeoJSONMultiPoint.h"
#import "GeoJSONPoint.h"

@implementation GeoJSONMultiPoint

@synthesize count;

- (id) initWithGeoJSONCoordinates:(NSArray*)coords
{
    if (self = [super init]) {
        NSMutableArray *tmp = [[NSMutableArray alloc] initWithCapacity:coords.count];
        
        for (NSArray* point in coords) {
            GeoJSONPoint *geoPoint = [[GeoJSONPoint alloc] initWithGeoJSONCoordinates:point];
            if (geoPoint) {
                [tmp addObject:geoPoint];
                [geoPoint release];
            }
        }
        
        _points = [[NSArray alloc] initWithArray:tmp];
        [tmp release];
    }
    return self;
}


- (GeoJSONPoint*) pointAt:(int)index
{
    return index < _points.count ? [_points objectAtIndex:index] : nil;
}

- (int) count
{
    return _points ? _points.count : -1;
}

- (void) dealloc
{
    [_points release];
    [super dealloc];
}

@end

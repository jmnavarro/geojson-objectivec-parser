//
//  GeoJSONMultiPolygon.m
//  geojson-parser
//
//  Created by JM on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GeoJSONMultiPolygon.h"
#import "GeoJSONPolygon.h"


@implementation GeoJSONMultiPolygon


- (id) initWithGeoJSONCoordinates:(NSArray*)coords
{
    if (self = [super init]) {
        NSMutableArray *tmp = [[NSMutableArray alloc] initWithCapacity:coords.count];
        
        for (NSArray* Polygon in coords) {
            GeoJSONPolygon *geoPoly = [[GeoJSONPolygon alloc] initWithGeoJSONCoordinates:Polygon];
            if (geoPoly) {
                [tmp addObject:geoPoly];
                [geoPoly release];
            }
        }

        _polygons = [[NSArray alloc] initWithArray:tmp];
        [tmp release];
    }
    return self;
}


- (GeoJSONPolygon*) polygonAt:(int)index
{
    return index < _polygons.count ? [_polygons objectAtIndex:index] : nil;
}

- (int) count
{
    return _polygons ? _polygons.count : -1;
}


+ (bool) isType:(NSString*)type
{
    return [@"MultiPolygon" isEqualToString:type];
}

- (NSString*) description
{
    NSMutableString *str = [[NSMutableString alloc] initWithCapacity:256];
    [str appendFormat:@"MultiPolygon(polygons=%d)[", self.count, nil];
    for (int i = 0; i < _polygons.count; ++i) {
        GeoJSONPolygon *p = [self polygonAt:i];
        [str appendFormat:@"\n\tPolygon %d: %@", i, [p description]];
    }
    [str appendFormat:@"\n]"];
    return [NSString stringWithString:str];
}


- (void) dealloc
{
    [_polygons release];
    [super dealloc];
}

@end

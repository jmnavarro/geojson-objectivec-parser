//
//  GeoJSONPoint.m
//  geojson-parser
//
//  Created by JM on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GeoJSONPoint.h"

@implementation GeoJSONPoint

@synthesize longitude = _longitude;
@synthesize latitude = _latitude;
@synthesize altitude = _altitude;



- (id) initWithGeoJSONCoordinates:(NSArray*)coord
{
    if (self = [super init]) {
        int c = coord.count;
        if (c >= 2) {
            _longitude = [[coord objectAtIndex:0] doubleValue];
            _latitude = [[coord objectAtIndex:1] doubleValue];
            _altitude = (c >= 3) ? [[coord objectAtIndex:2] doubleValue] : -1;
        } else {
            self = nil;
        }
    }
    return self;
}

@end

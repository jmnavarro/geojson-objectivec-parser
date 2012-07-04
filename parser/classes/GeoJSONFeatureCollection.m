//
//  GeoJSONMultiPolygon.m
//  geojson-parser
//
//  Created by JM on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GeoJSONFeatureCollection.h"
#import "GeoJSONFeature.h"


@implementation GeoJSONFeatureCollection


- (id) initWithGeoJSONFeatureCollection:(NSDictionary*)collection
{
    if (self = [super init]) {
        NSArray *features = [collection objectForKey:@"features"];
        
        if (features != nil) {
            NSMutableArray *tmp = [[NSMutableArray alloc] initWithCapacity:features.count];
            
            for (NSDictionary* feat in features) {
                GeoJSONFeature *feature = [[GeoJSONFeature alloc] initWithGeoJSONFeature:feat];
                if (feature) {
                    [tmp addObject:feature];
                    [feature release];
                }
            }
            
            _features = [[NSArray alloc] initWithArray:tmp];
            [tmp release];
        } else {
            self = nil;
        }
    }
    return self;
}


- (GeoJSONFeature*) featureAt:(int)index
{
    return index < _features.count ? [_features objectAtIndex:index] : nil;
}

- (int) count
{
    return _features ? _features.count : -1;
}


+ (bool) isType:(NSString*)type
{
    return [@"FeatureCollection" isEqualToString:type];
}


- (void) dealloc
{
    [_features release];
    [super dealloc];
}

@end

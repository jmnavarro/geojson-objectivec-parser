//
//  GeoJSONGeometryCollection.m
//  geojson-parser
//
//  Created by JM on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GeoJSONGeometryCollection.h"


@implementation GeoJSONGeometryCollection


- (id) initWithGeoJSONGeometryCollection:(NSDictionary*)collection
{
    if (self = [super init]) {
        NSArray *geometries = [collection objectForKey:@"geometries"];
        
        if (geometries != nil) {
            NSMutableArray *tmpObjects = [[NSMutableArray alloc] initWithCapacity:geometries.count];
            NSMutableArray *tmpTypes = [[NSMutableArray alloc] initWithCapacity:geometries.count];
            
            GeoJSONFactory *factory = [[GeoJSONFactory alloc] init];

            for (NSDictionary* geomJSON in geometries) {
                if ([factory createObject:geomJSON]) {
                    [tmpObjects addObject:factory.object];
                    [tmpTypes addObject:[NSNumber numberWithInt:factory.type]];
                }
            }

            [factory release];

            _geometries = [[NSArray alloc] initWithArray:tmpObjects];
            _types = [[NSArray alloc] initWithArray:tmpTypes];

            [tmpObjects release];
            [tmpTypes release];
        } else {
            self = nil;
        }
    }
    return self;
}


- (id) geometryAt:(int)index
{
    return index < _geometries.count ? [_geometries objectAtIndex:index] : nil;
}

- (GeoJSONObjectType) typeAt:(int)index
{
    return index < _types.count ? (GeoJSONObjectType)[[_types objectAtIndex:index] intValue] : GeoJSONType_Undefined;
}

- (int) count
{
    return _geometries ? _geometries.count : -1;
}


+ (bool) isType:(NSString*)type
{
    return [@"GeometryCollection" isEqualToString:type];
}


- (NSString*) description
{
    NSMutableString *str = [[NSMutableString alloc] initWithCapacity:256];
    [str appendFormat:@"GeometryCollection(count=%d)[", self.count, nil];
    int i = 0;
    for (id g in _geometries) {
        [str appendFormat:@"\n\tGeometry %d (type=%@): %@", i, NSStringFromGeoJSONType([self typeAt:i]), [g description]];
        i++;
    }
    [str appendFormat:@"\n]"];
    return [NSString stringWithString:str];
}



- (void) dealloc
{
    [_geometries release];
    [_types release];
    [super dealloc];
}

@end

//
//  GeoJSONFeature.m
//  GeoJSONParserSample
//
//  Created by JM on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GeoJSONFeature.h"
#import "GeoJSONFactory.h"


@implementation GeoJSONFeature

@synthesize properties = _properties;
@synthesize featureId = _featureId;
@synthesize geometry = _geometry;
@synthesize geometryType = _geometryType;

- (id) initWithGeoJSONFeature:(NSDictionary*)feat
{
    if (self = [super init]) {
        _featureId = [[feat objectForKey:@"id"] copy];  // optional
        
        NSDictionary *prop = [feat objectForKey:@"properties"];
        _properties = prop != nil ? [[NSDictionary alloc] initWithDictionary:prop copyItems:YES] : nil;
        NSDictionary *geom = [feat objectForKey:@"geometry"];
        
        if (!geom || !_properties) {
            self = nil;
        } else {
            GeoJSONFactory *parser = [[GeoJSONFactory alloc] init];
            
            if ([parser createObject:geom]) {
                _geometryType = parser.type;
                _geometry = [parser.object retain];
            } else {
                self = nil;
            }
            
            [parser release];
        }
    }
    return self;
}


+ (bool) isType:(NSString*)type
{
    return [@"Feature" isEqualToString:type];
}

- (NSString*) description
{
    NSMutableString *str = [[NSMutableString alloc] initWithCapacity:256];
    [str appendFormat:@"Feature(id=%@)[", _featureId == nil ? @"nil" : _featureId, nil];
    [str appendFormat:@"\n\tType=%@", NSStringFromGeoJSONType(_geometryType)];
    [str appendFormat:@"\n\tGeom=[%@]\n]", [_geometry description]];
    return [NSString stringWithString:str];
}



- (void) dealloc
{
    [_featureId release];
    [_properties release];
    [_geometry release];
    [super dealloc];
}

@end

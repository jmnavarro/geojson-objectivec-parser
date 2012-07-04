//
//  GeoJSONFeature.m
//  GeoJSONParserSample
//
//  Created by JM on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GeoJSONFeature.h"
#import "GeoJSONParser.h"


@implementation GeoJSONFeature

@synthesize properies = _properies;
@synthesize featureId = _featureId;
@synthesize geometry = _geometry;
@synthesize geometryType = _geometryType;

- (id) initWithGeoJSONFeature:(NSDictionary*)feat
{
    if (self = [super init]) {
        _featureId = [[feat objectForKey:@"id"] copy];  // optional
        
        NSDictionary *prop = [feat objectForKey:@"properties"];
        _properies = prop != nil ? [[NSDictionary alloc] initWithDictionary:prop copyItems:YES] : nil;
        NSDictionary *geom = [feat objectForKey:@"geometry"];
        
        if (!geom || !_properies) {
            self = nil;
        } else {
            GeoJSONParser *parser = [[GeoJSONParser alloc] init];
            
            if ([parser parse:geom]) {
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

- (void) dealloc
{
    [_featureId release];
    [_properies release];
    [_geometry release];
    [super dealloc];
}

@end

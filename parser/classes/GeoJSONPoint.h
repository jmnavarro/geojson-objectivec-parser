//
//  GeoJSONPoint.h
//  geojson-parser
//
//  Created by JM on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeoJSONPoint : NSObject

@property (nonatomic, readonly) double longitude;
@property (nonatomic, readonly) double latitude;
@property (nonatomic, readonly) double altitude;

- (id) initWithGeoJSONCoordinates:(NSArray*)coord;

@end

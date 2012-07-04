//
//  ViewController.m
//  GeoJSONParserSample
//
//  Created by JM on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "GeoJSONFactory.h"

@implementation ViewController

@synthesize json, result;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)doParse:(id)sender
{
    [json resignFirstResponder];
    
    GeoJSONFactory *factory = [[GeoJSONFactory alloc] init];
    NSMutableString *str = [[NSMutableString alloc] initWithCapacity:512];
    
    bool ok = [factory createObjectFromJSON:json.text];

    [str appendFormat:@"Result: %@", ok ? @"ok" : @"error"];
    [str appendFormat:@"\nObject type: %@", NSStringFromGeoJSONType(factory.type)];
    [str appendFormat:@"\nObject description:\n\n%@", factory.object];
    
    result.text = str;
    
    [factory release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end

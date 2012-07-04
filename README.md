geojson-objectivec-parser
==========================

This set of Objective-C classes implements a data model for GeoJSON specification. It uses a one-to-one approach, so don't be intimidated by the amount of classes: they are just data wrappers of json objects.


Dependencies
----------------

json-framework (https://github.com/stig/json-framework/)


Usage
-------------

1. Clone code (with recursive
`git clone git://github.com/jmnavarro/geojson-objectivec-parser.git --recursive`

2. Open copy classes from `parser/classes` to your project. Note you should copy also json-framework classes

3. Use GeoJSONFactory class to parse your jsons, like this:
`GeoJSONFactory *factory = [[GeoJSONFactory alloc] init];
    
if ([factory createObjectFromJSON:@"the json string"]) {
	// parse ok
	// factory.type contains the type of object created (GeoJSONPoint, GeoJSONFeature, etc.)
	// factory.object contains the object of previous type
} else {
	// parse error. No more info, sorry
}`


TODO (feel free to pull)
---------------------------

* More error handling (parse error)
* Implement Coordinate Reference System Objects (http://www.geojson.org/geojson-spec.html#coordinate-reference-system-objects)
* Support bounding boxes (http://www.geojson.org/geojson-spec.html#bounding-boxes)
* Test on MacOS and write a sample
* ARC aware

Screeshot
-------------------
![Emulator showing one object tree created](https://github.com/jmnavarro/geojson-objectivec-parser/blob/master/img/ios-sample.png?raw=true)



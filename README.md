geojson-objectivec-parser
==========================

This set of Objective-C classes implements a data model for [GeoJSON specification](http://www.geojson.org/geojson-spec.html). It uses a one-to-one approach, so don't be intimidated by the amount of classes: they are just data wrappers of json objects.


Dependencies
----------------

json-framework (https://github.com/stig/json-framework/)


Usage
-------------

1. Clone code (with recursive
`git clone git://github.com/jmnavarro/geojson-objectivec-parser.git --recursive`

2. Open copy classes from `parser/classes` to your project. Note you should copy also json-framework classes

3. Use GeoJSONFactory class to parse your jsons, like this:

```obj-c

GeoJSONFactory *factory = [[GeoJSONFactory alloc] init];
    
if ([factory createObjectFromJSON:@"the geojson string"]) {
	// parse ok
	// factory.type contains the type of object created (GeoJSONPoint, GeoJSONFeature, etc.)
	// factory.object contains the object of previous type
} else {
	// parse error. No more info, sorry
}
```


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

License
--------------------

This library is free software ("Licensed Software"); you can redistribute it and/or modify it under the terms of the [GNU Lesser General Public License](http://www.gnu.org/licenses/lgpl-2.1.html) as
published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; including but not limited to, the implied warranty of MERCHANTABILITY, NONINFRINGEMENT, or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the [GNU Lesser General Public
License](http://www.gnu.org/licenses/lgpl-2.1.html) along with this library; if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth
Floor, Boston, MA 02110-1301 USA

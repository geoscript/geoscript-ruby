geoscript-ruby

GeoScript for JRuby

```ruby
require 'geoscript'
# => true
include GeoScript::Geom
# => Object

p = Point.create -111.0, 45.7
# => #<GeoScript::Geom::Point:0x7f4d4b79 @bounds=#<GeoScript::Geom::Bounds:0x50ecb7c8>>
p.to_wkt
# => "POINT (-111.0 45.7)"

p2 = GeoScript::Projection.reproject p, 'epsg:4326', 'epsg:26912'
# => #<Java::ComVividsolutionsJtsGeom::Point:0x2d547681>
p2.x
# => 500000.0
p2.y
# => 5060716.313515949

poly = p2.buffer 100
# => #<Java::ComVividsolutionsJtsGeom::Polygon:0x157106f7>
poly.get_area
# => 31214.451522458345
```
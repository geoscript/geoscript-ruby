geoscript-ruby

GeoScript for JRuby

If in development, run `mvn install` to get GeoTools dependencies

```ruby
# installed gem
# %> geoscript

# development
# %> rake console
# or
# %> bin/geoscript

require 'geoscript'
# => true
include GeoScript::Geom
# => Object

p = Point.new -111.0, 45.7
# => #<GeoScript::Geom::Point:0x636c4fcb>
p.to_wkt
# => "POINT (-111 45.7)"

p2 = GeoScript::Projection.reproject p, 'epsg:4326', 'epsg:26912'
# => #<GeoScript::Geom::Point:0x6a55c240>
p2.to_wkt
# => "POINT (500000 5060716.313515949)"

poly = p2.buffer 100
# => #<GeoScript::Geom::Polygon:0x7b32aba9>
poly.get_area
# => 31214.451522458345
```
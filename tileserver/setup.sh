createdb -U postgres osm
psql -U postgres osm -c "CREATE EXTENSION postgis;"

curl "https://s3.amazonaws.com/metro-extracts.mapzen.com/mumbai_india.osm.pbf" -o mumbai_india.osm.pbf
osm2pgsql -s -U postgres -d osm mumbai_india.osm.pbf

git clone https://github.com/mapbox/osm-bright.git
curl -o simplified_land_polygons.zip "http://data.openstreetmapdata.com/simplified-land-polygons-complete-3857.zip"
curl -o land_polygons.zip "http://data.openstreetmapdata.com/land-polygons-split-3857.zip"
curl -o ne_places.zip "http://mapbox-geodata.s3.amazonaws.com/natural-earth-1.4.0/cultural/10m-populated-places-simple.zip"

mkdir shp

unzip simplified_land_polygons.zip -d shp/simplified_land_polygons
unzip land_polygons.zip -d shp/land_polygons
unzip ne_places.zip -d shp/ne_places

rm simplified_land_polygons.zip
rm land_polygons.zip
rm ne_places.zip

curl -o open-sans.zip "http://www.fontsquirrel.com/fonts/download/open-sans"
unzip open-sans.zip -d open-sans
sudo mv -f open-sans /usr/share/fonts/truetype/
rm open-sans.zip

sudo fc-cache -f -v

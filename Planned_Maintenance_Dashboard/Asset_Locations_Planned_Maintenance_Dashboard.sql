select assnbri as asset_no, asset_id, ST_X(ST_Transform(geometry,4326)) as Lon,
ST_Y(ST_Transform(geometry,4326)) as Lat
from hd.outlet
union
select assnbri as asset_no, asset_id, ST_X(ST_Transform(geometry,4326)) as Lon,
ST_Y(ST_Transform(geometry,4326)) as Lat
from hd.regulator
--select find_nearest_stations(array['diesel', 'gas', 'petrol']:: varchar(50)[], 28.650825::float, 77.193795::float);

--DROP FUNCTION find_nearest_stations(character varying[],double precision,double precision)

create or replace function find_nearest_stations(filling_types varchar(50)[], x float, y float)
returns table ( station_id int, name varchar(200), images text[], location json, deals_in varchar(50) ) as $$
declare
begin
	return query 
	select
		t.id as station_id,
		t.name, 
		t.images, 
		t.location,
		t.deals_in
	from (
		SELECT 
			ss.id,
			ss.name, 
			ss.images, 
			ST_AsGeoJson(ss.location)::json as location,
			ss.deals_in,
			row_number() over (partition by ss.deals_in order by ss.location <-> ST_MakePoint(x, y)::geography) as row_num
		FROM service_stations ss 
		where ss.deals_in = any(find_nearest_stations.filling_types::varchar(50)[])
	) t
	where t.row_num = 1;
end
$$
language plpgsql
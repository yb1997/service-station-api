-- function to validate user, if validated then returns userid, role('consumer' | 'service_station'), role specific id(depends on role)
-- select validate_user('ckent', 'superman');
create or replace function validate_user(username varchar(200), password varchar(200))
returns table (status int, description varchar, user_id int, role varchar)
as $$
declare
	user_id int;
	role varchar;
begin
	select
		case when c.id is not null then c.id else ss.id end into user_id
	from users u 
	left join consumers c on c.user_id = u.id
	left join service_stations ss on ss.user_id = u.id
	where u.username = validate_user.username and u.password = validate_user.password and (ss.id is not null or c.id is not null);

	select
		case when c.id is not null then 'consumer' else 'service_station' end into role
	from users u 
	left join consumers c on c.user_id = u.id
	left join service_stations ss on ss.user_id = u.id
	where u.username = validate_user.username and u.password = validate_user.password and (ss.id is not null or c.id is not null);

	if user_id is not null then
		return query select 0, 'ok'::varchar, user_id, role;
	else
		return query select 1, 'invalid username or password'::varchar, -1, ''::varchar;
	end if;

end; $$
language 'plpgsql';

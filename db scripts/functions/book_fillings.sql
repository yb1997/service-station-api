create function book_fillings(consumer_id int, service_station_id int, booking_detail json)
returns int as $$
declare 
	newBookingId int;
begin
	insert into bookings (consumer_id, service_station_id, booking_detail) 
	values 
	(book_fillings.consumer_id, book_fillings.service_station_id, book_fillings.booking_detail::jsonb)
	returning id into newBookingId;

	return newBookingId;
end; $$
language 'plpgsql';

-- drop function book_fillings
--truncate table bookings;
-- select book_fillings(2, 10, '[{ "test": 123 }]');
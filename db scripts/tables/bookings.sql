-- Table: public.bookings

-- DROP TABLE public.bookings;

CREATE TABLE public.bookings
(
  id integer NOT NULL DEFAULT nextval('bookings_id_seq'::regclass),
  consumer_id integer NOT NULL,
  service_station_id integer NOT NULL,
  booking_detail jsonb NOT NULL,
  created_on timestamp without time zone DEFAULT now(),
  CONSTRAINT bookings_pkey PRIMARY KEY (id),
  CONSTRAINT bookings_consumer_id_fkey FOREIGN KEY (consumer_id)
      REFERENCES public.consumers (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT bookings_service_station_id_fkey FOREIGN KEY (service_station_id)
      REFERENCES public.service_stations (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.bookings
  OWNER TO yogi;


INSERT INTO public.bookings(id, consumer_id, service_station_id, booking_detail, created_on)
VALUES (1, 2, 10, '[{"year": 2010, "model": "dodge challenger", "capacity": 15}]', '2020-06-02 00:56:57.172988'::timestamp);

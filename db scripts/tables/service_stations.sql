-- Table: public.service_stations

-- DROP TABLE public.service_stations;

CREATE TABLE public.service_stations
(
  id integer NOT NULL DEFAULT nextval('service_stations_id_seq'::regclass),
  name character varying(200),
  images text[] DEFAULT '{}'::text[],
  user_id integer NOT NULL DEFAULT nextval('service_stations_user_id_seq'::regclass),
  location geography NOT NULL,
  deals_in character varying(50),
  CONSTRAINT service_stations_pkey PRIMARY KEY (id),
  CONSTRAINT service_stations_user_id_fkey FOREIGN KEY (user_id)
      REFERENCES public.users (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT service_stations_deals_in_check CHECK (deals_in::text = 'gas'::text OR deals_in::text = 'petrol'::text OR deals_in::text = 'diesel'::text)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.service_stations
  OWNER TO yogi;

-- Index: public.service_stations_location_idx

-- DROP INDEX public.service_stations_location_idx;

CREATE INDEX service_stations_location_idx
  ON public.service_stations
  USING gist
  (location);

INSERT INTO public.service_stations(id, name, images, user_id, location, deals_in)
values(11, 'Bharat Gas Station', '{}', 7, '0101000020E61000007A36AB3E57673E40FF3EE3C281305340'::geography, 'gas'),
values(12, 'John Diesel Station', '{}', 8, '0101000020E6100000863DEDF0D7B43E406F2EFEB627305340'::geography, 'diesel'),
values(13, 'Shell Petrol Station', '{}', 9, '0101000020E6100000D2A755F4875A3F4009336DFFCAAA0240'::geography, 'petrol'),
values(14, 'American Gas Station', '{}', 10, '0101000020E61000004E7D2079E7224340B51666A19DDE54C0'::geography, 'gas'),
values(15, 'British Diesel Station', '{}', 11, '0101000020E6100000A6F10BAF24854740AA471ADCD6C61140'::geography, 'diesel'),
values(10, 'Indian Petrol Station', '{/images/tony_stark_200x200.jpeg}', 6, '0101000020E6100000516B9A779CA63C4036C82423674C5340'::geography, 'petrol');


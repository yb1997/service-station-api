-- Table: public.consumers

-- DROP TABLE public.consumers;

CREATE TABLE public.consumers
(
  id integer NOT NULL DEFAULT nextval('consumers_id_seq'::regclass),
  first_name character varying(50) NOT NULL,
  last_name character varying(50),
  phone_number character varying(10) NOT NULL,
  email character varying(150),
  is_blocked boolean DEFAULT false,
  user_id integer,
  CONSTRAINT consumers_pkey PRIMARY KEY (id),
  CONSTRAINT consumers_user_id_fkey FOREIGN KEY (user_id)
      REFERENCES public.users (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.consumers
  OWNER TO yogi;

INSERT INTO public.consumers(id, first_name, last_name, phone_number, email, is_blocked, user_id)
values(1, 'Peter', 'Parker', '9955448877', 'pparker@dailybugle.com', false, 3),
values(2, 'Clark', 'Kent', '5544772211', 'ckent@smallville.com', false, 4),
values(3, 'Tony', 'Stark', '9587451265', 'ironman@avengers.com', false, 5);

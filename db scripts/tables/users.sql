-- Table: public.users

-- DROP TABLE public.users;

CREATE TABLE public.users
(
  id integer NOT NULL DEFAULT nextval('users_id_seq'::regclass),
  username character varying(200),
  password character varying(200),
  is_active boolean DEFAULT true,
  created_on timestamp without time zone DEFAULT now(),
  CONSTRAINT users_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.users
  OWNER TO yogi;

INSERT INTO public.users
(id, username, password, is_active, created_on)
values(3, 'pparker', 'spiderman', true, '2020-06-01 12:59:02.623204'),
values(4, 'ckent', 'superman', true, '2020-06-01 12:59:02.623204'),
values(5, 'tstark', 'ironman', true, '2020-06-01 12:59:02.623204'),
values(7, 'bharatGas', 'bharatGas', true, '2020-06-01 20:53:52.929565'),
values(8, 'johnDiesel', 'johnDiesel', true, '2020-06-01 20:53:52.929565'),
values(10, 'americanGas', 'americanGas', true, '2020-06-01 20:53:52.929565'),
values(11, 'britishDiesel', 'britishDiesel', true, '2020-06-01 20:53:52.929565'),
values(6, 'indianPetrol', 'indianPetrol', true, '2020-06-01 20:53:52.929565'),
values(9, 'shellPetrol', 'shellPetrol', true, '2020-06-01 20:53:52.929565');

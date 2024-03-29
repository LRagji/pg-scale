\connect clone 

CREATE SEQUENCE IF NOT EXISTS public.writer_scoped_seq;

CREATE TABLE IF NOT EXISTS public.p_mem
(
    "system_id" bigint NOT NULL DEFAULT (pg_control_system()).system_identifier,
    "timestamp" timestamp with time zone NOT NULL DEFAULT now(),
    "sequence" integer NOT NULL DEFAULT nextval('writer_scoped_seq'::regclass),
    "address" bigint NOT NULL,
    "value" json,
    PRIMARY KEY ("system_id", "timestamp", "sequence")
);

CREATE PUBLICATION pub1 FOR
TABLE public.p_mem
WITH (
        publish = 'insert, update, delete'
    );
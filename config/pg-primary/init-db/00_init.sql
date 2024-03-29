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

-- Required when writers come and go
-- ALTER SUBSCRIPTION sub1 DISABLE;
-- ALTER SUBSCRIPTION sub1 SET (slot_name = NONE);
-- DROP SUBSCRIPTION sub1;

CREATE SUBSCRIPTION sub1 CONNECTION 'postgresql://postgres:postgres@pg-writer/clone' PUBLICATION pub1;
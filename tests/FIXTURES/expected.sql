drop extension if exists "pg_trgm";

drop view if exists "public"."vvv" cascade;

drop function if exists "public"."changed"(i integer, t text[]) cascade;

drop table "public"."unwanted";

create table "public"."order_items" (
    "product_no" integer not null,
    "order_id" integer not null,
    "quantity" integer
);


CREATE UNIQUE INDEX order_items_pkey ON order_items USING btree (product_no, order_id);

alter table "public"."order_items" add constraint "order_items_pkey" PRIMARY KEY using index "order_items_pkey";

alter table "public"."order_items" add constraint "order_items_product_no_fkey" FOREIGN KEY (product_no) REFERENCES products(product_no) ON DELETE RESTRICT;

alter table "public"."order_items" add constraint "order_items_order_id_fkey" FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE;

alter table "public"."products" drop column "oldcolumn";

alter table "public"."products" add column "newcolumn" text;

alter table "public"."products" add column "newcolumn2" interval;

alter table "public"."products" alter column "name" drop not null;

alter table "public"."products" alter column "name" set data type text;

alter table "public"."products" alter column "price" set not null;

alter table "public"."products" alter column "price" set default 100;

alter table "public"."products" alter column "x" drop not null;

alter table "public"."products" alter column "x" drop default;

alter table "public"."products" drop constraint "products_name_key";

alter table "public"."products" add constraint "y" CHECK ((price > (0)::numeric));

alter table "public"."products" drop constraint "x";

alter table "public"."products" add constraint "x" CHECK ((price > (10)::numeric));

drop index if exists "public"."products_name_key";

drop index if exists "public"."products_price_idx";

CREATE INDEX products_name_idx ON products USING btree (name);

create extension "hstore" with schema "public" version '1.3';

create extension "postgis" with schema "public" version '2.2.1';

create view "public"."vvv" as  SELECT 2;


create or replace function "public"."newfunc"(i integer, t text[])
returns TABLE(a text, c integer) as
$$
 declare
        BEGIN
                select 'no', 1;
        END;

$$
language PLPGSQL STABLE RETURNS NULL ON NULL INPUT SECURITY INVOKER;

create or replace function "public"."changed"(i integer, t text[])
returns TABLE(a text, c integer) as
$$
 declare
        BEGIN
                select 'no', 1;
        END;

$$
language PLPGSQL VOLATILE RETURNS NULL ON NULL INPUT SECURITY DEFINER;

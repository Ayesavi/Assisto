create extension if not exists "wrappers" with schema "extensions";


drop trigger if exists "notify when bids created" on "public"."bidding";

drop trigger if exists "notify on new message" on "public"."messages";

drop trigger if exists "notify update task status" on "public"."tasks";

drop trigger if exists "recommend users" on "public"."tasks";

drop trigger if exists "update_tasks_updated_at" on "public"."tasks";

drop policy "delete to owners only" on "public"."addresses";

drop policy "Only task users can assigned user can select" on "public"."messages";

drop policy "Only Owner can delete" on "public"."tasks";

drop policy "Only owner can update or delete non blocking tasks." on "public"."tasks";

drop policy "Read to authenticated Users" on "public"."tasks";

drop policy "update to owners only" on "public"."addresses";

drop policy "read to task owners and bid owners" on "public"."bidding";

revoke delete on table "public"."notifications" from "anon";

revoke insert on table "public"."notifications" from "anon";

revoke references on table "public"."notifications" from "anon";

revoke select on table "public"."notifications" from "anon";

revoke trigger on table "public"."notifications" from "anon";

revoke truncate on table "public"."notifications" from "anon";

revoke update on table "public"."notifications" from "anon";

revoke delete on table "public"."notifications" from "authenticated";

revoke insert on table "public"."notifications" from "authenticated";

revoke references on table "public"."notifications" from "authenticated";

revoke select on table "public"."notifications" from "authenticated";

revoke trigger on table "public"."notifications" from "authenticated";

revoke truncate on table "public"."notifications" from "authenticated";

revoke update on table "public"."notifications" from "authenticated";

revoke delete on table "public"."notifications" from "service_role";

revoke insert on table "public"."notifications" from "service_role";

revoke references on table "public"."notifications" from "service_role";

revoke select on table "public"."notifications" from "service_role";

revoke trigger on table "public"."notifications" from "service_role";

revoke truncate on table "public"."notifications" from "service_role";

revoke update on table "public"."notifications" from "service_role";

revoke delete on table "public"."user_payment_details" from "anon";

revoke insert on table "public"."user_payment_details" from "anon";

revoke references on table "public"."user_payment_details" from "anon";

revoke select on table "public"."user_payment_details" from "anon";

revoke trigger on table "public"."user_payment_details" from "anon";

revoke truncate on table "public"."user_payment_details" from "anon";

revoke update on table "public"."user_payment_details" from "anon";

revoke delete on table "public"."user_payment_details" from "authenticated";

revoke insert on table "public"."user_payment_details" from "authenticated";

revoke references on table "public"."user_payment_details" from "authenticated";

revoke select on table "public"."user_payment_details" from "authenticated";

revoke trigger on table "public"."user_payment_details" from "authenticated";

revoke truncate on table "public"."user_payment_details" from "authenticated";

revoke update on table "public"."user_payment_details" from "authenticated";

revoke delete on table "public"."user_payment_details" from "service_role";

revoke insert on table "public"."user_payment_details" from "service_role";

revoke references on table "public"."user_payment_details" from "service_role";

revoke select on table "public"."user_payment_details" from "service_role";

revoke trigger on table "public"."user_payment_details" from "service_role";

revoke truncate on table "public"."user_payment_details" from "service_role";

revoke update on table "public"."user_payment_details" from "service_role";

alter table "public"."addresses" drop constraint "public_addresses_ownerId_fkey";

alter table "public"."tasks" drop constraint "public_tasks_addressId_fkey";

alter table "public"."tasks" drop constraint "public_tasks_ownerId_fkey";

alter table "public"."user_payment_details" drop constraint "user_payment_details_id_fkey";

alter table "public"."messages" drop constraint "messages_room_id_fkey";

alter table "public"."tasks" drop constraint "tasks_bid_id_fkey";

drop function if exists "public"."get_feed_tasks_without_location"(user_tags text[], user_age integer, user_gender gender_enum);

alter table "public"."notifications" drop constraint "notifications_pkey";

alter table "public"."user_payment_details" drop constraint "user_payment_details_pkey";

drop index if exists "public"."notifications_pkey";

drop index if exists "public"."user_payment_details_pkey";

drop table "public"."notifications";

drop table "public"."user_payment_details";

alter table "public"."addresses" alter column "geo" set data type geography using "geo"::geography;

alter table "public"."profiles" alter column "gender" drop default;

alter table "public"."profiles" alter column "id" drop default;

alter table "public"."profiles" alter column "status" set default 'active'::account_status;

alter table "public"."profiles" alter column "status" set not null;

alter table "public"."profiles" alter column "tags" drop not null;

alter table "public"."user_payments" add column "task_id" bigint;

alter table "public"."user_payments" add column "tesst" smallint;

alter table "public"."addresses" add constraint "public_addresses_ownerid_fkey" FOREIGN KEY (owner_id) REFERENCES profiles(id) ON UPDATE CASCADE ON DELETE SET NULL not valid;

alter table "public"."addresses" validate constraint "public_addresses_ownerid_fkey";

alter table "public"."tasks" add constraint "public_tasks_addressid_fkey" FOREIGN KEY (address_id) REFERENCES addresses(id) not valid;

alter table "public"."tasks" validate constraint "public_tasks_addressid_fkey";

alter table "public"."tasks" add constraint "public_tasks_ownerid_fkey" FOREIGN KEY (owner_id) REFERENCES profiles(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."tasks" validate constraint "public_tasks_ownerid_fkey";

alter table "public"."user_payments" add constraint "user_payments_task_id_fkey" FOREIGN KEY (task_id) REFERENCES tasks(id) ON UPDATE CASCADE ON DELETE SET NULL not valid;

alter table "public"."user_payments" validate constraint "user_payments_task_id_fkey";

alter table "public"."messages" add constraint "messages_room_id_fkey" FOREIGN KEY (room_id) REFERENCES tasks(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."messages" validate constraint "messages_room_id_fkey";

alter table "public"."tasks" add constraint "tasks_bid_id_fkey" FOREIGN KEY (bid_id) REFERENCES bidding(id) ON UPDATE CASCADE ON DELETE RESTRICT not valid;

alter table "public"."tasks" validate constraint "tasks_bid_id_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.get_messages(params jsonb)
 RETURNS TABLE(message jsonb, author jsonb, task jsonb, room_id uuid)
 LANGUAGE plpgsql
AS $function$
DECLARE
  _offset INT;
  _limit INT;
BEGIN
  -- Extract offset and limit from the JSONB parameter
  _offset := COALESCE((params ->> 'offset')::INT, 0);
  _limit := COALESCE((params ->> 'limit')::INT, 10);

  RETURN QUERY 
    SELECT DISTINCT ON (messages.room_id)
      jsonb_build_object('content', messages.text, 'created_at', messages.created_at) AS message,
      CASE 
        WHEN tasks.owner_id = auth.uid() THEN jsonb_build_object('name', p.full_name, 'avatar_url', p.avatar_url)
        ELSE jsonb_build_object('name', bp.full_name, 'avatar_url', bp.avatar_url)
      END AS author,
      jsonb_build_object('name', tasks.name, 'id', tasks.id) AS task,
      messages.room_id AS room_id
    FROM 
      messages 
    LEFT JOIN tasks ON tasks.id = messages.room_id
    LEFT JOIN bidding b ON b.id = tasks.bid_id
    LEFT JOIN profiles p ON p.id = tasks.owner_id
    LEFT JOIN profiles bp ON bp.id = b.bidder_id
    ORDER BY messages.room_id
    OFFSET _offset LIMIT _limit;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.get_person_age(dob timestamp with time zone)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
DECLARE
    person_age INT;
BEGIN
    -- Calculate the age in years
    person_age := DATE_PART('year', AGE(NOW(), dob));
    RETURN person_age;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.get_recipient_id(task_id bigint, author_uid uuid)
 RETURNS uuid
 LANGUAGE plpgsql
AS $function$
DECLARE 
  user_uid uuid;
  bid_uid bigint;
BEGIN
  -- Check if the task has a bid by the author
  IF EXISTS (SELECT 1 FROM tasks WHERE id = task_id AND owner_id = author_uid) THEN
    -- Get the bid_id associated with the task
    SELECT bid_id INTO bid_uid FROM tasks WHERE id = task_id AND owner_id = author_uid;
    
    -- Get the bidder_id from the bidding table
    SELECT bidder_id INTO user_uid FROM bidding WHERE id = bid_uid;
  ELSE
    -- If no bid exists, get the owner_id from tasks
    SELECT owner_id INTO user_uid FROM tasks WHERE id = task_id;
  END IF;

  -- Return the found user_uid
  RETURN user_uid;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.get_user_emails(user_ids uuid[])
 RETURNS TABLE(user_id uuid, email text)
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
    -- Check if the current user role is 'service_role'
    IF auth.role() = 'service_role' THEN
        -- Return a table with the user IDs and emails
        RETURN QUERY
        SELECT u.id, u.email
        FROM auth.users u
        WHERE u.id = ANY(user_ids);
    ELSE
        -- Raise an exception if the role is not 'service_role'
        RAISE EXCEPTION 'Permission denied. This function can only be executed by service_role.';
    END IF;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.accept_bid(task_bid_id bigint)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    task_uid bigint;
BEGIN
     UPDATE tasks 
    SET 
        bid_id = task_bid_id,
        status = 'assigned' 
    WHERE 
        id = (SELECT task_id FROM bidding WHERE id = task_bid_id);


    perform delete_other_bids(task_bid_id);


END;
$function$
;

CREATE OR REPLACE FUNCTION public.check_duplicate_bid(task_uid bigint)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
DECLARE
    bid_exists BOOLEAN;
BEGIN
    SELECT EXISTS (
        SELECT 1
        FROM bidding
        WHERE task_id = task_uid AND bidder_id = auth.uid()
    ) INTO bid_exists;

    IF bid_exists THEN
       bid_exists:=true;
    END IF;

    RETURN bid_exists;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.get_feed_tasks(data jsonb)
 RETURNS TABLE(id bigint, title character varying, tags character varying[], description character varying, distance double precision, owner jsonb, deadline timestamp with time zone)
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE
    user_tags varchar[];
    user_age int;
    user_age_date DATE;
    user_gender gender_enum;
    center_lat double precision;
    center_lng double precision;
    user_id uuid := auth.uid(); -- Initialize and assign the user_id variable
    page_offset int;
    page_limit int;
BEGIN
    -- Extract values from the data JSONB parameter
    center_lat := (data ->> 'center_lat')::double precision;
    center_lng := (data ->> 'center_lng')::double precision;
    page_offset := COALESCE((data ->> 'offset')::int, 0);
    page_limit := COALESCE((data ->> 'limit')::int, 30); -- Default limit is 10 if not specified

    -- Query to select tags, age, and gender for the user
    SELECT profiles.tags, profiles.dob, profiles.gender INTO user_tags, user_age_date, user_gender 
    FROM profiles 
    WHERE profiles.id = user_id;

    SELECT EXTRACT(YEAR FROM age(user_age_date)) INTO user_age;

    RETURN QUERY
    SELECT
        tasks.id,
        tasks.title,
        tasks.tags,
        tasks.description,
        CASE 
            WHEN tasks.address_id IS NULL THEN NULL
            ELSE ST_Distance(ST_MakePoint(center_lng, center_lat)::geography, addresses.geo::geography) / 1000 
        END as distance, -- Calculate distance in kilometers if address is not null
        jsonb_build_object('id', profiles.id, 'avatar_url', profiles.avatar_url) as owner, -- Constructing JSONB object for owner
        tasks.deadline
    FROM
        tasks
    LEFT JOIN
        addresses ON tasks.address_id = addresses.id -- Joining tasks with addresses to get geo information
    JOIN
        profiles ON tasks.owner_id = profiles.id -- Joining tasks with profiles to get owner information
    WHERE
        (tasks.address_id IS NULL OR ST_DWithin(ST_MakePoint(center_lng, center_lat)::geography, addresses.geo::geography, 50000)) 
        AND (user_gender = tasks.gender OR tasks.gender = 'any') 
        AND tasks.status = 'unassigned'
        AND (
            tasks.age_group IS NULL OR
            (user_age BETWEEN CAST(SPLIT_PART(tasks.age_group, '-', 1) AS INTEGER) 
                          AND CAST(SPLIT_PART(tasks.age_group, '-', 2) AS INTEGER))
        ) AND tasks.owner_id <> user_id AND( check_duplicate_bid(tasks.id)<>true )
    ORDER BY
        CASE
            WHEN EXISTS (
                SELECT 1
                FROM unnest(tasks.tags) AS tag
                WHERE tag = ANY (user_tags)
            ) THEN 0 -- prioritize records with matching tags
            WHEN tasks.title ILIKE ANY (ARRAY(SELECT '%' || tag || '%' FROM unnest(user_tags) AS tag)) THEN 1 -- prioritize records with matching tags in title
            WHEN tasks.description ILIKE ANY (ARRAY(SELECT '%' || tag || '%' FROM unnest(user_tags) AS tag)) THEN 2 -- prioritize records with matching tags in description
            ELSE 3 -- prioritize other records
        END,
        tasks.created_at desc,
        distance, -- order by distance
        tasks.title -- order by title
        LIMIT page_limit offset page_offset
    ;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.get_message_rooms(params jsonb)
 RETURNS TABLE(message jsonb, author jsonb, task jsonb, chat_id bigint)
 LANGUAGE plpgsql
AS $function$
DECLARE
  _offset INT;
  _limit INT;
  _search_key TEXT;
  _task_status task_status; 
BEGIN
  -- Extract offset, limit, search_key, and task_status from the JSONB parameter
  _offset := COALESCE((params ->> 'offset')::INT, 0);
  _limit := COALESCE((params ->> 'limit')::INT, 10);
  _search_key := COALESCE(params ->> 'search_key', '');
  _task_status := COALESCE((params ->> 'task_status')::task_status, NULL);

  RETURN QUERY 
    WITH latest_messages AS (
      SELECT DISTINCT ON (messages.room_id)
        room_id,
        text,
        created_at,
        id AS message_id
      FROM messages
      ORDER BY room_id, created_at DESC
    )
    SELECT
      jsonb_build_object('text', lm.text, 'created_at', lm.created_at) AS message,
      CASE 
        WHEN tasks.owner_id <> auth.uid() THEN jsonb_build_object('name',  COALESCE( p.full_name, 'Deleted User')  , 'avatar_url', COALESCE( p.avatar_url, null))
        ELSE jsonb_build_object('name', COALESCE( bp.full_name, 'Deleted User'), 'avatar_url',COALESCE( bp.avatar_url, null))
      END AS author,
      jsonb_build_object('name', tasks.title,  'status', tasks.status) AS task,
      lm.room_id AS room_id
    FROM 
      latest_messages lm
    LEFT JOIN tasks ON tasks.id = lm.room_id
    LEFT JOIN bidding b ON b.id = tasks.bid_id
    LEFT JOIN profiles p ON p.id = tasks.owner_id
    LEFT JOIN profiles bp ON bp.id = b.bidder_id
    WHERE 
      (tasks.title ILIKE '%' || _search_key || '%' OR
      (CASE 
         WHEN tasks.owner_id <> auth.uid() THEN p.full_name
         ELSE bp.full_name
       END) ILIKE '%' || _search_key || '%')
      AND (_task_status IS NULL OR tasks.status = _task_status)
    ORDER BY lm.created_at DESC
    OFFSET _offset LIMIT _limit;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.get_recommended_task_bidder_tokens(task_uid bigint)
 RETURNS TABLE(device_token text)
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE
    task_model RECORD;
    lat_lng jsonb;
    center_lat double precision;
    center_lng double precision;
BEGIN
    -- Fetch the task record into task_model
    SELECT * INTO task_model FROM tasks WHERE id = task_uid;

    IF task_model.address_id IS NOT NULL THEN
        SELECT latlng INTO lat_lng FROM addresses WHERE id = task_model.address_id;
        center_lat := (lat_lng->>'lat')::double precision;
        center_lng := (lat_lng->>'lng')::double precision;
    END IF; 

    RAISE LOG 'latlng: %', lat_lng;

    RETURN QUERY
    SELECT token 
    FROM public.devices
    LEFT JOIN profiles ON profiles.id = devices.user_id
    LEFT JOIN addresses ON devices.user_id = addresses.owner_id
    WHERE
        (task_model.address_id IS NULL OR 
         (lat_lng IS NOT NULL AND ST_DWithin(ST_MakePoint(center_lng, center_lat)::geography, addresses.geo::geography, 50000)
         )
        ) AND
        (task_model.age_group IS NULL OR
         (profiles.age BETWEEN 
             CAST(SPLIT_PART(task_model.age_group, '-', 1) AS INTEGER) AND 
             CAST(SPLIT_PART(task_model.age_group, '-', 2) AS INTEGER)
         )
        ) AND
        (task_model.gender IS NULL OR 
         task_model.gender = 'any' OR 
         profiles.gender = task_model.gender
        ) AND
        task_model.owner_id <> profiles.id AND profiles.tags && task_model.tags;

END;
$function$
;

CREATE OR REPLACE FUNCTION public.handle_new_user()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$BEGIN
  -- Check if NEW.raw_user_meta_data is not null and insert other fields
  IF NEW.raw_user_meta_data IS NOT NULL  THEN
    INSERT INTO public.profiles (id, full_name, avatar_url)
    VALUES (
      NEW.id,
      NEW.raw_user_meta_data->>'full_name',
      NEW.raw_user_meta_data->>'avatar_url'
    );
  ELSE
    -- Check if NEW.raw_user_meta_data is null and insert default values or NULL
    INSERT INTO public.profiles(id)
    VALUES (
      NEW.id
    );
  END IF;
  
  RETURN NEW;
END;$function$
;

CREATE OR REPLACE FUNCTION public.is_assigned_user(task_uid bigint)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
DECLARE
    user_uid UUID;
BEGIN
    -- Select the bidder_id directly
    SELECT b.bidder_id 
    INTO user_uid
    FROM tasks t
    LEFT JOIN bidding b ON t.bid_id = b.id
    WHERE t.id = task_uid;

    -- Check if user_uid is NULL and return FALSE if so
    IF user_uid IS NULL THEN
        RETURN FALSE;
    END IF;

    -- Return the value based on auth.uid() comparison
    RETURN auth.uid() = user_uid;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.on_user_deleted()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
  -- Delete related records in other tables
  DELETE FROM public.devices WHERE user_id = OLD.id;
  DELETE FROM public.reviews WHERE user_id = OLD.id;

  DELETE FROM public.tasks WHERE owner_id = OLD.id;

  -- Update the profiles table to anonymize the user information
  UPDATE public.profiles 
  SET 
    full_name = NULL,
    avatar_url = NULL,
    gender = NULL,
    tags = '{}',  -- Setting tags to an empty array
    status = 'deleted'
  WHERE id = OLD.id;

  RETURN OLD;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.process_deletion_requests()
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    rec uuid;
BEGIN
    FOR rec IN
        SELECT user_id FROM disabled_accounts 
        WHERE is_for_deletion = true AND DATE(banned_till) = CURRENT_DATE
    LOOP
        -- Make an HTTP POST request for each record
        PERFORM net.http_post(
            url := 'https://asia-south1-assisto-dev-52a1d.cloudfunctions.net/apiv1/user/delete?uid=' || rec
        );
    END LOOP;
END;
$function$
;

create policy "Delete to owners only"
on "public"."addresses"
as permissive
for delete
to authenticated
using ((auth.uid() = owner_id));


create policy "read to task owners and bid owners"
on "public"."messages"
as permissive
for select
to authenticated
using ((is_assigned_user(room_id) OR check_owner(room_id)));


create policy "only owner can delete"
on "public"."tasks"
as permissive
for delete
to public
using ((owner_id = auth.uid()));


create policy "only owner can update"
on "public"."tasks"
as permissive
for update
to authenticated
using ((owner_id = auth.uid()));


create policy "read to authenticated users"
on "public"."tasks"
as permissive
for select
to authenticated
using (true);


create policy "update to owners only"
on "public"."addresses"
as permissive
for update
to authenticated
using ((auth.uid() = owner_id));


create policy "read to task owners and bid owners"
on "public"."bidding"
as permissive
for select
to authenticated
using (((bidder_id = auth.uid()) OR check_owner(task_id)));


CREATE TRIGGER "test-update" AFTER INSERT OR UPDATE ON public.bidding FOR EACH ROW EXECUTE FUNCTION supabase_functions.http_request('https://webhook.site/cd12a9d9-0193-4813-bad9-d90da4a6f281', 'POST', '{"Content-type":"application/json"}', '{}', '1000');

CREATE TRIGGER "test-messages" AFTER INSERT OR UPDATE ON public.messages FOR EACH ROW EXECUTE FUNCTION supabase_functions.http_request('https://webhook.site/a009379f-196c-41fb-8ca5-92398ec47679', 'POST', '{"Content-type":"application/json"}', '{}', '1000');

CREATE TRIGGER "test-hook" AFTER UPDATE ON public.tasks FOR EACH ROW EXECUTE FUNCTION supabase_functions.http_request('https://webhook.site/756bf939-f26e-43fb-b5fe-e916a27c3523', 'POST', '{"Content-type":"application/json"}', '{"notify":"bidders"}', '1000');

CREATE TRIGGER "notify when bids created" AFTER INSERT ON public.bidding FOR EACH ROW EXECUTE FUNCTION supabase_functions.http_request('https://asia-south1-assisto-dev-52a1d.cloudfunctions.net/apiv1/notify/bid', 'POST', '{"Content-type":"application/json"}', '{}', '1000');

CREATE TRIGGER "notify on new message" AFTER INSERT ON public.messages FOR EACH ROW EXECUTE FUNCTION supabase_functions.http_request('https://asia-south1-assisto-dev-52a1d.cloudfunctions.net/apiv1/notify/chat', 'POST', '{"Content-type":"application/json"}', '{}', '1000');

CREATE TRIGGER "notify update task status" AFTER UPDATE ON public.tasks FOR EACH ROW EXECUTE FUNCTION supabase_functions.http_request('https://asia-south1-assisto-dev-52a1d.cloudfunctions.net/apiv1/notify/tasks/update', 'POST', '{"Content-type":"application/json"}', '{}', '1000');

CREATE TRIGGER "recommend users" AFTER INSERT OR UPDATE ON public.tasks FOR EACH ROW EXECUTE FUNCTION supabase_functions.http_request('https://asia-south1-assisto-dev-52a1d.cloudfunctions.net/apiv1/notify/tasks/recommendation', 'POST', '{"Content-type":"application/json"}', '{}', '1000');

CREATE TRIGGER update_tasks_updated_at AFTER UPDATE ON public.tasks FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();





SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


CREATE EXTENSION IF NOT EXISTS "pg_cron" WITH SCHEMA "pg_catalog";






COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_net" WITH SCHEMA "public";






CREATE EXTENSION IF NOT EXISTS "pgsodium" WITH SCHEMA "pgsodium";






CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgjwt" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "postgis" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE TYPE "public"."account_status" AS ENUM (
    'deleted',
    'active'
);


ALTER TYPE "public"."account_status" OWNER TO "postgres";


CREATE TYPE "public"."gender_enum" AS ENUM (
    'male',
    'female',
    'others',
    'any'
);


ALTER TYPE "public"."gender_enum" OWNER TO "postgres";


CREATE TYPE "public"."message_type" AS ENUM (
    'text',
    'payment'
);


ALTER TYPE "public"."message_type" OWNER TO "postgres";


COMMENT ON TYPE "public"."message_type" IS 'For storing messages';



CREATE TYPE "public"."payment_status" AS ENUM (
    'pending',
    'success',
    'failed'
);


ALTER TYPE "public"."payment_status" OWNER TO "postgres";


CREATE TYPE "public"."task_status" AS ENUM (
    'assigned',
    'unassigned',
    'paid',
    'completed',
    'blocked'
);


ALTER TYPE "public"."task_status" OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."accept_bid"("task_bid_id" bigint) RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
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
$$;


ALTER FUNCTION "public"."accept_bid"("task_bid_id" bigint) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."check_duplicate_bid"("task_uid" bigint) RETURNS boolean
    LANGUAGE "plpgsql"
    AS $$DECLARE
    bid_exists BOOLEAN;
BEGIN
    SELECT EXISTS (
        SELECT 1
        FROM bidding
        WHERE task_id = task_uid AND bidder_id = auth.uid()
    ) INTO bid_exists;

    IF bid_exists THEN
        bid_exists:= true;
    END IF;

    RETURN bid_exists;
END;$$;


ALTER FUNCTION "public"."check_duplicate_bid"("task_uid" bigint) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."check_owner"("task_int" bigint) RETURNS boolean
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    owner_uid uuid;
BEGIN
    -- Fetch ownerId from tasks table where id = task_id
    SELECT tasks.owner_id INTO owner_uid
    FROM public.tasks
    WHERE tasks.id = task_int;

    -- Check if owner_uid matches auth_uid
    IF owner_uid = auth.uid() THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$;


ALTER FUNCTION "public"."check_owner"("task_int" bigint) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."delete_other_bids"("bid_uid" bigint) RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE
    task_uid BIGINT;
BEGIN
    -- Select task_id into task_uid from the bidding table where id matches bid_uid
    SELECT task_id INTO task_uid FROM bidding WHERE id = bid_uid;

    -- Delete from the bidding table where task_id matches task_uid and id does not match bid_uid
    DELETE FROM bidding WHERE task_id = task_uid AND id <> bid_uid;
END;
$$;


ALTER FUNCTION "public"."delete_other_bids"("bid_uid" bigint) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_disabled_account_reason"("user_email" character varying, "user_phone" character varying) RETURNS "jsonb"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE
  response RECORD;
BEGIN
  -- Fetch user ID and the corresponding disabled account record in one query
  SELECT 
    da.reason, 
    da.is_for_deletion
  INTO 
    response
  FROM 
    auth.users u
  LEFT JOIN 
    public.disabled_accounts da ON u.id = da.user_id
  WHERE 
    u.email = user_email OR u.phone = user_phone;

  -- Raise an exception if the user does not exist
  IF NOT FOUND THEN
    RAISE EXCEPTION 'User with the provided email or phone does not exist';
  END IF;

  -- Raise an exception if the disabled account record does not exist
  IF response.reason IS NULL THEN
    RAISE EXCEPTION 'No disabled account record found for the user';
  END IF;

  -- Return the response as a JSON object
  RETURN json_build_object(
    'reason', response.reason, 
    'is_for_deletion', response.is_for_deletion
  );
END;
$$;


ALTER FUNCTION "public"."get_disabled_account_reason"("user_email" character varying, "user_phone" character varying) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_feed_tasks"("data" "jsonb") RETURNS TABLE("id" bigint, "title" character varying, "tags" character varying[], "description" character varying, "distance" double precision, "owner" "jsonb", "deadline" timestamp with time zone)
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
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
$$;


ALTER FUNCTION "public"."get_feed_tasks"("data" "jsonb") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_feed_tasks_without_location"("user_tags" "text"[], "user_age" integer, "user_gender" "public"."gender_enum") RETURNS TABLE("id" bigint, "title" character varying, "tags" character varying[], "description" character varying, "owner" "jsonb", "deadline" timestamp with time zone)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        tasks.id,
        tasks.title,
        tasks.tags,
        tasks.description,
        jsonb_build_object('id', profiles.id, 'image_url', profiles.image_url) as owner, -- Constructing JSONB object for owner
        tasks.deadline
    FROM
        tasks
    JOIN
        addresses ON tasks.address_id = addresses.id -- Joining tasks with addresses to get geo information
    JOIN
        profiles ON tasks.owner_id = profiles.id -- Joining tasks with profiles to get owner information
    WHERE

         (user_gender = tasks.gender OR tasks.gender = 'any') 
        -- Corrected logical grouping of conditions
        AND ( 
            tasks.age_group IS NULL OR -- If age group is not specified, allow the task
            (user_age BETWEEN CAST(SPLIT_PART(tasks.age_group, '-', 1) AS INTEGER) 
                          AND CAST(SPLIT_PART(tasks.age_group, '-', 2) AS INTEGER))
        )
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
        tasks.title -- order by title
    ;
END;
$$;


ALTER FUNCTION "public"."get_feed_tasks_without_location"("user_tags" "text"[], "user_age" integer, "user_gender" "public"."gender_enum") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_message_rooms"("params" "jsonb") RETURNS TABLE("message" "jsonb", "author" "jsonb", "task" "jsonb", "chat_id" bigint)
    LANGUAGE "plpgsql"
    AS $$
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
        WHEN tasks.owner_id <> auth.uid() THEN jsonb_build_object('name', p.full_name, 'avatar_url', p.avatar_url)
        ELSE jsonb_build_object('name', bp.full_name, 'avatar_url', bp.avatar_url)
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
$$;


ALTER FUNCTION "public"."get_message_rooms"("params" "jsonb") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_recommended_task_bidder_profiles"("task_uid" bigint) RETURNS TABLE("profile_id" "uuid")
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE
    task_model RECORD;
    lat_lng jsonb;
    center_lat double precision;
    center_lng double precision;
BEGIN
    -- Fetch the task record into task_model
    SELECT * INTO task_model FROM tasks WHERE id = task_uid;

    -- Initialize center_lat and center_lng if address_id is not null
    IF task_model.address_id IS NOT NULL THEN
        SELECT latlng INTO lat_lng FROM addresses WHERE id = task_model.address_id;
        center_lat := (lat_lng->>'lat')::double precision;
        center_lng := (lat_lng->>'lng')::double precision;
    END IF; 

    RETURN QUERY
    SELECT p.id
    FROM profiles p
    LEFT JOIN addresses a ON p.id = a.owner_id
    WHERE
        (task_model.address_id IS NULL OR 
         (lat_lng IS NOT NULL AND ST_DWithin(ST_MakePoint(center_lng, center_lat)::geography, a.geo::geography, 50000))
        ) AND
        (task_model.age_group IS NULL OR
         (EXTRACT(YEAR FROM age(p.dob)) BETWEEN 
             CAST(SPLIT_PART(task_model.age_group, '-', 1) AS INTEGER) AND 
             CAST(SPLIT_PART(task_model.age_group, '-', 2) AS INTEGER)
         )
        ) AND
        (task_model.gender IS NULL OR 
         task_model.gender = 'any' OR 
         p.gender = task_model.gender
        ) AND
        task_model.owner_id <> p.id AND p.tags && task_model.tags;

END;
$$;


ALTER FUNCTION "public"."get_recommended_task_bidder_profiles"("task_uid" bigint) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_recommended_task_bidder_tokens"("task_uid" bigint) RETURNS TABLE("device_token" "text")
    LANGUAGE "plpgsql"
    AS $$
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
        center_lat:= lat_lng->>'lat';
        center_lng:= lat_lng->>'lng';
    END IF;

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
$$;


ALTER FUNCTION "public"."get_recommended_task_bidder_tokens"("task_uid" bigint) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_task_by_id"("task_uid" bigint) RETURNS TABLE("id" bigint, "title" character varying, "tags" character varying[], "description" character varying, "owner" "jsonb", "bid" "jsonb", "address" "jsonb", "expected_price" integer, "status" "public"."task_status", "age_group" character varying, "gender" "public"."gender_enum", "created_at" timestamp with time zone, "deadline" timestamp with time zone)
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
    RETURN QUERY 
    SELECT 
        tasks.id,
        tasks.title,
        tasks.tags,
        tasks.description,
        -- Join owner table for details
        jsonb_build_object('id', o.id, 'avatar_url', o.avatar_url) as owner,
        CASE 
            WHEN tasks.bid_id IS NULL THEN NULL
            ELSE jsonb_build_object('id',bidding.id, 'created_at', bidding.created_at, 'bidder',  jsonb_build_object('id', bf.id, 'avatar_url', bf.avatar_url, 'full_name',bf.full_name,'gender',bf.gender,'tags',ARRAY[]::jsonb[],'dob',bf.dob,'status',bf.status), 'amount', bidding.amount)
        END  as bid,
        CASE 
            WHEN tasks.address_id IS NULL THEN NULL
            ELSE jsonb_build_object('house_number', addresses.house_number, 'id', addresses.id, 'latlng', addresses.latlng, 'address', addresses.address) 
        END as address,
        tasks.expected_price,
        tasks.status,
        tasks.age_group,
        tasks.gender,
        tasks.created_at,
        tasks.deadline 
    FROM tasks 
    LEFT JOIN profiles o ON o.id = tasks.owner_id

    -- Similar joins for bidding and address (if separate tables exist)
    LEFT JOIN bidding ON bidding.id = tasks.bid_id
    LEFT JOIN profiles bf ON  bidding.bidder_id = bf.id
    LEFT JOIN addresses ON addresses.id = tasks.address_id

    WHERE tasks.id = task_uid;

END;
$$;


ALTER FUNCTION "public"."get_task_by_id"("task_uid" bigint) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_user_contact_info"("params" "jsonb") RETURNS "jsonb"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE
  taskid bigint;
  uid uuid;
  is_owner boolean;
  is_bidder boolean;
  _user record;
  result jsonb;
BEGIN
  -- Extract user ID and task ID from input JSON
  taskid := (params->>'task_uid')::bigint;
  uid := (params->>'uid')::uuid;

  -- Perform necessary checks
  SELECT check_owner(taskid) INTO is_owner;
  SELECT is_assigned_user(taskid) INTO is_bidder;

  -- Check if the user is active
  IF is_owner = true OR is_bidder = true THEN
    SELECT * INTO _user FROM auth.users WHERE id = uid;
    result := jsonb_build_object('status', 'success', 'phone', _user.phone);
  ELSE
    result := jsonb_build_object('status', 'error', 'message', 'User is not active','is_owner',is_owner,'is_bidder',is_bidder);
  END IF;

  RETURN result;
END;
$$;


ALTER FUNCTION "public"."get_user_contact_info"("params" "jsonb") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_new_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$BEGIN
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
END;$$;


ALTER FUNCTION "public"."handle_new_user"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_user_ban"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  -- Set the banned_until date to the duration specified in the NEW record
  UPDATE auth.users
  SET banned_until = NEW.banned_till
  WHERE id = NEW.user_id;

  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."handle_user_ban"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_user_unban"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  -- Reset the banned_until date when the record is deleted
  UPDATE auth.users
  SET banned_until = NULL
  WHERE id = OLD.user_id;

  RETURN OLD;
END;
$$;


ALTER FUNCTION "public"."handle_user_unban"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_amount_greater_than_bidding_amount"("taskid" bigint, "amount" integer) RETURNS boolean
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE
    selected_amt INT;
BEGIN
    -- Select the amount from the tasks table for the given task ID
    SELECT expected_price INTO selected_amt
    FROM tasks
    WHERE id = taskid;

    -- Check if the selected amount is null
    IF selected_amt IS NULL THEN
        RETURN FALSE;
    END IF;

    -- Check if the provided amount is less than the selected amount
    IF amount < selected_amt or amount = selected_amt THEN
        RETURN FALSE;
    ELSE
        -- Raise an exception if the amount is greater than or equal to the selected amount
        RAISE EXCEPTION 'The amount cannot be greater than the budget';
    END IF;
END;
$$;


ALTER FUNCTION "public"."is_amount_greater_than_bidding_amount"("taskid" bigint, "amount" integer) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_assigned_user"("task_uid" bigint) RETURNS boolean
    LANGUAGE "plpgsql"
    AS $$DECLARE
    bid_uid bigint; -- This can naturally hold NULL values
    user_uid uuid; -- Variable to hold the bidder_id from the bidding table
BEGIN
    -- Select the bid_id into bid_uid from the tasks table
    SELECT bid_id INTO bid_uid 
    FROM tasks 
    WHERE id = task_uid;

    -- Check if bid_uid is null
    IF bid_uid IS NULL THEN
        RETURN FALSE;
    END IF;

    -- Select the bidder_id into user_uid from the bidding table
    SELECT bidder_id INTO user_uid 
    FROM bidding 
    WHERE id = bid_uid;

    -- Check if user_uid is null
    IF user_uid IS NULL THEN
        RETURN FALSE;
    END IF;

    -- Return the value based on auth.uid() comparison
    RETURN auth.uid() = user_uid;
END$$;


ALTER FUNCTION "public"."is_assigned_user"("task_uid" bigint) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_token_exists"("device_token" "text") RETURNS boolean
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    token_exists BOOLEAN;
BEGIN
    SELECT EXISTS(
        SELECT 1 
        FROM devices 
        WHERE token = device_token AND user_id = auth.uid()
    ) INTO token_exists;
    
    RETURN token_exists;
END;
$$;


ALTER FUNCTION "public"."is_token_exists"("device_token" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."on_user_deleted"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$BEGIN
  -- Delete related records in other tables
  DELETE FROM public.devices WHERE user_id = OLD.id;
  DELETE FROM public.reviews WHERE user_id = OLD.id;

  DELETE FROM public.tasks WHERE owner_id = OLD.id;

  -- Update the profiles table to anonymize the user information
  UPDATE public.profiles 
  SET 
    full_name = NULL,
    avatar_url = NULL,
    dob = NULL,
    gender = NULL,
    tags = '{}',  -- Setting tags to an empty array
    status = 'deleted'
  WHERE id = OLD.id;

  RETURN OLD;
END;$$;


ALTER FUNCTION "public"."on_user_deleted"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."on_user_deleted_post"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  -- Delete related records in the disabled_accounts table
  DELETE FROM public.disabled_accounts WHERE user_id = OLD.id;

  RETURN OLD;
END;
$$;


ALTER FUNCTION "public"."on_user_deleted_post"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."process_deletion_requests"() RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    rec uuid;
BEGIN
    FOR rec IN
        SELECT user_id FROM disabled_accounts WHERE is_for_deletion = true
    LOOP
        -- Make an HTTP POST request for each record
        perform net.http_post(
            url := 'https://asia-south1-assisto-dev-52a1d.cloudfunctions.net/apiv1/user/delete?uid='||rec
        );

    END LOOP;
END;
$$;


ALTER FUNCTION "public"."process_deletion_requests"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."reactivate_user"("user_email" character varying, "user_phone" character varying) RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  -- Delete the record from disabled_accounts table
  DELETE FROM public.disabled_accounts
  WHERE user_id = (
    SELECT u.id
    FROM auth.users u
    WHERE u.email = user_email OR u.phone = user_phone
    LIMIT 1
  ) AND is_for_deletion = true;

  -- Raise an exception if no rows were deleted
  IF NOT FOUND THEN
    RAISE EXCEPTION 'No disabled account record found for the user';
  END IF;
END;
$$;


ALTER FUNCTION "public"."reactivate_user"("user_email" character varying, "user_phone" character varying) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."remove_stale_tokens"() RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
    DELETE FROM public.devices 
    WHERE public.devices.created_at < NOW() - INTERVAL '2 months';
END;
$$;


ALTER FUNCTION "public"."remove_stale_tokens"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."search_tasks"("data" "jsonb") RETURNS TABLE("id" bigint, "title" character varying, "tags" character varying[], "description" character varying, "distance" double precision, "owner" "jsonb", "deadline" timestamp with time zone)
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE
    user_tags varchar[];
    user_age int;
    user_age_date DATE;
    user_gender gender_enum;
    center_lat double precision;
    center_lng double precision;
    search_key varchar;
    user_id uuid := auth.uid(); -- Initialize and assign the user_id variable
    page_offset int;
    page_limit int;
BEGIN
    -- Extract values from the data JSONB parameter
    center_lat := (data ->> 'center_lat')::double precision;
    center_lng := (data ->> 'center_lng')::double precision;
    search_key := (data ->> 'search_key')::varchar;
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
        ) 
        AND tasks.owner_id <> user_id 
        AND check_duplicate_bid(tasks.id) <> true 
        AND (
            tasks.title ILIKE '%' || search_key || '%'
            OR tasks.description ILIKE '%' || search_key || '%'
            OR EXISTS (
                SELECT 1
                FROM unnest(tasks.tags) AS tag
                WHERE tag ILIKE '%' || search_key || '%'
            )
        )
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
        tasks.created_at DESC,
        distance, -- order by distance
        tasks.title -- order by title
    LIMIT page_limit OFFSET page_offset;
END;
$$;


ALTER FUNCTION "public"."search_tasks"("data" "jsonb") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_avatar_if_exists"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE 
  is_existing boolean;
BEGIN
  -- Check if the bucket_id is 'avatars'
  IF NEW.bucket_id = 'avatars' THEN
    -- Check if a resource with the same filename already exists in the bucket
    SELECT exists (
      SELECT 1 FROM storage.objects 
      WHERE bucket_id = 'avatars' AND name = NEW.name
    ) INTO is_existing;
    
    IF is_existing THEN
      -- Delete the existing resource
      DELETE FROM storage.objects 
      WHERE bucket_id = NEW.bucket_id AND name = NEW.name;
    END IF;
  END IF;
  
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."update_avatar_if_exists"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_profile"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  IF NEW.raw_user_meta_data IS NOT NULL THEN
    UPDATE public.profiles
    SET full_name = NEW.raw_user_meta_data->>'full_name',
        avatar_url = NEW.raw_user_meta_data->>'avatar_url',
        tags = array(
          SELECT jsonb_array_elements_text(NEW.raw_user_meta_data->'tags')
        ), 
        gender = cast(NEW.raw_user_meta_data->>'gender' AS public.gender_enum)
    WHERE id = NEW.id;
  ELSE
    RETURN NEW;
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."update_profile"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_updated_at_column"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."update_updated_at_column"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."addresses" (
    "id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "owner_id" "uuid" DEFAULT "auth"."uid"(),
    "address" character varying NOT NULL,
    "house_number" character varying NOT NULL,
    "landmark" character varying,
    "latlng" "jsonb" NOT NULL,
    "geo" "extensions"."geography"(Point,4326) NOT NULL,
    "label" character varying NOT NULL
);


ALTER TABLE "public"."addresses" OWNER TO "postgres";


COMMENT ON COLUMN "public"."addresses"."latlng" IS 'For storing lat lng';



COMMENT ON COLUMN "public"."addresses"."label" IS 'For storing labels for addresses';



ALTER TABLE "public"."addresses" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."addresses_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."bidding" (
    "id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "bidder_id" "uuid" DEFAULT "auth"."uid"() NOT NULL,
    "task_id" bigint NOT NULL,
    "amount" smallint NOT NULL,
    "description" character varying
);


ALTER TABLE "public"."bidding" OWNER TO "postgres";


ALTER TABLE "public"."bidding" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."bidding_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."devices" (
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "token" "text" NOT NULL,
    "user_id" "uuid" DEFAULT "auth"."uid"() NOT NULL,
    "id" bigint NOT NULL
);


ALTER TABLE "public"."devices" OWNER TO "postgres";


ALTER TABLE "public"."devices" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."devices_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."disabled_accounts" (
    "user_id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "disabled_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "reason" character varying NOT NULL,
    "is_for_deletion" boolean DEFAULT false NOT NULL,
    "banned_till" timestamp with time zone NOT NULL
);


ALTER TABLE "public"."disabled_accounts" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."messages" (
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "type" "public"."message_type" NOT NULL,
    "room_id" bigint NOT NULL,
    "author_id" "uuid" NOT NULL,
    "id" "uuid" NOT NULL,
    "replied_message_id" "uuid",
    "text" "text"
);


ALTER TABLE "public"."messages" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."notifications" (
    "id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "recipient_id" "uuid" NOT NULL,
    "channel_id" character varying,
    "content" "text",
    "is_read" boolean
);


ALTER TABLE "public"."notifications" OWNER TO "postgres";


ALTER TABLE "public"."notifications" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."notifications_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."profiles" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "full_name" character varying DEFAULT '''  ''::character varying'::character varying,
    "avatar_url" character varying,
    "gender" "public"."gender_enum" DEFAULT 'female'::"public"."gender_enum",
    "tags" character varying[] DEFAULT '{}'::character varying[] NOT NULL,
    "status" "public"."account_status",
    "dob" "date"
);


ALTER TABLE "public"."profiles" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."reviews" (
    "id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "content" character varying,
    "rating" real NOT NULL
);


ALTER TABLE "public"."reviews" OWNER TO "postgres";


ALTER TABLE "public"."reviews" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."reviews_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."tasks" (
    "id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "owner_id" "uuid" DEFAULT "auth"."uid"() NOT NULL,
    "tags" character varying[] DEFAULT '{}'::character varying[] NOT NULL,
    "deadline" timestamp with time zone,
    "title" character varying NOT NULL,
    "description" character varying NOT NULL,
    "gender" "public"."gender_enum" DEFAULT 'any'::"public"."gender_enum" NOT NULL,
    "expected_price" integer,
    "status" "public"."task_status" DEFAULT 'unassigned'::"public"."task_status" NOT NULL,
    "address_id" bigint,
    "age_group" character varying(5),
    "bid_id" bigint,
    "updated_at" timestamp with time zone
);


ALTER TABLE "public"."tasks" OWNER TO "postgres";


COMMENT ON TABLE "public"."tasks" IS 'For storing tasks';



COMMENT ON COLUMN "public"."tasks"."address_id" IS 'For storing addresses';



ALTER TABLE "public"."tasks" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."tasks_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."user_payment_details" (
    "id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "upi_id" character varying NOT NULL
);


ALTER TABLE "public"."user_payment_details" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_payments" (
    "id" character varying NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "to_user_id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "from_user_id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "amt" smallint NOT NULL,
    "status" "public"."payment_status"
);


ALTER TABLE "public"."user_payments" OWNER TO "postgres";


ALTER TABLE ONLY "public"."addresses"
    ADD CONSTRAINT "addresses_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."bidding"
    ADD CONSTRAINT "bidding_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."devices"
    ADD CONSTRAINT "devices_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."disabled_accounts"
    ADD CONSTRAINT "disabled_accounts_pkey" PRIMARY KEY ("user_id");



ALTER TABLE ONLY "public"."messages"
    ADD CONSTRAINT "messages_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."notifications"
    ADD CONSTRAINT "notifications_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."reviews"
    ADD CONSTRAINT "reviews_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."tasks"
    ADD CONSTRAINT "tasks_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_payment_details"
    ADD CONSTRAINT "user_payment_details_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_payments"
    ADD CONSTRAINT "user_payments_pkey" PRIMARY KEY ("id");



CREATE OR REPLACE TRIGGER "after_delete_disabled_users" AFTER DELETE ON "public"."disabled_accounts" FOR EACH ROW EXECUTE FUNCTION "public"."handle_user_unban"();



CREATE OR REPLACE TRIGGER "after_insert_disabled_users" AFTER INSERT ON "public"."disabled_accounts" FOR EACH ROW EXECUTE FUNCTION "public"."handle_user_ban"();



CREATE OR REPLACE TRIGGER "notify on new message" AFTER INSERT ON "public"."messages" FOR EACH ROW EXECUTE FUNCTION "supabase_functions"."http_request"('https://asia-south1-dev-assisto.cloudfunctions.net/apiv1/notify/chat', 'POST', '{"Content-type":"application/json"}', '{}', '1000');



CREATE OR REPLACE TRIGGER "notify update task status" AFTER UPDATE ON "public"."tasks" FOR EACH ROW EXECUTE FUNCTION "supabase_functions"."http_request"('https://asia-south1-dev-assisto.cloudfunctions.net/apiv1/notify/tasks/update', 'POST', '{"Content-type":"application/json"}', '{}', '1000');



CREATE OR REPLACE TRIGGER "notify when bids created" AFTER INSERT ON "public"."bidding" FOR EACH ROW EXECUTE FUNCTION "supabase_functions"."http_request"('https://asia-south1-dev-assisto.cloudfunctions.net/apiv1/notify/bid', 'POST', '{"Content-type":"application/json"}', '{}', '1000');



CREATE OR REPLACE TRIGGER "recommend users" AFTER INSERT ON "public"."tasks" FOR EACH ROW EXECUTE FUNCTION "supabase_functions"."http_request"('https://asia-south1-dev-assisto.cloudfunctions.net/apiv1/notify/tasks/recommendation', 'POST', '{"Content-type":"application/json"}', '{}', '1000');



CREATE OR REPLACE TRIGGER "update_tasks_updated_at" BEFORE UPDATE ON "public"."tasks" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



ALTER TABLE ONLY "public"."devices"
    ADD CONSTRAINT "devices_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY "public"."disabled_accounts"
    ADD CONSTRAINT "disabled_accounts_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY "public"."messages"
    ADD CONSTRAINT "messages_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "public"."profiles"("id") ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY "public"."messages"
    ADD CONSTRAINT "messages_replied_message_id_fkey" FOREIGN KEY ("replied_message_id") REFERENCES "public"."messages"("id") ON UPDATE CASCADE ON DELETE SET NULL;



ALTER TABLE ONLY "public"."messages"
    ADD CONSTRAINT "messages_room_id_fkey" FOREIGN KEY ("room_id") REFERENCES "public"."tasks"("id") ON UPDATE CASCADE ON DELETE SET NULL;



ALTER TABLE ONLY "public"."addresses"
    ADD CONSTRAINT "public_addresses_ownerId_fkey" FOREIGN KEY ("owner_id") REFERENCES "public"."profiles"("id") ON UPDATE CASCADE ON DELETE SET NULL;



ALTER TABLE ONLY "public"."bidding"
    ADD CONSTRAINT "public_bidding_bidder_id_fkey" FOREIGN KEY ("bidder_id") REFERENCES "public"."profiles"("id") ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY "public"."bidding"
    ADD CONSTRAINT "public_bidding_task_id_fkey" FOREIGN KEY ("task_id") REFERENCES "public"."tasks"("id") ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY "public"."tasks"
    ADD CONSTRAINT "public_tasks_addressId_fkey" FOREIGN KEY ("address_id") REFERENCES "public"."addresses"("id");



ALTER TABLE ONLY "public"."tasks"
    ADD CONSTRAINT "public_tasks_ownerId_fkey" FOREIGN KEY ("owner_id") REFERENCES "public"."profiles"("id") ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY "public"."reviews"
    ADD CONSTRAINT "reviews_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY "public"."tasks"
    ADD CONSTRAINT "tasks_bid_id_fkey" FOREIGN KEY ("bid_id") REFERENCES "public"."bidding"("id") ON UPDATE CASCADE ON DELETE SET NULL;



ALTER TABLE ONLY "public"."user_payment_details"
    ADD CONSTRAINT "user_payment_details_id_fkey" FOREIGN KEY ("id") REFERENCES "public"."profiles"("id") ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_payments"
    ADD CONSTRAINT "user_payments_from_user_id_fkey" FOREIGN KEY ("from_user_id") REFERENCES "public"."profiles"("id") ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_payments"
    ADD CONSTRAINT "user_payments_to_user_id_fkey" FOREIGN KEY ("to_user_id") REFERENCES "public"."profiles"("id") ON UPDATE CASCADE ON DELETE CASCADE;



CREATE POLICY " Only authenticated can insert" ON "public"."tasks" FOR INSERT TO "authenticated" WITH CHECK (true);



CREATE POLICY "Authenticated and task belonging users can insert" ON "public"."messages" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_owner"("room_id") OR "public"."is_assigned_user"("room_id")));



CREATE POLICY "Create bid for autheticated tasks only" ON "public"."bidding" FOR INSERT TO "authenticated" WITH CHECK ((("public"."check_duplicate_bid"("task_id") = false) AND ("public"."is_amount_greater_than_bidding_amount"("task_id", ("amount")::integer) = false)));



CREATE POLICY "Insert only if duplicate tokens does not exist" ON "public"."devices" FOR INSERT TO "authenticated" WITH CHECK (("public"."is_token_exists"("token") <> true));



CREATE POLICY "Only Owner can delete" ON "public"."tasks" FOR DELETE USING (("owner_id" = "auth"."uid"()));



CREATE POLICY "Only owner can update or delete non blocking tasks." ON "public"."tasks" FOR UPDATE TO "authenticated" USING (("owner_id" = "auth"."uid"()));



CREATE POLICY "Only task users can assigned user can select" ON "public"."messages" FOR SELECT TO "authenticated" USING (("public"."is_assigned_user"("room_id") OR "public"."check_owner"("room_id")));



CREATE POLICY "Read to authenticated Users" ON "public"."tasks" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Users can delete only their tokens" ON "public"."devices" FOR DELETE TO "authenticated" USING (("auth"."uid"() = "user_id"));



ALTER TABLE "public"."addresses" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "all authenticated users can read" ON "public"."profiles" FOR SELECT TO "authenticated" USING (true);



ALTER TABLE "public"."bidding" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "delete to owners only" ON "public"."addresses" FOR DELETE USING (("auth"."uid"() = "owner_id"));



ALTER TABLE "public"."devices" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."disabled_accounts" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "insert to authenticated only" ON "public"."addresses" FOR INSERT TO "authenticated" WITH CHECK (true);



ALTER TABLE "public"."messages" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."notifications" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."profiles" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "read access to owners only" ON "public"."addresses" FOR SELECT TO "authenticated" USING (("auth"."uid"() = "owner_id"));



CREATE POLICY "read only to transaction associated users." ON "public"."user_payments" FOR SELECT TO "authenticated" USING ((("to_user_id" = "auth"."uid"()) OR ("from_user_id" = "auth"."uid"())));



CREATE POLICY "read to task owners and bid owners" ON "public"."bidding" FOR SELECT USING ((("bidder_id" = "auth"."uid"()) OR "public"."check_owner"("task_id")));



ALTER TABLE "public"."reviews" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."tasks" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "update to owners only" ON "public"."addresses" FOR UPDATE USING (("owner_id" = "auth"."uid"()));



CREATE POLICY "user itself only" ON "public"."devices" FOR SELECT TO "authenticated" USING (("auth"."uid"() = "user_id"));



ALTER TABLE "public"."user_payments" ENABLE ROW LEVEL SECURITY;




ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";


ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."messages";



SET SESSION AUTHORIZATION "postgres";
RESET SESSION AUTHORIZATION;



GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";


























































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































GRANT ALL ON FUNCTION "public"."accept_bid"("task_bid_id" bigint) TO "anon";
GRANT ALL ON FUNCTION "public"."accept_bid"("task_bid_id" bigint) TO "authenticated";
GRANT ALL ON FUNCTION "public"."accept_bid"("task_bid_id" bigint) TO "service_role";



GRANT ALL ON FUNCTION "public"."check_duplicate_bid"("task_uid" bigint) TO "anon";
GRANT ALL ON FUNCTION "public"."check_duplicate_bid"("task_uid" bigint) TO "authenticated";
GRANT ALL ON FUNCTION "public"."check_duplicate_bid"("task_uid" bigint) TO "service_role";



GRANT ALL ON FUNCTION "public"."check_owner"("task_int" bigint) TO "anon";
GRANT ALL ON FUNCTION "public"."check_owner"("task_int" bigint) TO "authenticated";
GRANT ALL ON FUNCTION "public"."check_owner"("task_int" bigint) TO "service_role";



GRANT ALL ON FUNCTION "public"."delete_other_bids"("bid_uid" bigint) TO "anon";
GRANT ALL ON FUNCTION "public"."delete_other_bids"("bid_uid" bigint) TO "authenticated";
GRANT ALL ON FUNCTION "public"."delete_other_bids"("bid_uid" bigint) TO "service_role";



GRANT ALL ON FUNCTION "public"."get_disabled_account_reason"("user_email" character varying, "user_phone" character varying) TO "anon";
GRANT ALL ON FUNCTION "public"."get_disabled_account_reason"("user_email" character varying, "user_phone" character varying) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_disabled_account_reason"("user_email" character varying, "user_phone" character varying) TO "service_role";



GRANT ALL ON FUNCTION "public"."get_feed_tasks"("data" "jsonb") TO "anon";
GRANT ALL ON FUNCTION "public"."get_feed_tasks"("data" "jsonb") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_feed_tasks"("data" "jsonb") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_feed_tasks_without_location"("user_tags" "text"[], "user_age" integer, "user_gender" "public"."gender_enum") TO "anon";
GRANT ALL ON FUNCTION "public"."get_feed_tasks_without_location"("user_tags" "text"[], "user_age" integer, "user_gender" "public"."gender_enum") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_feed_tasks_without_location"("user_tags" "text"[], "user_age" integer, "user_gender" "public"."gender_enum") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_message_rooms"("params" "jsonb") TO "anon";
GRANT ALL ON FUNCTION "public"."get_message_rooms"("params" "jsonb") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_message_rooms"("params" "jsonb") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_recommended_task_bidder_profiles"("task_uid" bigint) TO "anon";
GRANT ALL ON FUNCTION "public"."get_recommended_task_bidder_profiles"("task_uid" bigint) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_recommended_task_bidder_profiles"("task_uid" bigint) TO "service_role";



GRANT ALL ON FUNCTION "public"."get_recommended_task_bidder_tokens"("task_uid" bigint) TO "anon";
GRANT ALL ON FUNCTION "public"."get_recommended_task_bidder_tokens"("task_uid" bigint) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_recommended_task_bidder_tokens"("task_uid" bigint) TO "service_role";



GRANT ALL ON FUNCTION "public"."get_task_by_id"("task_uid" bigint) TO "anon";
GRANT ALL ON FUNCTION "public"."get_task_by_id"("task_uid" bigint) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_task_by_id"("task_uid" bigint) TO "service_role";



GRANT ALL ON FUNCTION "public"."get_user_contact_info"("params" "jsonb") TO "anon";
GRANT ALL ON FUNCTION "public"."get_user_contact_info"("params" "jsonb") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_user_contact_info"("params" "jsonb") TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_user_ban"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_user_ban"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_user_ban"() TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_user_unban"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_user_unban"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_user_unban"() TO "service_role";



GRANT ALL ON FUNCTION "public"."is_amount_greater_than_bidding_amount"("taskid" bigint, "amount" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."is_amount_greater_than_bidding_amount"("taskid" bigint, "amount" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_amount_greater_than_bidding_amount"("taskid" bigint, "amount" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."is_assigned_user"("task_uid" bigint) TO "anon";
GRANT ALL ON FUNCTION "public"."is_assigned_user"("task_uid" bigint) TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_assigned_user"("task_uid" bigint) TO "service_role";



GRANT ALL ON FUNCTION "public"."is_token_exists"("device_token" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."is_token_exists"("device_token" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_token_exists"("device_token" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."on_user_deleted"() TO "anon";
GRANT ALL ON FUNCTION "public"."on_user_deleted"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."on_user_deleted"() TO "service_role";



GRANT ALL ON FUNCTION "public"."on_user_deleted_post"() TO "anon";
GRANT ALL ON FUNCTION "public"."on_user_deleted_post"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."on_user_deleted_post"() TO "service_role";



GRANT ALL ON FUNCTION "public"."process_deletion_requests"() TO "anon";
GRANT ALL ON FUNCTION "public"."process_deletion_requests"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."process_deletion_requests"() TO "service_role";



GRANT ALL ON FUNCTION "public"."reactivate_user"("user_email" character varying, "user_phone" character varying) TO "anon";
GRANT ALL ON FUNCTION "public"."reactivate_user"("user_email" character varying, "user_phone" character varying) TO "authenticated";
GRANT ALL ON FUNCTION "public"."reactivate_user"("user_email" character varying, "user_phone" character varying) TO "service_role";



GRANT ALL ON FUNCTION "public"."remove_stale_tokens"() TO "anon";
GRANT ALL ON FUNCTION "public"."remove_stale_tokens"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."remove_stale_tokens"() TO "service_role";



GRANT ALL ON FUNCTION "public"."search_tasks"("data" "jsonb") TO "anon";
GRANT ALL ON FUNCTION "public"."search_tasks"("data" "jsonb") TO "authenticated";
GRANT ALL ON FUNCTION "public"."search_tasks"("data" "jsonb") TO "service_role";



GRANT ALL ON FUNCTION "public"."update_avatar_if_exists"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_avatar_if_exists"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_avatar_if_exists"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_profile"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_profile"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_profile"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_updated_at_column"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_updated_at_column"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_updated_at_column"() TO "service_role";


































































SET SESSION AUTHORIZATION "postgres";
RESET SESSION AUTHORIZATION;



SET SESSION AUTHORIZATION "postgres";
RESET SESSION AUTHORIZATION;





















GRANT ALL ON TABLE "public"."addresses" TO "anon";
GRANT ALL ON TABLE "public"."addresses" TO "authenticated";
GRANT ALL ON TABLE "public"."addresses" TO "service_role";



GRANT ALL ON SEQUENCE "public"."addresses_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."addresses_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."addresses_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."bidding" TO "anon";
GRANT ALL ON TABLE "public"."bidding" TO "authenticated";
GRANT ALL ON TABLE "public"."bidding" TO "service_role";



GRANT ALL ON SEQUENCE "public"."bidding_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."bidding_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."bidding_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."devices" TO "anon";
GRANT ALL ON TABLE "public"."devices" TO "authenticated";
GRANT ALL ON TABLE "public"."devices" TO "service_role";



GRANT ALL ON SEQUENCE "public"."devices_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."devices_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."devices_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."disabled_accounts" TO "anon";
GRANT ALL ON TABLE "public"."disabled_accounts" TO "authenticated";
GRANT ALL ON TABLE "public"."disabled_accounts" TO "service_role";



GRANT ALL ON TABLE "public"."messages" TO "anon";
GRANT ALL ON TABLE "public"."messages" TO "authenticated";
GRANT ALL ON TABLE "public"."messages" TO "service_role";



GRANT ALL ON TABLE "public"."notifications" TO "anon";
GRANT ALL ON TABLE "public"."notifications" TO "authenticated";
GRANT ALL ON TABLE "public"."notifications" TO "service_role";



GRANT ALL ON SEQUENCE "public"."notifications_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."notifications_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."notifications_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."profiles" TO "anon";
GRANT ALL ON TABLE "public"."profiles" TO "authenticated";
GRANT ALL ON TABLE "public"."profiles" TO "service_role";



GRANT ALL ON TABLE "public"."reviews" TO "anon";
GRANT ALL ON TABLE "public"."reviews" TO "authenticated";
GRANT ALL ON TABLE "public"."reviews" TO "service_role";



GRANT ALL ON SEQUENCE "public"."reviews_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."reviews_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."reviews_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."tasks" TO "anon";
GRANT ALL ON TABLE "public"."tasks" TO "authenticated";
GRANT ALL ON TABLE "public"."tasks" TO "service_role";



GRANT ALL ON SEQUENCE "public"."tasks_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."tasks_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."tasks_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."user_payment_details" TO "anon";
GRANT ALL ON TABLE "public"."user_payment_details" TO "authenticated";
GRANT ALL ON TABLE "public"."user_payment_details" TO "service_role";



GRANT ALL ON TABLE "public"."user_payments" TO "anon";
GRANT ALL ON TABLE "public"."user_payments" TO "authenticated";
GRANT ALL ON TABLE "public"."user_payments" TO "service_role";



ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "service_role";






























RESET ALL;

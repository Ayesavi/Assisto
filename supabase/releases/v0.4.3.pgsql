BEGIN

ALTER TABLE public.profiles
ADD COLUMN dob DATE;

-- drop function get_feed_tasks;

ALTER TABLE public.profiles
DROP COLUMN age;

CREATE OR REPLACE FUNCTION  get_feed_tasks(
    data jsonb
)
RETURNS TABLE (
    id bigint,
    title varchar,
    tags varchar[],
    description varchar,
    distance double precision, -- New column for distance in kilometers
    owner jsonb, -- New column for owner information
    deadline timestamptz
)   security definer AS $$
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
$$ LANGUAGE plpgsql;

-- Function to handle the deletion of a user
CREATE OR REPLACE FUNCTION on_user_deleted() 
RETURNS trigger 
LANGUAGE plpgsql 
SECURITY DEFINER 
AS 
$$
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
$$;

-- -- Drop the trigger if it already exists to avoid conflicts
-- DROP TRIGGER IF EXISTS on_user_deleted_trigger ON auth.users;

-- Create a new trigger for the on_user_deleted function
-- CREATE TRIGGER on_user_deleted_trigger
-- BEFORE DELETE ON auth.users
-- FOR EACH ROW
-- EXECUTE FUNCTION on_user_deleted();

drop function get_task_by_id;
CREATE OR REPLACE FUNCTION get_task_by_id(
    task_uid bigint
) 
RETURNS TABLE (
    id bigint,
    title varchar,  
    tags varchar[],
    description varchar,
    owner jsonb,
    bid jsonb,
    address jsonb,
    expected_price int,
    status task_status,
    age_group varchar,
    gender gender_enum,
    created_at timestamptz, 
    deadline timestamptz
) 
LANGUAGE plpgsql security definer AS  $$
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


-- ALTER TABLE public.tasks ADD COLUMN updated_at timestamptz;

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_tasks_updated_at
  after UPDATE ON public.tasks
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();


CREATE OR REPLACE FUNCTION get_message_rooms(params JSONB)
RETURNS TABLE(
  message JSONB,
  author JSONB,
  task JSONB,
  chat_id BIGINT
) LANGUAGE plpgsql
AS 
$$
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

alter policy "read to authenticated users"
on "public"."tasks"
to authenticated
using (  (status = 'unassigned'::task_status)));

CREATE OR REPLACE FUNCTION accept_bid(task_bid_id BIGINT) 
RETURNS VOID 
LANGUAGE plpgsql 
SECURITY DEFINER
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

create table
  public.user_payments (
    id character varying not null,
    created_at timestamp with time zone not null default now(),
    to_user_id uuid not null default gen_random_uuid (),
    from_user_id uuid not null default gen_random_uuid (),
    amt smallint not null,
    status public.payment_status null,
    constraint user_payments_pkey primary key (id),
    constraint user_payments_from_user_id_fkey foreign key (from_user_id) references profiles (id) on update cascade on delete cascade,
    constraint user_payments_to_user_id_fkey foreign key (to_user_id) references profiles (id) on update cascade on delete cascade
  ) tablespace pg_default;


CREATE TYPE payment_status AS ENUM ('pending', 'success', 'failed');

alter table user_payments add column status public.payment_status;

SELECT cron.schedule(
    'update_user_payments', -- job name
    '* * * * *', -- cron schedule: every hour at minute 0
    $$
    UPDATE user_payments 
    SET status = 'failed' -- Example: assuming you want to update a status column
    WHERE created_at < NOW() - INTERVAL '1 hour' and status ='pending';
    $$ -- the query to run
);

create policy "read only to transaction associated users."
on "public"."user_payments"
as PERMISSIVE
for SELECT
to authenticated
using (
to_user_id = auth.uid() or from_user_id =auth.uid()
);

CREATE OR REPLACE FUNCTION get_user_contact_info(params jsonb)
RETURNS jsonb LANGUAGE plpgsql SECURITY DEFINER AS $$
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
-- 

-- SELECT get_user_contact_info('{"task_uid": "33", "uid": "b20352c6-513c-4a59-bf0d-f559c7073c85"}'::jsonb);

CREATE OR REPLACE FUNCTION is_amount_greater_than_bidding_amount(taskid BIGINT, amount INT)
RETURNS BOOLEAN AS $$
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
$$ LANGUAGE plpgsql SECURITY DEFINER;

alter policy "Create bid for autheticated tasks only"
on "public"."bidding"
to authenticated
with check ( ((check_duplicate_bid(task_id) = false) AND (is_amount_greater_than_bidding_amount(task_id, (amount)::integer) = false)));

CREATE OR REPLACE FUNCTION update_profile()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
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

-- DROP FUNCTION IF EXISTS search_tasks;

CREATE OR REPLACE FUNCTION search_tasks(
    data jsonb
) 
RETURNS TABLE (
    id bigint,
    title varchar,
    tags varchar[],
    description varchar,
    distance double precision, -- New column for distance in kilometers
    owner jsonb, -- New column for owner information
    deadline timestamptz
) 
LANGUAGE plpgsql security definer
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

ALTER DATABASE postgres
SET timezone TO 'Asia/Kolkata';


COMMIT
import { createClient, SupabaseClient } from "@supabase/supabase-js";

function _SUPABASE_KEY(): string {
  return process.env.GCLOUD_PROJECT == "dev-assisto" // this one is actually assisto-prod
    ? process.env.SUPABASE_PROD_KEY || ""
    : process.env.SUPABASE_DEV_KEY || "";
}

function _SUPABASE_URL(): string {
  return process.env.GCLOUD_PROJECT == "dev-assisto" // this one is actually assisto-prod
    ? process.env.SUPABASE_PROD_URL || ""
    : process.env.SUPABASE_DEV_URL || "";
}

function SUPABASE_CLIENT(): SupabaseClient {
  return createClient(_SUPABASE_URL(), _SUPABASE_KEY());
}

function JWT_SECRET(): string {
  return process.env.GCLOUD_PROJECT == "dev-assisto" // this one is actually assisto-prod
    ? process.env.SUPABASE_PROD_JWT_SECRET || ""
    : process.env.SUPABASE_DEV_JWT_SECRET || "";
}



export { JWT_SECRET, SUPABASE_CLIENT };

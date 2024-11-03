import { createClient } from "@supabase/supabase-js";

function supabaseApiKey(): string {
  return process.env.GCLOUD_PROJECT == "dev-assisto" // this one is actually assisto-prod
    ? process.env.SUPABASE_PROD_KEY || ""
    : process.env.SUPABASE_DEV_KEY || "";
}

function supabaseApiUrl(): string {
  return process.env.GCLOUD_PROJECT == "dev-assisto" // this one is actually assisto-prod
    ? process.env.SUPABASE_PROD_URL || ""
    : process.env.SUPABASE_DEV_URL || "";
}

export function supabaseClient() {
  return createClient(supabaseApiUrl(), supabaseApiKey());
}

export const tokensTable = "devices";

import { createClient, SupabaseClient } from "@supabase/supabase-js";
import { Cashfree } from "cashfree-pg";

/**
 * OneSignal Notification client
 */

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
  console.log(_SUPABASE_URL())
  return createClient(_SUPABASE_URL(), _SUPABASE_KEY());
}

function JWT_SECRET(): string {
  return process.env.GCLOUD_PROJECT == "dev-assisto" // this one is actually assisto-prod
    ? process.env.SUPABASE_PROD_JWT_SECRET || ""
    : process.env.SUPABASE_DEV_JWT_SECRET || "";
}

function initializePayment() {
  if (process.env.GCLOUD_PROJECT == "dev-assisto") {
    Cashfree.XClientId = process.env.CF_APP_ID;
    Cashfree.XClientSecret = process.env.CF_API_KEY;
    Cashfree.XEnvironment = Cashfree.Environment.PRODUCTION;
  } else {
    Cashfree.XClientId = process.env.CF_DEV_APP_ID;
    Cashfree.XClientSecret = process.env.CF_DEV_API_KEY;
    Cashfree.XEnvironment = Cashfree.Environment.SANDBOX;
  }
}

export { initializePayment, JWT_SECRET, SUPABASE_CLIENT };

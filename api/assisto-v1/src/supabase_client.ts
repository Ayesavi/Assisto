import * as OneSignal from "@onesignal/node-onesignal";
import { createClient, SupabaseClient } from "@supabase/supabase-js";
import { Cashfree } from "cashfree-pg";

const configuration = OneSignal.createConfiguration({
  restApiKey: getOneSignalConfig().restApiKey,
  userAuthKey: getOneSignalConfig().userAuthKey,
});
/**
 * OneSignal Notification client
 */
const NClient = new OneSignal.DefaultApi(configuration);

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

function getOneSignalConfig(): OneSignalConfig {
  if (process.env.GCLOUD_PROJECT == "dev-assisto") {
    return {
      appId: process.env.ONE_SIGNAL_PROD_APP_ID || "",
      userAuthKey: process.env.ONE_SIGNAL_DEV_USER_ID || "",
      restApiKey: process.env.ONE_SIGNAL_PROD_API_KEY || "",
    };
  } else {
    return {
      appId: process.env.ONE_SIGNAL_DEV_APP_ID || "",
      userAuthKey: process.env.ONE_SIGNAL_PROD_USER_ID || "",
      restApiKey: process.env.ONE_SIGNAL_DEV_API_KEY || "",
    };
  }
}

interface OneSignalConfig {
  appId: string;
  userAuthKey: string;
  restApiKey: string;
}

export {
  getOneSignalConfig,
  initializePayment,
  JWT_SECRET,
  NClient,
  SUPABASE_CLIENT,
};

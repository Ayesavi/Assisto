import { SupabaseClient } from "@supabase/supabase-js";
import { SUPABASE_CLIENT } from "../../../supabase_client";

/**
 * Class for handling user deletion operations.
 */
export class DisabledReason {
  private supabase: SupabaseClient;

  constructor() {
    this.supabase = SUPABASE_CLIENT();
  }

  async call(email: string, phone?: string) {
    try {
      console.log(email, phone);

      const { data, error } = await this.supabase.rpc(
        "get_disabled_account_reason",
        {
          user_email: `${email}`,
          user_phone: `${phone}`,
        }
      );

      console.log(data);

      if (error) {
        console.error(error);
        throw new Error(error.message);
      }

      return data;
    } catch (error) {
      return "Failed to get failed account reasons";
    }
  }
}

export default DisabledReason;

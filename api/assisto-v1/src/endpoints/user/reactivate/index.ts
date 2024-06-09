import { SupabaseClient } from "@supabase/supabase-js";
import { SUPABASE_CLIENT } from "../../../supabase_client";

/**
 * Class for handling user reactivation operations.
 */
export class ReactivateUser {
  private supabase: SupabaseClient;

  constructor() {
    this.supabase = SUPABASE_CLIENT();
  }

  async call(email: string, phone?: string) {
    console.log("Reactivating user with:", email, phone);

    const { data, error } = await this.supabase.rpc("reactivate_user", {
      user_email: email,
      user_phone: phone || null,
    });

    if (error) {
      console.error("Error from Supabase RPC call:", error.message);
      throw error.message;
    }

    console.log("User reactivated successfully:", data);
    return data;
  }
}

export default ReactivateUser;

import { SupabaseClient } from "@supabase/supabase-js";
import * as admin from "firebase-admin";
import * as jwt from "jsonwebtoken";
import { JWT_SECRET, SUPABASE_CLIENT } from "../../../supabase_client";

/**
 * Class for handling user deletion operations.
 */
export class UserDelete {
  private supabase: SupabaseClient;
  private disabledUsersTable: string = "disabled_accounts";
  private jwtSecret: string = "";
  private firestore = admin.firestore();

  constructor() {
    this.supabase = SUPABASE_CLIENT();
    this.jwtSecret = JWT_SECRET();
  }

  /**
   * Adds a record in the disabled users list and disables the account for 30 days.
   * @param authToken - The authentication token of the user.
   * @returns A promise that resolves when the user is successfully added to the disabled accounts table.
   * @throws An error if the JWT is invalid or expired.
   */
  async initiate(authToken: string): Promise<void> {
    try {
      const user = jwt.verify(authToken, this.jwtSecret);

      const { data, error } = await this.supabase
        .from(this.disabledUsersTable)
        .insert({
          user_id: user.sub,
          is_for_deletion: true,
          reason: "Account undergoing deletion",
          banned_till: this._getDateAfter30Days().toISOString(),
        });

      if (error) {
        console.error(
          `Error inserting into ${this.disabledUsersTable}: ${error.message}`
        );
        throw new Error(
          `Error inserting into ${this.disabledUsersTable}: ${error.message}`
        );
      }

      console.log("User successfully added to disabled accounts table", data);
    } catch (error) {
      if (error instanceof jwt.JsonWebTokenError) {
        console.error(`JWT error: ${error.message}`);
        throw new Error(`Invalid token provided`);
      } else if (error instanceof jwt.TokenExpiredError) {
        console.error(`JWT expired: ${error.message}`);
        throw new Error(`Token has expired`);
      } else {
        console.error(`An error occurred while initiating deletion: ${error}`);
        throw new Error(
          `An error occurred while initiating deletion: ${error}`
        );
      }
    }
  }

  /**
   * Scans the disabled users table, deletes the user from supabase.auth, anonymizes profiles table,
   * removes records from devices and reviews, and unbans the user.
   * @returns A promise that resolves when the deletion process is completed.
   */
  async deleteUser(uid: string): Promise<string> {
    try {
      const { data: user } = await this.supabase.auth.admin.getUserById(
        uid
      );

      if (user) {
        /// store in firestore database users collection
        // Store in Firestore database users collection
        await this.firestore.collection("users_backup").doc(uid).set(user);
      }

      const { error: deleteUser } = await this.supabase.auth.admin.deleteUser(
        uid
      );

      if (deleteUser) {
        console.error(deleteUser);
        throw "Failed to remove user";
      }

      return "User deleted successfully";
    } catch (error) {
      console.error(`Error occurred while removing user from ${error}`);
      return "Failed to delete";
    }
  }
  async disabledAccountReason(email: string, phone?: string) {
    try {
      console.log(email, phone);

      const { data, error } = await this.supabase.rpc(
        "get_disabled_account_reason",
        {
          user_email: email,
          user_phone: phone,
        }
      );

      console.log(data);

      if (error) {
        console.error(error);
        throw new Error("Failed to get disabled account reason");
      }

      return data;
    } catch (error) {
      return "Failed to get failed account reasons";
    }
  }
  /**
   * Returns a date 30 days after the current date.
   * @returns A Date object representing the date 30 days from now.
   */
  private _getDateAfter30Days(): Date {
    const now = new Date();
    now.setDate(now.getDate() + 30);
    return now;
  }
}

export default UserDelete;

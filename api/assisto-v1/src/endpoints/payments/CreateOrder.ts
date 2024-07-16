import { SupabaseClient } from "@supabase/supabase-js";
import { Cashfree, CreateOrderRequest } from "cashfree-pg";
import * as jwt from "jsonwebtoken";
import {
  initializePayment,
  JWT_SECRET,
  SUPABASE_CLIENT,
} from "../../supabase_client";

class CreateOrder {
  private supabase: SupabaseClient;

  constructor(token: string) {
    try {
      // Verify the JWT token and extract the user information
      const user = jwt.verify(token, JWT_SECRET());
      if (user.sub) {
        // Initialize Cashfree client configuration
        initializePayment();

        // Initialize Supabase client
        this.supabase = SUPABASE_CLIENT();
      } else {
        throw new Error("Invalid user");
      }
    } catch (error) {
      console.error("Error during initialization:", error);
      throw new Error("Error creating instance");
    }
  }

  async createOrder(bidId: number) {
    try {
      // Fetch bid amount from the Supabase database
      const { data, error } = await this.supabase
        .from("bidding")
        .select(
          "amount,bidder:bidder_id(id,full_name),task:task_id(owner_id,id,title)"
        )
        .eq("id", bidId)
        .single();

      if (error) {
        console.error(`Error fetching bid: ${error.message}`);
        throw new Error("Failed to fetch bid amount");
      }

      if (!data) {
        throw new Error("Bid not found");
      }
      console.log(data);
      const { data: userData, error: userError } =
        await this.supabase.auth.admin.getUserById((data.bidder as any).id);

      if (userError) {
        console.error(`Error fetching user: ${userError.message}`);
        throw new Error("Failed to fetch user data");
      }

      const request: CreateOrderRequest = {
        order_amount: data.amount + 5,
        order_currency: "INR",
        customer_details: {
          customer_id: userData.user.id || "",
          customer_name: userData.user.user_metadata?.full_name || "",
          customer_email: userData.user.email,
          customer_phone: userData.user.phone || "9999999999",
        },
        order_tags: {
          taskId: `${(data.task as any).id}`,
          bidderId: `${(data.bidder as any).id}`,
          taskOwnerId: (data.task as any).owner_id,
          taskName: (data.task as any).title,
        },
        order_note: `Payment to ${userData.user.user_metadata?.full_name}`,
      };

      // Create the order using Cashfree's createOrder method
      const response = await Cashfree.PGCreateOrder("2023-08-01", request);
      return response.data;
    } catch (error) {
      if (error) {
        console.error("Error creating order:", error);
      } else {
        console.error("Error creating order:", error);
      }
      throw new Error("Cannot create order at the moment");
    }
  }
}

export default CreateOrder;

enum PaymentWebhookEvents {
  PAYMENT_SUCCESS_WEBHOOK = "PAYMENT_SUCCESS_WEBHOOK",
  PAYMENT_FAILED_WEBHOOK = "PAYMENT_FAILED_WEBHOOK",
}
enum SupabasePaymentStatus {
  PENDING = "pending",
  SUCCESS = "success",
  FAILED = "failed",
}

export { PaymentWebhookEvents ,SupabasePaymentStatus};

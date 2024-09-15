abstract class IStripeService {
  Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency);
  Future<void> initializePaymentSheet(String paymentIntentClientSecret);
  Future<void> presentPaymentSheet();
}

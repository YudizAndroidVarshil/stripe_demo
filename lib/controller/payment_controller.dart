import 'package:get/get.dart';
import '../interface/stripe_service.dart';

class PaymentController extends GetxController {
  final IStripeService _stripeService;
  var isLoading = false.obs;

  PaymentController(this._stripeService);

  Future<void> makePayment(String amount, String currency) async {
    try {
      isLoading.value = true;

      // Create Payment Intent
      final paymentIntent = await _stripeService.createPaymentIntent(amount, currency);

      // Initialize Payment Sheet
      await _stripeService.initializePaymentSheet(paymentIntent['client_secret']);

      // Present the Payment Sheet
      await _stripeService.presentPaymentSheet();

      _showSuccessMessage('Payment successful!');
    } catch (error) {
      _showErrorMessage('Payment error: $error');
    } finally {
      isLoading.value = false;
    }
  }

  void _showSuccessMessage(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.primaryColor,
      colorText: Get.theme.cardColor,
    );
  }

  void _showErrorMessage(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.primaryColor,
      colorText: Get.theme.cardColor,
    );
  }
}

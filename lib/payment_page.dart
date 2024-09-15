import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/payment_controller.dart';

class PaymentPage extends StatelessWidget {
  final PaymentController paymentController = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stripe Payment'),
      ),
      body: Center(
        child: Obx(() {
          if (paymentController.isLoading.value) {
            return CircularProgressIndicator(); // Show loading indicator
          }
          return ElevatedButton(
            onPressed: () {
              paymentController.makePayment('5000', 'INR'); // Example payment
            },
            child: Text('Pay \$50'),
          );
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:stripe_demo/payment_page.dart';
import 'controller/payment_controller.dart';
import 'stripe_service.dart';

void main() {
  Stripe.publishableKey = "pk_test_51NuAXUSEo3zjK641WVuAXicySwns7hBxUeJ0GPCFnTcUULCrR9JCCCBRCQLfOmIGumiMXJysGgmhLZJEL4gOywMy00nwSZrREF";
  Get.put<PaymentController>(PaymentController(StripeService()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PaymentPage(),
    );
  }
}

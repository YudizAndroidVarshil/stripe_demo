import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'interface/stripe_service.dart';
import 'package:http/http.dart' as http;

class StripeService implements IStripeService {
  static const _apiBase = 'https://api.stripe.com/v1';
  static const _paymentApiUrl = '$_apiBase/payment_intents';
  static const _secretKey = 'sk_test_51NuAXUSEo3zjK641qadokue0Ue9rEty3WjgvO37r24b4pS9me3P4Jkag4jVA0NvEdzVH5B5lXubyJy7OTcAMTflo00KPZPbuwO';

  @override
  Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
    try {
      final body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      final response = await http.post(
        Uri.parse(_paymentApiUrl),
        body: body,
        headers: {
          'Authorization': 'Bearer $_secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      return json.decode(response.body);
    } catch (error) {
      debugPrint("VRS create payment intent : $error");
      throw Exception('Error creating payment intent: $error');
    }
  }

  @override
  Future<void> initializePaymentSheet(String paymentIntentClientSecret) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: 'Your App',
        ),
      );
    } catch (error) {
      debugPrint("VRS init payment sheet : ${error}");
      throw Exception('Error initializing payment sheet: $error');
    }
  }

  @override
  Future<void> presentPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (error) {
      debugPrint("VRS present payment sheet : $error");
      throw Exception('Error presenting payment sheet: $error');
    }
  }
}
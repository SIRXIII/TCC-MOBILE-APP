// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:http/http.dart' as http;
//
// import '../utils/app_imports.dart';
//
// class PaymentController extends GetxController {
//   var isLoading = false.obs;
//
//   // Your backend API
//   final backendUrl = "https://travelclothingclub.com";
//
//   Future<void> makePayment({required int amount}) async {
//     try {
//       isLoading.value = true;
//
//       // 1. Create PaymentIntent on backend
//       final clientSecret = await _createPaymentIntent(amount);
//
//       // 2. Initialize payment sheet
//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: clientSecret,
//           merchantDisplayName: "My App",
//           style: ThemeMode.light,
//         ),
//       );
//
//       // 3. Display payment sheet
//       await Stripe.instance.presentPaymentSheet();
//
//       Get.snackbar("Success", "Payment completed!");
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // Call your server to create PaymentIntent
//   Future<String> _createPaymentIntent(int amount) async {
//     final url = Uri.parse("$backendUrl/create-payment-intent");
//     final response = await http.post(
//       url,
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({"amount": amount}),
//     );
//
//     if (response.statusCode == 200) {
//       return jsonDecode(response.body)['clientSecret'];
//     } else {
//       throw Exception("Failed to create payment intent");
//     }
//   }
// }
//
// class PaymentView extends StatelessWidget {
//   final controller = Get.put(PaymentController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Stripe Payment")),
//       body: Center(
//         child: Obx(() {
//           return controller.isLoading.value
//               ? CircularProgressIndicator()
//               : ElevatedButton(
//                   onPressed: () {
//                     controller.makePayment(amount: 1500); // PKR 1500
//                   },
//                   child: Text("Pay Now"),
//                 );
//         }),
//       ),
//     );
//   }
// }

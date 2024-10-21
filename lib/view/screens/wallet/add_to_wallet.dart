import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getondial/controller/user_controller.dart';
import 'package:getondial/util/app_constants.dart';
import 'package:getondial/view/base/custom_app_bar.dart';
import 'package:getondial/view/screens/wallet/payment_done.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AddToWalletScreen extends StatefulWidget {
  const AddToWalletScreen({Key? key}) : super(key: key);

  @override
  AddToWalletScreenState createState() => AddToWalletScreenState();
}

class AddToWalletScreenState extends State<AddToWalletScreen> {
  late String selectedUrl;
  late String userId;
  late WebViewController webViewController;

  @override
  void initState() {
    super.initState();
    userId = (Get.find<UserController>().userInfoModel!.id).toString();
    selectedUrl =
        '${AppConstants.baseUrl}/payment-mobile/get-refer-payment?customer_id=${userId}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Add To Wallet"),
      body: WebView(
        initialUrl: selectedUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          webViewController = webViewController;
        },
        navigationDelegate: (NavigationRequest request) {
          // Check if the URL indicates payment failure
          if (request.url.contains('fail') &&
              request.url.contains(AppConstants.baseUrl)) {
            // Payment failed, show an alert
            _showPaymentFailedAlert();
          } else if (request.url.contains('transactionId') &&
              request.url.contains(AppConstants.baseUrl)) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return PaymentSuccessScreen();
            }));
          } else if (request.url.contains('refer-payment-success') &&
              request.url.contains(AppConstants.baseUrl)) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return PaymentSuccessScreen();
            }));

          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }

  void _showPaymentFailedAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Payment Failed"),
          content: Text("The payment process failed."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}

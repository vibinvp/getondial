
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:getondial/view/screens/wallet/wallet_screen.dart';

class PaymentSuccessScreen extends StatefulWidget {
  @override
  _PaymentSuccessScreenState createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  @override
  void initState() {
    super.initState();

   // Redirect after 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
        return WalletScreen(fromWallet: true,);
      }), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 100),
            SizedBox(height: 20),
            Text(
              'Payment Success!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('You will be redirected to the preview page shortly.'),
          ],
        ),
      ),
    );
  }
}

class PreviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Preview Page")),
      body: Center(
        child: Text(
          "This is the Preview Page",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
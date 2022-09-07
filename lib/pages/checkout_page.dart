import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Checkout')),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'Today it\'s on us!',
                style: TextStyle(fontSize: 38),
              ),
              SizedBox(height: 60),
              Text(
                'Get Ready',
                style: TextStyle(fontSize: 32),
              ),
              SizedBox(height: 10),
              Text(
                'warm crêpes',
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(height: 20),
              Text(
                'at your door',
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(height: 20),
              Text(
                'in t minus 20 min',
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(height: 10),
              Text(
                '...',
                style: TextStyle(fontSize: 22),
              ),
            ],
          ),
        ),
      );
}

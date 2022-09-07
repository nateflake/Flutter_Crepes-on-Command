import 'package:crepes/pages/products_page.dart';
import 'package:crepes/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final riverPodProvider = Provider((_) => '99');

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crepes-on-Command',
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      home: const ProductsPage(),
    );
  }
}

import 'package:e_commerce_app/auth/login/loginScreen.dart';
import 'package:e_commerce_app/dashboard/DashboardScreen.dart';
import 'package:e_commerce_app/dashboard/cart/CartScreen.dart';
import 'package:e_commerce_app/dashboard/product/CategoryProductsScreen.dart';
import 'package:e_commerce_app/dashboard/product/ProductDetailScreen.dart';
import 'package:e_commerce_app/splash/SplashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/category': (context) => ProductScreen(category: '',),
        '/product': (context) => ProductDetailScreen(product: {},),
        '/cart': (context) => CartScreen(),
      },
    );
  }
}

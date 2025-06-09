import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Views/Home_Screen.dart';
import 'package:news_app/Views/SplashScreen.dart';
import 'package:news_app/Views/categories_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
    home:Splashscreen()
    );
  }
}



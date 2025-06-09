import 'dart:async';
import 'package:get/get.dart';
import 'package:news_app/Views/Home_Screen.dart';

class SplashScreenController extends GetxController{

  void onInit(){
    super.onInit();
    Timer(Duration(seconds:3),(){
      Get.to(HomeScreen());
    });
  }
}
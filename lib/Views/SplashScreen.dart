import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Controllers/splashScreen_controller.dart';
import 'package:news_app/responsive.dart';

class Splashscreen extends StatelessWidget {
  Splashscreen({super.key});

  final SplashScreenController  splashScreenController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffF5F4F9),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (Responsive.isMobile(context))
              Image.asset(
                height: height *0.98,
                "assets/images/splash_pic.jpg",
                fit: BoxFit.cover,
              )
            else if (Responsive.isTablet(context))
              Expanded(
                child: Image.asset(
                  "assets/images/splash_pic.jpg",
                  fit: BoxFit.cover,
                ),
              )
            else if (Responsive.isDesktop(context))
                Expanded(
                  child: Image.asset(
                    // height: height *0.55,
                    "assets/images/splash_pic.jpg",
                    fit: BoxFit.contain,
                  ),
                ),
            SizedBox(
              height: height*0.03,
            ),
            Text("TOP HEADLIN",style: GoogleFonts.anton(letterSpacing: .6,color: Colors.black,
              fontSize: height*0.029,
            ),),
            SizedBox(
              height: height*0.03,
            ),
            SpinKitChasingDots(
              color: Colors.red.shade800,
              size: 45,
            )
          ],
        ),
      ),
    );
  }
  }

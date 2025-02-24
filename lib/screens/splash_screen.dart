import 'package:blog_app/screens/splash_services.dart';
import 'package:flutter/material.dart';
//import 'firebase_options.dart';

// ...

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();

    splashServices.islogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: const Center(
                  child: Image(
                      image: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT79qjfrOCMo5ZDWRG49P_M5m5IJC-N1UVOqw&s'))),
            ),
          ],
        ));
  }
}

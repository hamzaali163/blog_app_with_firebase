import 'package:blog_app/Utils/general_utils.dart';
import 'package:blog_app/Utils/route_names.dart';
import 'package:blog_app/Utils/routes.dart';
import 'package:blog_app/components/app_colors.dart';
import 'package:blog_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => GeneralUtils())],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: AppColors.mainColor,
          ),
          initialRoute: RoutesNames.splashscreen,
          //home: SplashScreen(),
          onGenerateRoute: Routes.generateroutes,
        ));
  }
}

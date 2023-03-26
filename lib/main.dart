import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ropstam_test/provider.dart/home_screen_provider.dart';
import 'package:ropstam_test/provider.dart/login_provider.dart';
import 'package:ropstam_test/provider.dart/sign_up_provider.dart';
import 'package:ropstam_test/provider.dart/update_data_provider.dart';
import 'package:ropstam_test/view_model/views/login_page/login_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UpdateDataProvider>(
        create: (context) => UpdateDataProvider(),
      ),
      ChangeNotifierProvider<HomeScreenProvider>(
        create: (context) => HomeScreenProvider(),
      ),
      ChangeNotifierProvider<LoginProvider>(
        create: (context) => LoginProvider(),
      ),
      ChangeNotifierProvider<SignUpProvider>(create: (context) => SignUpProvider(),)
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(384, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LoginScreen(),
        );
      },
    );
  }
}

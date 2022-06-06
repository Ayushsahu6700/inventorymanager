import 'dart:io';
import 'package:inventory_manager/cubit/currentUserCubit.dart';
import 'package:inventory_manager/cubit/deliveryBoyCubit.dart';
import 'package:inventory_manager/cubit/setTokenCubit.dart';
import 'package:inventory_manager/utlis/securestorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_manager/cubit/destinationsCubit.dart';
import 'package:inventory_manager/cubit/inwardingPackageCubit.dart';
import 'package:inventory_manager/view/homePage.dart';
import 'package:inventory_manager/view/loginPage.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:inventory_manager/view/qrPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cubit/approvedCubit.dart';
import 'cubit/conflictedCubit.dart';
import 'cubit/inwardCubit.dart';
import 'cubit/loginCubit.dart';
import 'cubit/markAllReadCubit.dart';
import 'cubit/markCubit.dart';
import 'cubit/notificationCubit.dart';
import 'cubit/onHoldCubit.dart';
import 'cubit/outwardCubit.dart';
import 'cubit/outwardForDeliveryCubit.dart';
import 'cubit/outwardingCubit.dart';
import 'cubit/toApproveCubit.dart';
import 'cubit/updateProfileCubit.dart';
import 'provider/themeProvider.dart';

String finalEmail = "";

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<loginCubit>(create: (_) => loginCubit()),
        BlocProvider<inwardingPackageCubit>(
            create: (_) => inwardingPackageCubit()),
        BlocProvider<toApproveCubit>(create: (_) => toApproveCubit()),
        BlocProvider<inwardCubit>(create: (_) => inwardCubit()),
        BlocProvider<outwardingPackageCubit>(
            create: (_) => outwardingPackageCubit()),
        BlocProvider<destinationCubit>(create: (_) => destinationCubit()),
        BlocProvider<outwardCubit>(create: (_) => outwardCubit()),
        BlocProvider<onHoldCubit>(create: (_) => onHoldCubit()),
        BlocProvider<approvedCubit>(create: (_) => approvedCubit()),
        BlocProvider<conflictedCubit>(create: (_) => conflictedCubit()),
        BlocProvider<deliveryBoyCubit>(create: (_) => deliveryBoyCubit()),
        BlocProvider<outwardForDeliveryCubit>(
            create: (_) => outwardForDeliveryCubit()),
        BlocProvider<currentUserCubit>(create: (_) => currentUserCubit()),
        BlocProvider<setTokenCubit>(create: (_) => setTokenCubit()),
        BlocProvider<updateProfileCubit>(create: (_) => updateProfileCubit()),
        BlocProvider<notificationCubit>(
          create: (_) => notificationCubit(),
        ),
        BlocProvider<markAllCubit>(
          create: (_) => markAllCubit(),
        ),
        BlocProvider<markCubit>(
          create: (_) => markCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.system,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        debugShowCheckedModeBanner: false,
        home: SplashFuturePage(),
      ),
    );
  }
}

// class SplashPage extends StatefulWidget {
//   SplashPage({Key? key}) : super(key: key);
//
//   @override
//   _SplashPageState createState() => _SplashPageState();
// }
//
// class _SplashPageState extends State<SplashPage> {
//   Future getValidationData() async {
//     final SharedPreferences sharedPreferences =
//         await SharedPreferences.getInstance();
//     var obtainedEmail = sharedPreferences.getString('email');
//     setState(() {
//       finalEmail = obtainedEmail!;
//     });
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getValidationData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final color = MediaQuery.of(context).platformBrightness == Brightness.dark
//         ? Colors.black
//         : Colors.white;
//     return EasySplashScreen(
//       logo: Image.asset(
//         "assets/inventory.png",
//       ),
//       logoSize: 100,
//       title: Text(
//         "Inventory Manager",
//         style: TextStyle(
//           fontSize: 25,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       backgroundColor: color,
//       showLoader: true,
//       loaderColor: Color(0xfffec260),
//       loadingText: Text(
//         "Loading...",
//       ),
//       navigator: finalEmail == "" ? loginPage() : mainPage(),
//       durationInSeconds: 5,
//     );
//   }
// }

class SplashFuturePage extends StatefulWidget {
  SplashFuturePage({Key? key}) : super(key: key);

  @override
  _SplashFuturePageState createState() => _SplashFuturePageState();
}

class _SplashFuturePageState extends State<SplashFuturePage> {
  Future<Widget> futureCall() async {
    // // do async operation ( api call, auto login)

    await userSecureStorage.deleteData();
    final email = await userSecureStorage2.getEmail();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('email');
    Future.delayed(const Duration(milliseconds: 500));
    return Future.value(
        (obtainedEmail == null || email == null) ? loginPage() : mainPage());
  }

  @override
  Widget build(BuildContext context) {
    final color = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? Colors.black
        : Colors.white;
    return EasySplashScreen(
      logo: Image.asset(
        "assets/inventory.png",
      ),
      logoSize: 100,
      title: Text(
        "Inventory Manager",
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: color,
      showLoader: true,
      loaderColor: Color(0xfffec260),
      loadingText: Text(
        "Loading...",
      ),
      futureNavigator: futureCall(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:saveyoo/Network/di.dart';
import 'package:saveyoo/Screen/SplashScreen/bloc/splash_bloc.dart';
import 'package:saveyoo/Screen/SplashScreen/splash_screen.dart';
import 'package:saveyoo/Widgets/app_bottom_navigation.dart';
import 'package:saveyoo/route/route.dart';
import 'package:sizer/sizer.dart';

import 'Utils/MyColor.dart';
import 'Utils/theme.dart';
import 'localization/localizations_delegate.dart';

void main() {
  // Set the status bar color to blue
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: mStatusbar,
    statusBarIconBrightness:
        Brightness.dark, //<-- For Android SEE HERE (dark icons)
    statusBarBrightness: Brightness.light,
  ));

  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
  //     statusBarColor: mStatusbar, // Color for Android
  //     statusBarBrightness:
  //         Brightness.dark // Dark == white status bar -- for IOS.
  //     ));

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light) // Or Brightness.dark
      );

  init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: BottomNavigatorProvider())
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              onGenerateRoute: Routes.onGenerateRoute,
              locale: const Locale('en'),
              supportedLocales: const [
                Locale('en', ''),
                // Locale('ar', ''),
                // Locale('hi', '')
              ],
              localizationsDelegates: const [
                AppLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              home: BlocProvider(
                  create: (_) => SplashBloc(mContext: context),
                  child: SplashScreen()),
            ));

        // HomeScreen()
      },
    );
  }
}

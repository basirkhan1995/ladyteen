import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ladyteen_system/Components/Colors/colors.dart';
import 'package:ladyteen_system/Components/Getx/getx_settings.dart';
import 'package:ladyteen_system/Views/Authentications/login.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'Components/Languages/languages.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  sqfliteFfiInit();

  databaseFactory = databaseFactoryFfi;
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String currentLocale = Get.locale.toString();
    final controller = Get.put(GetxSettings());
    return GetMaterialApp(
      title: 'Lady Teen',

      enableLog: true,
      defaultTransition: Transition.leftToRight,
      opaqueRoute: Get.isOpaqueRouteDefault,
      popGesture: Get.isPopGestureEnable,
      transitionDuration: Get.defaultDialogTransitionDuration,
      defaultGlobalState: Get.defaultOpaqueRoute,

      fallbackLocale: const Locale("fa"),
      locale: const Locale("fa"),
      translations: Languages(),
      debugShowCheckedModeBanner: false,

      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
          tabBarTheme: TabBarTheme(
              unselectedLabelStyle: TextStyle(
                fontFamily: currentLocale == "en"?"Ubuntu":"Dubai",
              ),
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                fontFamily: currentLocale == "en"?"Ubuntu":"Dubai",
              )
          ),

          appBarTheme: AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: currentLocale == "en"?"Ubuntu":"Dubai",
              ),

              actionsIconTheme: const IconThemeData(
                color: Colors.black45,
              ),

              iconTheme: const IconThemeData(
                color: Colors.black45,
              )
          ),
          scaffoldBackgroundColor: Colors.white,
          fontFamily: currentLocale == "en"?"Ubuntu":"Dubai",
          primarySwatch: buildMaterialColor(const Color(0xFF2D3392))
      ),
      home: const LoginScreen(),
    );
  }


  MaterialColor buildMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

}


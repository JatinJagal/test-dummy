import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/observers/route_observer.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:test_projectt/core/global/theme/theme_app.dart';
import 'package:test_projectt/core/global/theme/theme_service.dart';
import 'package:test_projectt/core/routes/app_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return buildGetMaterialApp(context);
  }

  GetMaterialApp buildGetMaterialApp(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Get.key,
      debugShowCheckedModeBanner: false,
      popGesture: true,
      enableLog: true,
      opaqueRoute: false,
      defaultTransition: Transition.cupertino,
      title: "Application",
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaler: const TextScaler.linear(
              1.0,
            ), // ✅ replaces textScaleFactor
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeApp.light,
      darkTheme: ThemeApp.dark,
      themeMode: ThemeService.to.themeMode,
      routingCallback: (Routing? routing) {
        if (routing != null) {
          // Logger.logPrint(
          //     "Current route: ${routing.current}"); // Log navigation events
        }
      },
      onReady: () async {},
    );
  }
}

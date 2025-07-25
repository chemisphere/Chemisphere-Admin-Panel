import 'package:education_web_admin_panel/routes/app_routes.dart';
import 'package:education_web_admin_panel/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bindings/general_binding.dart';
import 'utils/constants/colors.dart';
import 'utils/constants/text_strings.dart';
import 'utils/device/web_material_scroll.dart';
import 'utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.light,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      initialBinding:GeneralBindings(),
      getPages: TAppRoute.pages,
      initialRoute: TRoutes.users,
      unknownRoute: GetPage(name: "/Page-not-found",page: () => const Scaffold(body: Center(child: Text("Page Not Found")))),
      home: const Scaffold(backgroundColor: TColors.primary,body: Center(child: CircularProgressIndicator(color: Colors.white))),
    );
  }
}

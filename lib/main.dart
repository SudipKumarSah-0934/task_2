import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_2/core/app_theme/theme.dart';
import 'package:task_2/core/app_theme/theme_controller.dart';
import 'data/services/storage/services.dart';
import 'modules/home/binding.dart';
import 'modules/home/view.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.themeData(false, context),
      darkTheme: CustomTheme.themeData(true, context),
      themeMode: ThemeMode.system,
      home: const HomePage(),
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
      onInit: () {
        // Listen for changes in the theme mode and update the system overlay style
        ever<ThemeMode>(
          themeController.currentTheme,
          (themeMode) {
            SystemUiOverlayStyle newSystemUiOverlayStyle =
                themeMode == ThemeMode.light
                    ? SystemUiOverlayStyle.dark // Light mode: Dark icons
                    : SystemUiOverlayStyle.light; // Dark mode: Light icons
            SystemChrome.setSystemUIOverlayStyle(newSystemUiOverlayStyle);
          },
        );
      },
    );
  }
}

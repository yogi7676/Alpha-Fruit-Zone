import 'dart:io';

import 'package:alphauser/app/constants/firebase.dart';
import 'package:alphauser/app/constants/app_constants.dart';
import 'package:alphauser/app/helpers/network_manager.dart';
import 'package:alphauser/app/screens/no_internet/no_internet.dart';
import 'package:alphauser/app/screens/splash/splash.dart';
import 'package:alphauser/app/widgets/noglowbehaviour.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/controllers/app_controller.dart';
import 'app/controllers/cart_controller.dart';
import 'app/controllers/product_controller.dart';
import 'app/controllers/user_controller.dart';

void main(List<String> args) async {
  enablePlatformOverrideForDesktop();
  WidgetsFlutterBinding.ensureInitialized();
  await initialization.then((value) {
    Get.put(NetworkManager());
    Get.put(ProductController());
    Get.put(UserController());
    Get.put(AppController());
    Get.put(CartController());
  });
  runApp(AlphaUser());
}

void enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

class AlphaUser extends StatelessWidget {
  final NetworkManager manager = Get.find();
  AlphaUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(behavior: NoGlowBehaviour(), child: child!);
      },
      theme: ThemeData(
          primarySwatch: Colors.yellow,
          textTheme: GoogleFonts.openSansTextTheme()),
      debugShowCheckedModeBanner: false,
      home: GetBuilder<NetworkManager>(
          builder: (builder) => manager.connectionType == 0
              ? const NoInternet()
              : const SplashScreen()),
      title: appName,
    );
  }
}

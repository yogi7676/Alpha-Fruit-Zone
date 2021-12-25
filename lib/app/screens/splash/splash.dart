import 'package:alphauser/app/constants/assets_path.dart';
import 'package:alphauser/app/widgets/custom_text.dart';
import 'package:alphauser/app/widgets/loading.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    AssetsPath.image1,
                    height: 200,
                  ),
                ),
                Image.asset(
                  AssetsPath.image2,
                  height: 200,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText(text: 'Welcome to', size: 20),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Alpha Fruit\n Zone',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey),
                ),
                const SizedBox(
                  height: 20,
                ),
                Loading()
              ],
            ),
          ],
        ),
      ),
    );
  }
}

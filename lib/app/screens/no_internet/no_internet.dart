import 'package:alphauser/app/constants/assets_path.dart';
import 'package:alphauser/app/widgets/custom_text.dart';
import 'package:alphauser/app/widgets/space.dart';
import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alpha Fruit Zone'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage(AssetsPath.no),
              height: 250,
            ),
            Space(
              height: 50,
            ),
            CustomText(
              text: 'Oops!......',
              size: 30,
              weight: FontWeight.bold,
            ),
            Space(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: CustomText(
                text:
                    'You do not have an active internet connection. Ensure internet to continue.',
                size: 16,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
              ),
            ),
            Space(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

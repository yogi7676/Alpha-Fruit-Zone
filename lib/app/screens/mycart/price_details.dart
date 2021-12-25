import 'package:alphauser/app/constants/controllers.dart';
import 'package:alphauser/app/widgets/custom_text.dart';
import 'package:alphauser/app/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PriceDetails extends StatelessWidget {
  const PriceDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 70,
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(width: 0.5, color: Colors.grey))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Obx(
                  () => CustomText(
                    text: '\u20B9 ${(cartController.totalCartPrice.value + 99.0)}',
                    size: 16,
                    weight: FontWeight.bold,
                  ),
                ),
                const Space(
                  height: 0,
                ),
                const CustomText(
                  text: 'Total amount ',
                  size: 12,
                  color: Colors.grey,
                )
              ],
            ),
          ),
          Obx(() => SizedBox(
                height: 50,
                child: ElevatedButton(
                    onPressed: (cartController.totalCartPrice.value + 99.0) < 400
                        ? null
                        : () {},
                    child: const Text('Place Order')),
              ))
        ],
      ),
    );
  }
}

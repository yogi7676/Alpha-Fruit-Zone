import 'package:alphauser/app/constants/app_constants.dart';
import 'package:alphauser/app/models/cart_item_model.dart';
import 'package:alphauser/app/widgets/custom_image.dart';
import 'package:alphauser/app/widgets/custom_text.dart';
import 'package:alphauser/app/widgets/space.dart';
import 'package:flutter/material.dart';

class MyOrderView extends StatelessWidget {
  final CartItemModel cartItemModel;
  const MyOrderView({Key? key, required this.cartItemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: decoration(10),
                  padding: const EdgeInsets.all(15),
                  height: 100,
                  width: 100,
                  child: customImage(cartItemModel.vendorImage!, BoxFit.fill),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomText(
                        text: cartItemModel.businessname!,
                        size: 14,
                        weight: FontWeight.bold,
                      ),
                      const Space(
                        height: 5,
                      ),
                      CustomText(text: cartItemModel.productName!, size: 12),
                      const Space(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 15,
                          ),
                          const Space(
                            width: 3,
                          ),
                          Flexible(
                            child: CustomText(
                              text: cartItemModel.vendorAddress!,
                              size: 10,
                              overflow: TextOverflow.clip,
                            ),
                          )
                        ],
                      ),
                      const Space(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CustomText(
                                text: "\u20B9 " + cartItemModel.toPrice(),
                                size: 16,
                                weight: FontWeight.bold,
                              ),
                              CustomText(
                                  text: ' / ' + cartItemModel.toQuantity(),
                                  size: 14),
                              CustomText(
                                  text: cartItemModel.measure!, size: 14),
                            ],
                          ),
                          Row(
                            children: [
                              CustomText(
                                  text:
                                      'Qty : ${cartItemModel.units.toString()}',
                                  size: 12)
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 1.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  text: 'Amount to be payed : ',
                  size: 12,
                  weight: FontWeight.bold,
                ),
                CustomText(
                    text:
                        '\u20B9 ${(cartItemModel.productPrice!.toDouble()) * (cartItemModel.units!.toDouble())}',
                    size: 14)
              ],
            )
          ],
        ),
      ),
    );
  }
}

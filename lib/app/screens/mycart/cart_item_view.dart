import 'package:alphauser/app/constants/app_constants.dart';
import 'package:alphauser/app/constants/controllers.dart';
import 'package:alphauser/app/models/cart_item_model.dart';
import 'package:alphauser/app/screens/mycart/widgets/cart_item_button.dart';
import 'package:alphauser/app/widgets/custom_image.dart';
import 'package:alphauser/app/widgets/custom_text.dart';
import 'package:alphauser/app/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItemView extends StatelessWidget {
  final CartItemModel cartItemModel;
  const CartItemView({Key? key, required this.cartItemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                      const SizedBox(
                        height: 2,
                      ),
                      CustomText(text: cartItemModel.productName!, size: 12),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 15,
                          ),
                          const SizedBox(
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CartItemButton(
                                  onTap: () => cartController
                                      .decreaseQuantity(cartItemModel),
                                  icon: Icons.remove),
                              const Space(
                                width: 15,
                              ),
                              CustomText(
                                text: cartItemModel.units.toString(),
                                size: 14,
                              ),
                              const Space(
                                width: 15,
                              ),
                              CartItemButton(
                                  onTap: () => cartController
                                      .increaseQuantity(cartItemModel),
                                  icon: Icons.add)
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => cartController.removeCartItem(cartItemModel),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomText(text: 'Remove', size: 12),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

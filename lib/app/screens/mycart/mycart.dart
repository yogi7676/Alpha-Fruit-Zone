import 'package:alphauser/app/constants/controllers.dart';
import 'package:alphauser/app/helpers/network_manager.dart';
import 'package:alphauser/app/models/cart_item_model.dart';
import 'package:alphauser/app/screens/mycart/cart_item_view.dart';
import 'package:alphauser/app/screens/mycart/price_details.dart';
import 'package:alphauser/app/screens/no_internet/no_internet.dart';
import 'package:alphauser/app/widgets/custom_text.dart';
import 'package:alphauser/app/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCart extends StatelessWidget {
  final NetworkManager manager = Get.find();
  MyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NetworkManager>(
        builder: (builder) => manager.connectionType == 0
            ? const NoInternet()
            : Scaffold(
                appBar: AppBar(
                  title: const Text('My Cart'),
                ),
                body: Obx(() => userController.userModel.value.cart!.isNotEmpty
                    ? Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          ListView(
                            padding: const EdgeInsets.all(10),
                            children: [
                              const Card(
                                  child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: CustomText(
                                    text:
                                        'Add items worth \u20B9 400 before proceeding',
                                    textAlign: TextAlign.center,
                                    size: 14,
                                    overflow: TextOverflow.clip,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                              )),
                              const Space(
                                height: 25,
                              ),
                              ...List.generate(
                                  userController.userModel.value.cart!.length,
                                  (index) {
                                CartItemModel cartItemModel =
                                    userController.userModel.value.cart![index];

                                return CartItemView(
                                    cartItemModel: cartItemModel);
                              }),
                              const Space(
                                height: 50,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const CustomText(
                                    text: 'Order Details',
                                    size: 14,
                                    weight: FontWeight.bold,
                                  ),
                                  const Space(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const CustomText(
                                        text: 'Bag Total : ',
                                        size: 12,
                                        color: Colors.blueGrey,
                                      ),
                                      CustomText(
                                        text:
                                            '${cartController.totalCartPrice} ',
                                        size: 12,
                                        color: Colors.blueGrey,
                                      )
                                    ],
                                  ),
                                  const Space(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const CustomText(
                                        text: 'Delivery Charges : ',
                                        size: 12,
                                        color: Colors.blueGrey,
                                      ),
                                      CustomText(
                                        text: double.parse('99').toString(),
                                        size: 12,
                                        color: Colors.blueGrey,
                                      )
                                    ],
                                  ),
                                  const Space(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const CustomText(
                                        text: 'Total Amount : ',
                                        size: 14,
                                        weight: FontWeight.bold,
                                      ),
                                      CustomText(
                                        text: (cartController
                                                    .totalCartPrice.value +
                                                99.0)
                                            .toString(),
                                        size: 14,
                                        color: Colors.blueGrey,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const Space(
                                height: 100,
                              )
                            ],
                          ),
                          const PriceDetails()
                        ],
                      )
                    : const Center(
                        child: Text('You do not have any items added to cart'),
                      )),
              ));
  }
}

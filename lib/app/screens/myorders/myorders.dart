import 'package:alphauser/app/constants/controllers.dart';
import 'package:alphauser/app/helpers/network_manager.dart';
import 'package:alphauser/app/models/cart_item_model.dart';
import 'package:alphauser/app/screens/mycart/cart_item_view.dart';
import 'package:alphauser/app/screens/mycart/price_details.dart';
import 'package:alphauser/app/screens/myorders/widgets/my_orders_view.dart';
import 'package:alphauser/app/screens/no_internet/no_internet.dart';
import 'package:alphauser/app/widgets/custom_text.dart';
import 'package:alphauser/app/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrders extends StatelessWidget {
  final NetworkManager manager = Get.find();
  MyOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NetworkManager>(
        builder: (builder) => manager.connectionType == 0
            ? const NoInternet()
            : Scaffold(
                appBar: AppBar(
                  title: const Text('My Orders'),
                ),
                body: Obx(
                    () => userController.userModel.value.myOrders!.isNotEmpty
                        ? ListView(
                          padding: const EdgeInsets.all(10),
                          children: [
                            ...List.generate(
                                userController.userModel.value.myOrders!
                                    .length, (index) {
                              CartItemModel cartItemModel = userController
                                  .userModel.value.myOrders![index];

                              return MyOrderView(cartItemModel: cartItemModel);
                            }),
                          ],
                        )
                        : const Center(
                            child:
                                Text('You do not have any items added to cart'),
                          )),
              ));
  }
}

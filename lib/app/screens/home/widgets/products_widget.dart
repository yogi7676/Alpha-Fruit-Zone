import 'package:alphauser/app/constants/controllers.dart';
import 'package:alphauser/app/models/product.dart';
import 'package:alphauser/app/screens/home/widgets/single_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductWidget extends StatelessWidget {
  // bool isSearching;
  final String? isSearching;
  const ProductWidget({Key? key, required this.isSearching}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => GridView.count(
        crossAxisCount: 2,
        childAspectRatio: .95,
        padding: const EdgeInsets.all(10),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 10,
        children: isSearching == null
            ? productController.products.map((Product product) {
                return SingleProductWidget(
                  product: product,
                );
              }).toList()
            : productController.filterProducts(isSearching!).map((e) {
              return SingleProductWidget(product: e);
            }).toList()));
  }
}

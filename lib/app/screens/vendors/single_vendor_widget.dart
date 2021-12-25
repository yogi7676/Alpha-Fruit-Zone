import 'package:alphauser/app/constants/app_constants.dart';
import 'package:alphauser/app/constants/controllers.dart';
import 'package:alphauser/app/models/product.dart';
import 'package:alphauser/app/models/selling.dart';
import 'package:alphauser/app/models/vendor.dart';
import 'package:alphauser/app/widgets/custom_image.dart';
import 'package:alphauser/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleVendorWidget extends StatelessWidget {
  final Product product;
  final VendorModel vendor;
  final Selling selling;
  const SingleVendorWidget(this.product, this.vendor, this.selling, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: decoration(25),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(.7), blurRadius: 1)
                  ]),
              width: 90,
              height: 90,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: customImage(vendor.imageUrl!, BoxFit.fill),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Flexible(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomText(
                        text: vendor.businessName!,
                        size: 16,
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              vendor.toAddress(),
                              overflow: TextOverflow.clip,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: "\u20B9 " + selling.toPrice(),
                            size: 18,
                            weight: FontWeight.bold,
                          ),
                          CustomText(
                              text: '/' + selling.toQuantity(), size: 15),
                          CustomText(text: selling.measure!, size: 15),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (cartController.itemincart(product, selling, vendor)) {
                        cartController.removeCartItem(await cartController
                            .getCartItem(product, selling, vendor));
                      } else {
                        cartController.addProductToCart(
                            product, selling, vendor);
                      }
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: decoration(25),
                      child: Obx(() =>
                          cartController.itemincart(product, selling, vendor)
                              ? const Icon(Icons.favorite)
                              : const Icon(Icons.favorite_border)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

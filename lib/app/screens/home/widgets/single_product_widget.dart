import 'package:alphauser/app/constants/app_colors.dart';
import 'package:alphauser/app/models/product.dart';
import 'package:alphauser/app/screens/vendors/view_vendors.dart';
import 'package:alphauser/app/widgets/custom_text.dart';
import 'package:alphauser/app/helpers/string_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleProductWidget extends StatelessWidget {
  final Product product;
  const SingleProductWidget({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => ViewVendors(
            productId: product.docID!,
            productName: product.productName!,
          )),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.5),
                  offset: const Offset(3, 2),
                  blurRadius: 7)
            ]),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                // Image View
                Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.primary.withOpacity(0.4),
                  ),
                  child: SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: product.imageUrl!,
                      placeholder: (context, url) => Container(),
                    ),
                  ),
                ),
                // content view
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // productName
                          CustomText(
                            text: product.productName!.capitalizeWords,
                            size: 18,
                            weight: FontWeight.bold,
                            color: AppColors.secondary,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          // product Category
                          CustomText(
                            text: (product.category!).capitalizeWords,
                            size: 15,
                            color: AppColors.lightGray,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      margin: const EdgeInsets.only(right: 10, bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(.5),
                                offset: const Offset(3, 2),
                                blurRadius: 7)
                          ]),
                      child: const Icon(
                        CupertinoIcons.forward,
                        size: 15,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:alphauser/app/constants/controllers.dart';
import 'package:alphauser/app/helpers/network_manager.dart';
import 'package:alphauser/app/models/product.dart';
import 'package:alphauser/app/models/selling.dart';
import 'package:alphauser/app/models/vendor.dart';
import 'package:alphauser/app/screens/no_internet/no_internet.dart';
import 'package:alphauser/app/screens/vendors/single_vendor_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewVendors extends StatelessWidget {
  final String productId;
  final String productName;
  static NetworkManager manager = Get.find();
  const ViewVendors(
      {Key? key, required this.productId, required this.productName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NetworkManager>(
        builder: (builder) => manager.connectionType == 0
            ? const NoInternet()
            : Scaffold(
                appBar: AppBar(
                  title: Text('$productName vendors'),
                ),
                body: FutureBuilder<List<Map<String, QuerySnapshot>>>(
                    future: productController.getSellingProducts(productId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        var data = snapshot.data!;
                        return data.isNotEmpty
                            ? ListView.builder(
                                itemCount: data.length,
                                padding: const EdgeInsets.all(10),
                                itemBuilder: (context, index) {
                                  var a = data[index].entries.toList();
                                  QuerySnapshot snap = a[0].value;
                                  Selling? selling;
                                  VendorModel? vendor;
                                  Product? product;

                                  // selling information
                                  for (var a in snap.docs) {
                                    selling = Selling.fromFirestore(a);
                                  }
                                  // product information
                                  for (var productinfo in productController
                                      .products
                                      .where((p0) =>
                                          p0.docID == selling!.productId)) {
                                    product = productinfo;
                                  }
                                  // vendor information
                                  for (var vendorinfo in appController
                                      .vendorsList
                                      .where((p0) => p0.docID == a[0].key)) {
                                    vendor = vendorinfo;
                                  }

                                  return SingleVendorWidget(
                                      product!, vendor!, selling!);
                                })
                            : const Center(
                                child: Text(
                                    'No Vendors available for this product.'),
                              );
                      }

                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    })));
  }
}

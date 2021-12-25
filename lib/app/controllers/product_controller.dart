import 'package:alphauser/app/constants/controllers.dart';
import 'package:alphauser/app/constants/firebase.dart';
import 'package:alphauser/app/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController instance = Get.find();
  RxList<Product> products = RxList<Product>([]);
  List<Product> filterData = [];
  String collection = 'products';

  @override
  void onReady() {
    super.onReady();
    products.bindStream(getProducts());
  }

  List<Product> filterProducts(String name) {
    List<Product> result = products
        .where(
            (p0) => p0.productName!.toLowerCase().contains(name.toLowerCase()))
        .toList();

    return result;
  }

  Stream<List<Product>> getProducts() => firebaseFirestore
      .collection(collection)
      .snapshots()
      .map((event) => event.docs.map((e) => Product.fromFirestore(e)).toList());


  Future<List<Map<String, QuerySnapshot>>> getSellingProducts(productId) async {
    List<String> sellingIds = [];
    //List<QuerySnapshot> snapshot = [];
    List<Map<String, QuerySnapshot>> details = [];

    // getting seller id of product
    for (var productinfo
        in productController.products.where((p0) => p0.docID == productId)) {
      if (productinfo.sellingVendors != null) {
        sellingIds = productinfo.sellingVendors!.cast<String>();
      }
    }

    // getting seller price details from vendors collection
    if (sellingIds.isNotEmpty) {
      for (var item in sellingIds) {
        QuerySnapshot snap = await firebaseFirestore
            .collection('vendors')
            .doc(item)
            .collection('products')
            .where('productID', isEqualTo: productId)
            .get();
        details.add({item: snap});
      }
    }

    return details;
  }
}

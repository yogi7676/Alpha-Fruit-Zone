import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  static const PRODUCTNAME = "productName";
  static const PRODUCTIMAGE = "imageUrl";
  static const PRODUCTCATEGORY = "category";
  static const MEASURE = "measure";
  static const PRICE = "price";
  static const UNITS = "units";
  static const SELLINGVENDORS = 'sellingVendors';

  String? productName;
  String? imageUrl;
  String? category;
  String? measure;
  int? price;
  int? units;
  String? docID;
  List? sellingVendors;

  Product(
      {this.productName,
      this.imageUrl,
      this.category,
      this.measure,
      this.price,
      this.units});

  Product.fromFirestore(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    docID = documentSnapshot.id;
    productName = data[PRODUCTNAME];
    productName = data[PRODUCTNAME];
    imageUrl = data[PRODUCTIMAGE];
    price = data[PRICE];
    measure = data[MEASURE];
    category = data[PRODUCTCATEGORY];
    units = data[UNITS];
    sellingVendors = data[SELLINGVENDORS];
  }

  Map<String, dynamic>? toMap(Product model) {
    var data = <String, dynamic>{};
    data['productName'] = model.productName;
    data['units'] = model.units;
    data['price'] = model.price;
    data['measure'] = model.measure;
    data['imageUrl'] = model.imageUrl;
    data['category'] = model.category;
    return data;
  }

  @override
  String toString() {
    return '$productName , $category';
  }
}

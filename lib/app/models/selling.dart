import 'package:cloud_firestore/cloud_firestore.dart';

class Selling {
  static const PRODUCTID = 'productID';
  static const PRICE = 'sellingPrice';
  static const QUANTITY = 'qty';
  static const MEASURE = 'measure';

  String? productId;
  String? docId;
  double? price;
  int? quantity;
  String? measure;

  Selling({this.price, this.measure, this.quantity, this.productId});

  Selling.fromFirestore(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    docId = documentSnapshot.id;
    productId = data[PRODUCTID];
    price = data[PRICE];
    quantity = data[QUANTITY];
    measure = data[MEASURE];
  }

  Map<String, dynamic>? toFirestore(Selling model) {
    var data = <String, dynamic>{};
    data[PRODUCTID] = model.productId;
    data[PRICE] = model.price;
    data[QUANTITY] = model.quantity;
    data[MEASURE] = model.measure;
    return data;
  }

  String toQuantity() {
    return quantity == 1 ? '' : quantity.toString();
  }

  String toPrice() {
    return price!.toInt().toString();
  }

  @override
  String toString() {
    return  '$price , $quantity, $measure';
  }
}

import 'package:alphauser/app/models/cart_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  List<CartItemModel>? cart;
  List<CartItemModel>? myOrders;

  UserModel({this.cart, this.myOrders});

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    cart = _convertCartItems(data['myCart'] ?? []);
    myOrders = _convertCartItems(data['myOrders'] ?? []);
  }

  Map<String, dynamic> toFirestore() {
    var map = <String, dynamic>{};
    map['myCart'] = cart;
    map['myOrders'] = myOrders;
    return map;
  }

  List<CartItemModel> _convertCartItems(List cartFomDb) {
    List<CartItemModel> _result = [];
    if (cartFomDb.isNotEmpty) {
      for (var element in cartFomDb) {
        _result.add(CartItemModel.fromFirestore(element));
      }
    }
    return _result;
  }

  List cartItemsToJson() => cart!.map((e) => e.toMap()).toList();
}

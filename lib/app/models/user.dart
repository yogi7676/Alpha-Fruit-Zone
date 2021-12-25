import 'package:alphauser/app/models/cart_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  List<CartItemModel>? cart;

  UserModel({this.cart});

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    cart = _convertCartItems(data['myCart'] ?? []);
  }

  Map<String, dynamic> toFirestore() {
    var map = <String, dynamic>{};
    map['myCart'] = cart;
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

  List cartItemsToJson() => cart!.map((e) => e.toFirestore()).toList();
}

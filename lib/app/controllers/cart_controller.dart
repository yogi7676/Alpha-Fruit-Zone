import 'package:alphauser/app/constants/controllers.dart';
import 'package:alphauser/app/models/cart_item_model.dart';

import 'package:alphauser/app/models/product.dart';
import 'package:alphauser/app/models/selling.dart';
import 'package:alphauser/app/models/user.dart';
import 'package:alphauser/app/models/vendor.dart';
import 'package:alphauser/app/widgets/custom_snackbars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  static CartController instance = Get.find();
  RxList<CartItemModel> mycart = RxList<CartItemModel>([]);
  RxDouble totalCartPrice = 0.0.obs;

  @override
  void onReady() {
    super.onReady();
    ever(userController.userModel, changeCartTotalPrice);
  }

  void addProductToCart(Product product, Selling selling, VendorModel vendor) {
    String priceDetails = selling.quantity == 1
        ? ''
        : selling.quantity.toString() + selling.measure.toString();

    try {
      userController.updateUserData({
        "myCart": FieldValue.arrayUnion([
          {
            "image": vendor.imageUrl,
            "productName": product.productName,
            "quantity": selling.quantity,
            "productId": product.docID,
            "vendor": vendor.businessName,
            "price": selling.price,
            "address": vendor.toAddress(),
            'sellingId': selling.docId,
            'vendorId': vendor.docID,
            "measure": selling.measure,
            'priceDetails': priceDetails,
            'units': 1,
            "cost": selling.price! * 1.toDouble(),
          }
        ])
      });
      showSnackBar(
          'Cart Info', '${product.productName} was added to your cart', 1);
    } catch (e) {
      showErrorSnackBar("Cannot add this item");
    }
  }

  void removeCartItem(CartItemModel cartItem) {
    try {
      userController.updateUserData({
        "myCart": FieldValue.arrayRemove([cartItem.toFirestore()])
      });
    } catch (e) {
      showErrorSnackBar("Cannot remove this item");
    }
  }

  changeCartTotalPrice(UserModel userModel) {
    totalCartPrice.value = 0.0;
    if (userModel.cart != null && userModel.cart!.isNotEmpty) {
      userModel.cart!.forEach((element) {
        totalCartPrice.value +=
            (element.productPrice! * element.units!.toDouble());
      });
    }
  }

  bool itemincart(Product product, Selling selling, VendorModel vendor) {
    return userController.userModel.value.cart!
        .where((element) =>
            element.productId == product.docID &&
            element.vendorID == vendor.docID &&
            element.sellingId == selling.docId)
        .isNotEmpty;
  }

  void decreaseQuantity(CartItemModel item) {
    if (item.units == 1) {
      //removeCartItem(item);
    } else {
      removeCartItem(item);
      item.units = item.units! - 1;
      userController.updateUserData({
        "myCart": FieldValue.arrayUnion([item.toFirestore()])
      });
    }
  }

  void increaseQuantity(CartItemModel item) {
    removeCartItem(item);
    item.units = item.units! + 1;
    userController.updateUserData({
      "myCart": FieldValue.arrayUnion([item.toFirestore()])
    });
  }

  Future<CartItemModel> getCartItem(
      Product product, Selling selling, VendorModel vendor) async {
    late CartItemModel cartItemModel;
    userController.userModel.value.cart!
        .where((element) =>
            element.productId == product.docID &&
            element.vendorID == vendor.docID &&
            element.sellingId == selling.docId)
        .forEach((element) {
      cartItemModel = element;
    });
    return cartItemModel;
  }
}

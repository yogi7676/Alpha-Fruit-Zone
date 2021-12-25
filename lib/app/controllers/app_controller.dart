import 'package:alphauser/app/constants/firebase.dart';
import 'package:alphauser/app/models/vendor.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  static AppController instance = Get.find();
  RxList<VendorModel> vendorsList = RxList([]);

  @override
  void onReady() {
    super.onReady();
    vendorsList.bindStream(getallVendors());
  }

  Stream<List<VendorModel>> getallVendors() =>
      firebaseFirestore.collection('vendors').snapshots().map((event) =>
          event.docs.map((e) => VendorModel.fromFirestore(e)).toList());
}

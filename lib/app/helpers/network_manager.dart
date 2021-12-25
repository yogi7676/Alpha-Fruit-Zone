import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:connectivity/connectivity.dart';

class NetworkManager extends GetxController {
  int connectionType = 0;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription subscription;

  @override
  void onInit() {
    super.onInit();
    GetConnectionType();
    subscription = connectivity.onConnectivityChanged.listen(_updateState);
  }

  Future<void> GetConnectionType() async {
    var connectionResult;
    try {
      connectionResult = await (connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      print(e);
    }
    return _updateState(connectionResult);
  }

  _updateState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.none:
        connectionType = 0;
        print(connectionType);
        update();
        break;
      case ConnectivityResult.wifi:
        connectionType = 1;
        print(connectionType);
        update();
        break;
      case ConnectivityResult.mobile:
        connectionType = 2;
        print(connectionType);
        update();
        break;
      default:
        Get.snackbar('Network error', 'Failed to get network statud');
        break;
    }
  }

  @override
  void onClose() {
    super.onClose();
    subscription.cancel();
  }
}

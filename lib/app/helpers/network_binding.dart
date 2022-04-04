 
import 'package:alphauser/app/helpers/network_manager.dart';
import 'package:get/get.dart';

class NetworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkManager>(() => NetworkManager());
  }
}

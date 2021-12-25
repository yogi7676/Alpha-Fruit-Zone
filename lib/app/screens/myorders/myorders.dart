import 'package:alphauser/app/helpers/network_manager.dart';
import 'package:alphauser/app/screens/no_internet/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrders extends StatelessWidget {
  final NetworkManager manager = Get.find();
  MyOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NetworkManager>(
        builder: (builder) => manager.connectionType == 0
            ? const NoInternet()
            : Scaffold(
                appBar: AppBar(
                title: const Text('My Orders'),
              )));
  }
}

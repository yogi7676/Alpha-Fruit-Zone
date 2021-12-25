import 'dart:io';

import 'package:alphauser/app/constants/app_constants.dart';
import 'package:alphauser/app/constants/controllers.dart';
import 'package:alphauser/app/screens/mycart/mycart.dart';
import 'package:alphauser/app/screens/myorders/myorders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              UserAccountsDrawerHeader(
                accountName:
                    Text('${userController.getCurrentUser()!.phoneNumber}'),
                accountEmail: const Text(''),
                currentAccountPicture: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(
                        drawerButtons.length,
                        (index) => ListTile(
                              onTap: () {
                                Get.back();
                                switch (index) {
                                  case 0:
                                    Get.to(() => MyCart());
                                    break;
                                  case 1:
                                    Get.to(() => MyOrders());
                                    break;
                                  case 2:
                                    userController.signout();
                                    exit(1);
                                }
                              },
                              leading: Icon(drawerButtons[index].icon),
                              title: Text(drawerButtons[index].title),
                            ))
                  ],
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Text('Copyright Reserved.'),
          )
        ],
      ),
    );
  }
}

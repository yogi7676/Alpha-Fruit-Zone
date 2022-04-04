import 'package:flutter/material.dart';
import 'package:get/get.dart';

showErrorSnackBar(message) {
  Get.snackbar('Error', message,
      colorText: Colors.red, backgroundColor: Colors.white);
}

showSnackBar(title, message, seconds) {
  Get.snackbar(title, message, duration: Duration(seconds: seconds));
}

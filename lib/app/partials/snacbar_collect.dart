import 'package:flutter/material.dart';
import 'package:get/get.dart';

void snackError(String title, String content) {
  Get.snackbar(
    title,
    content,
    margin: EdgeInsets.all(10),
    backgroundColor: Colors.red,
    icon: Icon(Icons.close),
    colorText: Colors.white,
  );
}

void snackSuccess(String title, String content) {
  Get.snackbar(
    title,
    content,
    margin: EdgeInsets.all(10),
    backgroundColor: Colors.teal,
    icon: Icon(Icons.check_box),
    colorText: Colors.white,
  );
}

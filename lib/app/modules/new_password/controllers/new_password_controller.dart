import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence_app/app/partials/snacbar_collect.dart';
import 'package:presence_app/app/routes/app_pages.dart';

class NewPasswordController extends GetxController {
  TextEditingController passwordC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void updatePassword() async {
    try {
      if (passwordC.text.isNotEmpty) {
        if (passwordC.text != "password") {
          String email = auth.currentUser!.email!;

          await auth.currentUser!.updatePassword(passwordC.text);

          await auth.signOut();
          await auth.signInWithEmailAndPassword(
            email: email,
            password: passwordC.text,
          );
          Get.offAllNamed(Routes.HOME);
        } else {
          snackError(
            "Error",
            "Kata sandi tidak diizinkan",
          );
        }
      } else {
        snackError(
          "Error",
          "Kata sandi tidak boleh kosong",
        );
      }
    } catch (e) {
      print(e);
    }
  }
}

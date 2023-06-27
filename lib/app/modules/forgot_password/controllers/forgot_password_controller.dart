import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:presence_app/app/partials/snacbar_collect.dart';
import 'package:presence_app/app/routes/app_pages.dart';

class ForgotPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> lupaPassword() async {
    if (emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await auth.sendPasswordResetEmail(email: emailC.text);
        Get.offAllNamed(Routes.LOGIN);
        snackSuccess(
          "Berhasil",
          "Silahkan cek email anda untuk melakukan reset",
        );
      } catch (e) {
        snackError(
          "Gagal",
          "Pengiriman verifikasi gagal",
        );
      } finally {
        isLoading.value = false;
      }
    } else {
      isLoading.value = false;
      snackError(
        "Gagal",
        "Email tidak boleh kosong",
      );
    }
  }
}

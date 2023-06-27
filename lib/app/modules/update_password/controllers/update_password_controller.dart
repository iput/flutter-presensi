import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:presence_app/app/partials/snacbar_collect.dart';

class UpdatePasswordController extends GetxController {
  RxBool passLama = true.obs;
  RxBool passBaru = true.obs;
  RxBool retPassbaru = true.obs;
  RxBool isLoading = false.obs;

  TextEditingController passwordLama = TextEditingController();
  TextEditingController passwordBaru = TextEditingController();
  TextEditingController ulangPassword = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void updatePassword() async {
    if (passwordLama.text.isNotEmpty &&
        passwordBaru.text.isNotEmpty &&
        ulangPassword.text.isNotEmpty) {
      if (passwordBaru.text != ulangPassword.text) {
        snackError(
          "Error",
          "Password tidak sesuai",
        );
      } else {
        isLoading.value = true;
        try {
          String email = auth.currentUser!.email!;
          await auth.signInWithEmailAndPassword(
            email: email,
            password: passwordLama.text,
          );
          await auth.currentUser!.updatePassword(passwordBaru.text);
          await auth.signOut();
          await auth.signInWithEmailAndPassword(
            email: email,
            password: passwordBaru.text,
          );
          Get.back();
          snackSuccess(
            "Berhasil",
            "Update Password berhasil",
          );
        } on FirebaseException catch (e) {
          if (e.code == 'wrong-password') {
            snackError(
              "Error",
              "Password salah",
            );
          } else {
            snackError(
              "Error",
              "${e.code.toLowerCase()}",
            );
          }
        } catch (e) {
          isLoading.value = false;
          snackError(
            "Error",
            "Terjadi kesalahan internal sistem",
          );
        } finally {
          isLoading.value = false;
        }
      }
    } else {
      snackError(
        "Error",
        "Field tidak boleh dikosongkan",
      );
    }
  }
}

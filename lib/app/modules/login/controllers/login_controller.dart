import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence_app/app/partials/snacbar_collect.dart';
import 'package:presence_app/app/routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isPassword = true.obs;
  RxBool isLoading = false.obs;

  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> loginApp() async {
    if (emailC.text.isNotEmpty && passwordC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passwordC.text,
        );
        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified == true) {
            isLoading.value = false;
            if (passwordC.text == "Bismillah1926.") {
              Get.offAllNamed(Routes.NEW_PASSWORD);
            } else {
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            Get.defaultDialog(
                radius: 10,
                title: "Gagal Login",
                middleText: "Akun anda belum diverifikasi",
                actions: [
                  OutlinedButton(
                    onPressed: () {
                      isLoading.value = false;
                      Get.back();
                    },
                    child: Text("Tutup"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await userCredential.user!.sendEmailVerification();
                        Get.back();
                        snackSuccess(
                          "Berhasil",
                          "Kami telah mengirim email verifikasi kepada anda. Silahkan cek inbox email anda",
                        );
                        isLoading.value = false;
                      } catch (e) {
                        isLoading.value = false;
                        snackError(
                          "Gagal",
                          "Pengiriman verifikasi Gagal",
                        );
                      }
                    },
                    child: Text("Kirim Ulang"),
                  )
                ]);
          }
        }
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          snackError(
            "Gagal",
            "Username tidak terdaftar",
          );
        } else if (e.code == 'wrong-password') {
          snackError(
            "Gagal",
            "Username atau kata sandi tidak cocok",
          );
        }
      } catch (e) {
        snackError(
          "Gagal",
          "Terjadi kesalahan sistem. ${e.toString()}",
        );
      }
    } else {
      Get.snackbar(
        "Gagal",
        "login Tidak Bisa diproses",
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.amberAccent,
        icon: Icon(Icons.clear),
      );
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:presence_app/app/partials/snacbar_collect.dart';
import 'package:presence_app/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  RxBool isStoreData = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingInsert = false.obs;

  TextEditingController nipC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordAdmin = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> storeData() async {
    if (passwordAdmin.text.isNotEmpty) {
      isLoadingInsert.value = true;
      try {
        String emailAdmin = auth.currentUser!.email!;

        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: "Bismillah1926.",
        );

        if (userCredential.user != null) {
          isLoadingInsert.value = true;
          String? uid = userCredential.user?.uid;
          await firestore.collection("pegawai").doc(uid).set({
            "nip": nipC.text,
            "name": nameC.text,
            "email": emailC.text,
            "created_at": DateTime.now().toIso8601String(),
            "role": "pegawai",
            "profile": "",
            "uid": uid
          });
          await userCredential.user!.sendEmailVerification();
          await auth.signOut();
          UserCredential adminCredential =
              await auth.signInWithEmailAndPassword(
            email: emailAdmin,
            password: passwordAdmin.text,
          );

          // login ulang

          Get.offAllNamed(Routes.HOME);
          isLoadingInsert.value = false;
          Get.snackbar(
            "Berhasil",
            "Pegawai berhasil ditambahkan",
          );
        }
      } on FirebaseAuthException catch (e) {
        isLoadingInsert.value = false;
        if (e.code == 'weak-password') {
          Get.defaultDialog(
            title: "Error",
            middleText: "Kata sandi lemah",
          );
        } else if (e.code == "email-already-in-use") {
          Get.defaultDialog(
            title: "Error",
            middleText: "Email sudah digunakan",
          );
        }
      } catch (e) {
        isLoadingInsert.value = false;
        print(e);
      }
    } else {
      snackError(
        "Error",
        "Password tidak boleh kosong",
      );
    }
  }

  Future<void> simpanData() async {
    if (nipC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      isLoading.value = true;
      Get.defaultDialog(
          radius: 10,
          title: "Validasi password",
          content: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text("Password:"),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: passwordAdmin,
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Text("Password"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
          ),
          actions: [
            OutlinedButton(
              onPressed: () {
                isLoading.value = false;
                Get.back();
              },
              child: Text("Tutup"),
            ),
            Obx(() => ElevatedButton(
                  onPressed: () async {
                    if (isLoadingInsert.isFalse) {
                      await storeData();
                    }
                    isLoading.value = false;
                  },
                  child: Text(isLoadingInsert.isFalse ? "Simpan" : "loading.."),
                )),
          ]);
    } else {
      Get.defaultDialog(title: "Gagal", middleText: "Data ada  yang kosong");
    }
  }
}

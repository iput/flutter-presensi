import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:presence_app/app/partials/snacbar_collect.dart';
import 'package:firebase_storage/firebase_storage.dart' as store;

class ProfileUpdateController extends GetxController {
  RxBool isStoreData = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingInsert = false.obs;

  TextEditingController nipC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  store.FirebaseStorage storage = store.FirebaseStorage.instance;

  final ImagePicker picker = ImagePicker();
  XFile? image;

  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print(image!.name);
      print(image!.path);
    }
    update();
  }

  Future<void> updateProfile(String uid) async {
    if (nipC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      try {
        isLoading.value = true;
        Map<String, dynamic> data = {"name": nameC.text};
        if (image != null) {
          File file = File(image!.path);
          String ext = image!.name.split(".").last;
          await storage.ref("$uid/profile.$ext").putFile(file);
          String urlImg =
              await storage.ref("$uid/profile.$ext").getDownloadURL();
          data.addAll({"profile": urlImg});
        }
        await firestore.collection("pegawai").doc(uid).update(data);
        isLoading.value = false;
        Get.back();
        snackSuccess(
          "Berhasil",
          "Profil berhasil diupdate",
        );
      } catch (e) {
        snackError(
          "Error",
          "terjadi kesalahan sistem",
        );
      } finally {
        isLoading.value = false;
      }
    } else {
      snackError(
        "Error",
        "Field tidak boleh kosong",
      );
    }
  }
}

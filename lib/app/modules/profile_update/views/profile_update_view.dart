import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_update_controller.dart';

class ProfileUpdateView extends GetView<ProfileUpdateController> {
  final Map<String, dynamic> user = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.nipC.text = user["nip"];
    controller.nameC.text = user["name"];
    controller.emailC.text = user["email"];
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profil'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          TextField(
            readOnly: true,
            controller: controller.nipC,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              label: Text("NIP"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: controller.nameC,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              label: Text("Name"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            readOnly: true,
            controller: controller.emailC,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              label: Text("Email"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text("Foto Profil"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<ProfileUpdateController>(builder: (c) {
                if (c.image != null) {
                  return ClipOval(
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Image.file(
                        File(c.image!.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                } else {
                  if (user['profile'] != null) {
                    return ClipOval(
                      child: Container(
                        width: 100,
                        height: 100,
                        child: Image.network(
                          user['profile'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    return Text("Tidak ada data");
                  }
                }
              }),
              TextButton(
                onPressed: () {
                  controller.pickImage();
                },
                child: Text("Pilih Foto"),
              )
            ],
          ),
          SizedBox(height: 10),
          Obx(
            () => ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  await controller.updateProfile(user['uid']);
                }
              },
              child: Padding(
                padding: EdgeInsets.all(18),
                child: Text(controller.isLoading.isFalse
                    ? "Update Profile"
                    : "Loading.."),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

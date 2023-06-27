import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Password'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Obx(
            () => TextField(
              controller: controller.passwordLama,
              textInputAction: TextInputAction.next,
              obscureText: controller.passLama.value,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () => controller.passLama.toggle(),
                    icon: Icon(Icons.vpn_key),
                  ),
                  label: Text("Password Lama"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Obx(
            () => TextField(
              controller: controller.passwordBaru,
              textInputAction: TextInputAction.next,
              obscureText: controller.passBaru.value,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () => controller.passBaru.toggle(),
                    icon: Icon(Icons.vpn_key),
                  ),
                  label: Text("Password Baru"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Obx(
            () => TextField(
              controller: controller.ulangPassword,
              textInputAction: TextInputAction.done,
              obscureText: controller.retPassbaru.value,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () => controller.retPassbaru.toggle(),
                    icon: Icon(Icons.vpn_key),
                  ),
                  label: Text("Ulang Password Baru"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Obx(() => ElevatedButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.updatePassword();
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(controller.isLoading.isFalse
                      ? "Update Password"
                      : "Loading.."),
                ),
              )),
        ],
      ),
    );
  }
}

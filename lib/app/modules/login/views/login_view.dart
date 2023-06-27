import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence_app/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login Aplikasi",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: controller.emailC,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  label: Text("Email"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Obx(
                () => TextField(
                  controller: controller.passwordC,
                  obscureText: controller.isPassword.value,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      label: Text("Password"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () => controller.isPassword.toggle(),
                        icon: Icon(Icons.key),
                      )),
                ),
              ),
              SizedBox(height: 10),
              Obx(
                () => ElevatedButton(
                  onPressed: () async {
                    if (controller.isLoading.isFalse) {
                      await controller.loginApp();
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(18),
                    child: Text(controller.isLoading.isFalse
                        ? "Login"
                        : "Loading Process.."),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
                child: Text("Lupa password ?"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

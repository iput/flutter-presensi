import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presence_app/app/constants/textstyle.dart';
import 'package:presence_app/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Pegawai'),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: controller.streamUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              Map<String, dynamic> user = snapshot.data!.data()!;
              String defaultImg =
                  "https://ui-avatars.com/api/?name=${user['name']}";
              return ListView(
                padding: EdgeInsets.all(10),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Image.network(
                            user["profile"] != null
                                ? user['profile'] != ""
                                    ? user["profile"]
                                    : defaultImg
                                : defaultImg,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "${user['name'].toString().toUpperCase()}",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    "${user['email']}",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () => Get.toNamed(
                      Routes.PROFILE_UPDATE,
                      arguments: user,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.teal,
                      child: Icon(
                        Icons.person,
                      ),
                    ),
                    title: Text("Update Profile"),
                  ),
                  ListTile(
                    onTap: () => Get.toNamed(Routes.UPDATE_PASSWORD),
                    leading: CircleAvatar(
                      backgroundColor: Colors.teal,
                      child: Icon(
                        Icons.lock,
                      ),
                    ),
                    title: Text("Ubah Sandi"),
                  ),
                  if (user['role'] == 'admin')
                    ListTile(
                      onTap: () => Get.toNamed(Routes.REGISTER),
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal,
                        child: Icon(
                          Icons.person_add,
                        ),
                      ),
                      title: Text("Tambah pegawai"),
                    ),
                  ListTile(
                    onTap: () {
                      controller.signout();
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.teal,
                      child: Icon(
                        Icons.logout,
                      ),
                    ),
                    title: Text("Log out"),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text("tidak dapat memuat data"),
              );
            }
          }),
    );
  }
}

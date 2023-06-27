import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Application",
            theme: ThemeData(
                textTheme: TextTheme(
              headline1: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
              headline2: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
              headline6: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
              bodyText1: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
              bodyText2: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
            )),
            initialRoute: snapshot.data != null ? Routes.HOME : Routes.LOGIN,
            getPages: AppPages.routes,
          );
        }),
  );
}

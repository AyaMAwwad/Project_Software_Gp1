import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/locale/locale_controller.dart';

class MultiLanguage extends StatelessWidget {
  static bool isArabic = false;
  static bool isEnglish = true;
  @override
  Widget build(BuildContext context) {
    mylocalcontroller controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 95, 150, 168),
        elevation: 40,
        automaticallyImplyLeading: false,
        title: Center(
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Get.back();
                },
              ),
              SizedBox(width: 10),
              Text(
                '1'.tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 95, 150, 168),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.only(top: kToolbarHeight),
          alignment: Alignment.bottomCenter,
          child: SizedBox(height: 20),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to select language to be easily used in your app.',
                textAlign: TextAlign.center,
                style: GoogleFonts.aBeeZee(
                  // Example: Using Open Sans font
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              LanguageButton(
                label: '3'.tr,
                onPressed: () {
                  controller.changelang("en");
                  isEnglish = true;
                  isArabic = false;
                },
                //onPressed: () => controller.changelang("en"),
                // isEnglish = true;
                //  isArabic = false;
              ),
              SizedBox(height: 20),
              LanguageButton(
                label: '2'.tr,
                // onPressed: () => controller.changelang("ar"),
                onPressed: () {
                  controller.changelang("ar");
                  isEnglish = false;
                  isArabic = true;
                },
              ),
              SizedBox(height: 20),
              LanguageButton(
                label: '10'.tr,
                onPressed: () => controller.changelang("fr"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const LanguageButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            Color.fromARGB(255, 41, 70, 80), // Set the background color here
        elevation: 5,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}

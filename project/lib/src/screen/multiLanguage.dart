import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:project/locale/locale_controller.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';

class MultiLanguage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    mylocalcontroller controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text("1".tr), //Multi-Language
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                controller.changelang("en");
                // Code to switch to English language
                // You can implement your language switching logic here
              },
              child: Text("3".tr),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.changelang("ar");
                // Code to switch to Spanish language
                // You can implement your language switching logic here
              },
              child: Text("2".tr),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.changelang("fr");
                // Code to switch to French language
                // You can implement your language switching logic here
              },
              child: Text('10'.tr),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';


class mylocalcontroller extends GetxController{

 // Locale initialelang = sharepref!.getString("lang") == "ar" ? Locale("at") : Locale("en");

  void changelang(String locelang){
    Locale locale = Locale(locelang);
    //sharepref.setString("lang", locelang);
    Get.updateLocale(locale);
  }
}
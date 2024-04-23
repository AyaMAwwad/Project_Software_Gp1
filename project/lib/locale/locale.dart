import 'package:get/get.dart';

class mylocale implements Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        "ar": {
          "1": "تعدد اللغات",
          "2": "عربي",
          "3": "انجليزي",
          "4": "معلومات عن المصممين",
          "5": "تسجيل خروج",
          "6": "معلومات عن المشروع",
          "7": "تعديل المعلومات",
          "8": "ملف شخصي",
          "9": "تجربة التجارة",
          "10": "فرنسي",
        },
        "en": {
          "1": "Multi Language",
          "2": "Arabic",
          "3": "English",
          "4": "About Us",
          "5": "LogOut",
          "6": "Informations",
          "7": "Edit Profile",
          "8": "Profile",
          "9": "Trade Tryst",
          "10": "Français",
        },
        "fr": {
          "1": "Langue multiple",
          "2": "Arabe",
          "3": "Anglais",
          "4": "À propos de nous",
          "5": "Se déconnecter",
          "6": "Informations",
          "7": "Modifier le profil",
          "8": "Profil",
          "9": "Essai de commerce",
          "10": "Français",
        },
      };
}

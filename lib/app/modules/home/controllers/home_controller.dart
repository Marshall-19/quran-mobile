import 'dart:convert';

import 'package:al_quran/app/constant/color.dart';
import 'package:al_quran/app/data/db/bookmark.dart';
import 'package:al_quran/app/data/models/juz.dart';
import 'package:al_quran/app/data/models/surah.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  DatabaseManeger database = DatabaseManeger.instance;

  void changeTheme() {
    Get.isDarkMode ? Get.changeTheme(themeLight) : Get.changeTheme(themeDark);

    final box = GetStorage();

    if (Get.isDarkMode) {
      // dark ke light
      box.remove("themeDark");
    } else {
      // light ke dark
      box.write("themeDark", true);
    }
  }

  Future<List<Map<String, dynamic>>> getBookmark() async {
    Database db = await database.db;
    List<Map<String, dynamic>> allBookmark = await db.query("bookmark", where: "last_read = 0");
    return allBookmark;
  }

  Future<List<Surah>> getAllSurah() async {
    Uri url = Uri.parse("https://api.quran.sutanlab.id/surah");
    var res = await http.get(url);

    List? data = (json.decode(res.body) as Map<String, dynamic>)["data"];

    if (data == null || data.isEmpty) {
      return [];
    } else {
      return data.map((e) => Surah.fromJson(e)).toList();
    }
  }

// looping data
  Future<List<Juz>> getAllJuz() async {
    List<Juz> allJuz = [];
    for (int i = 1; i <= 30; i++) {
      Uri url = Uri.parse("https://api.quran.sutanlab.id/juz/$i");
      var res = await http.get(url);

      Map<String, dynamic> data =
          (json.decode(res.body) as Map<String, dynamic>)["data"];
      Juz juz = Juz.fromJson(data);
      allJuz.add(juz);
    }
    return allJuz;
  }
}

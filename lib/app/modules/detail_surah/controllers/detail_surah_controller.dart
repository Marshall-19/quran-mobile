import 'dart:convert';

import 'package:al_quran/app/constant/color.dart';
import 'package:al_quran/app/data/db/bookmark.dart';
import 'package:al_quran/app/data/models/detail_surah.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:sqflite/sqlite_api.dart';

class DetailSurahController extends GetxController {
  //TODO: Implement DetailSurahController

  // RxString conditionAudio = "stop".obs;

  final player = AudioPlayer();

  DatabaseManeger database = DatabaseManeger.instance;

  void addBookmark(
      bool lastRead, DetailSurah surah, Verse ayat, int indexAyat) async {
    // semua argument diatas berasal dari view detail surah
    Database db = await database.db;

    bool flagExits = false;

    if (lastRead == true) {
      await db.delete("bookmark", where: "last_read = 1");
    } else {
      List checkData = await db.query("bookmark",
          where:
              "surah = '${surah.name!.transliteration!.id!}' and ayat = ${ayat.number!.inSurah!} and index_ayat = ${indexAyat} and last_read = 0");
      if (checkData.length != 0) {
        flagExits = true;
      }
    }
    if (flagExits == false) {
      await db.insert("bookmark", {
        "surah": "${surah.name!.transliteration!.id!}",
        "ayat": ayat.number!.inSurah!,
        "index_ayat": indexAyat,
        "last_read": lastRead == true ? 1 : 0
      });

      Get.back();
      Get.snackbar("Success", "Bookmark Added", colorText: appWhite);
    } else {
      Get.back();
      Get.snackbar("Failed", "Bookmark was added", colorText: appWhite);
    }

    var result = db.query("bookmark");
    print(result);
  }

  Future<DetailSurah> getDetailSurah(String id) async {
    Uri url = Uri.parse("https://api.quran.sutanlab.id/surah/$id");
    var res = await http.get(url);

    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];

    return DetailSurah.fromJson(data);
  }

  void stopAudio(Verse ayat) async {
    try {
      await player.stop();
      ayat.conditionAudio = "stop";
      update();
      //update() untuk mengupdate conditionAudio setiap kali ada perubahan
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: "Failed",
        middleText: e.message.toString(),
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: "Failed",
        middleText: e.message.toString(),
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Failed",
        middleText: "Do Not Pause Audio",
      );
    }
  }

  void resumeAudio(Verse ayat) async {
    try {
      ayat.conditionAudio = "playing";
      update();
      await player.play();
      ayat.conditionAudio = "stop";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: "Failed",
        middleText: e.message.toString(),
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: "Failed",
        middleText: e.message.toString(),
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Failed",
        middleText: "Do Not Pause Audio",
      );
    }
  }

  void pauseAudio(Verse ayat) async {
    try {
      await player.pause();
      ayat.conditionAudio = "pause";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: "Failed",
        middleText: e.message.toString(),
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: "Failed",
        middleText: e.message.toString(),
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Failed",
        middleText: "Do Not Pause Audio",
      );
    }
  }

  void playAudio(Verse? ayat) async {
    if (ayat?.audio?.primary != null) {
      try {
        await player.stop();
        await player.setUrl(ayat!.audio!.primary!);
        ayat.conditionAudio = "playing";
        update();
        //jika diplay kodisinya berubah ke playing dr semula stop
        await player.play();
        ayat.conditionAudio = "stop";
        await player.stop();
        update();
      } on PlayerException catch (e) {
        Get.defaultDialog(
          title: "Failed",
          middleText: e.message.toString(),
        );
      } on PlayerInterruptedException catch (e) {
        Get.defaultDialog(
          title: "Failed",
          middleText: e.message.toString(),
        );
      } catch (e) {
        Get.defaultDialog(
          title: "Failed",
          middleText: "Audio Not Found",
        );
      }
    } else {
      Get.defaultDialog(
        title: "Failed",
        middleText: "Audio Not Found",
      );
    }
  }

  // untuk stop audio jika ditekan button close
  @override
  void onClose() {
    // TODO: implement onClose
    player.stop();
    player.dispose();
    super.onClose();
  }
}

import 'dart:convert';

import 'package:al_quran/app/data/models/detail_ayat.dart';
import 'package:al_quran/app/data/models/detail_surah.dart';
import 'package:al_quran/app/data/models/surah.dart';
import 'package:http/http.dart' as http;

void main() async {
  // Uri url = Uri.parse("https://api.quran.sutanlab.id/surah");
  // var res = await http.get(url);
  // // print(res.body);

  // List data = (json.decode(res.body) as Map<String, dynamic>)["data"];

  // //mengambil data dari model surah
  // Surah surah = Surah.fromJson(data[113]);

  // Uri urlS = Uri.parse("https://api.quran.sutanlab.id/surah/${surah.number}");
  // var resS = await http.get(urlS);

  // Map<String, dynamic> dataS =
  //     (json.decode(resS.body) as Map<String, dynamic>)["data"];

  // // mengambil data dari model detail surah
  // DetailSurah detailSurah = DetailSurah.fromJson(dataS);

  // print(detailSurah.verses![0].text!.arab);

  Uri urlS = Uri.parse("https://api.quran.sutanlab.id/surah/108/1");
  var resS = await http.get(urlS);
  Map<String, dynamic> dataS =
      (json.decode(resS.body) as Map<String, dynamic>)["data"];

  // print(dataS);
  DetailAyat detailAyat = DetailAyat.fromJson(dataS);
  // print(detailAyat.number?.inQuran);
}

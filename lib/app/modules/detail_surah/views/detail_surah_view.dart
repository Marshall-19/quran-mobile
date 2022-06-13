import 'package:al_quran/app/constant/color.dart';
import 'package:al_quran/app/data/models/detail_surah.dart' as detail;
// penjelasan as detail ada STUDY CASE FLUTTER ALQURAN APPS - 04 Detail Surah menit 18:30

import 'package:al_quran/app/data/models/surah.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  final Surah surah = Get.arguments;
  //mengambil data yang di parsing dari home view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${surah.name?.transliteration?.id}"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Container(
            height: 200,
            width: Get.width,
            child: Stack(
              children: [
                Positioned(
                  bottom: -90,
                  right: -20,
                  child: Opacity(
                    opacity: 0.10,
                    child: Container(
                      width: 270,
                      height: 270,
                      child: Image.asset(
                        "assets/images/alquran.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Center(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${surah.name?.transliteration?.id}",
                          style: TextStyle(color: appWhite, fontSize: 25),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "${surah.name?.translation?.en}",
                          style: TextStyle(
                              color: appWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.w200),
                        ),
                        Text(
                          "                                             ",
                          style: TextStyle(
                              color: appWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.w200,
                              decoration: TextDecoration.underline),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "${surah.revelation?.en?.toUpperCase()} - ${surah.numberOfVerses} VERSES",
                          style: TextStyle(
                              color: appWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
                          style: TextStyle(
                              color: appWhite,
                              fontSize: 27,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  appPurpleLight,
                  appPurple,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: appPurple.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 15,
                  offset: Offset(
                    5,
                    10,
                  ), // changes position of shadow
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FutureBuilder<detail.DetailSurah>(
              future: controller.getDetailSurah(surah.number.toString()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Shimmer.fromColors(
                    baseColor: Get.isDarkMode
                        ? Color.fromARGB(255, 46, 46, 46)
                        : Colors.grey.shade300,
                    highlightColor: appPurpleStrongLight,
                    // period: Duration(seconds: 5),
                    child: box(),
                  );
                }
                if (!snapshot.hasData) {
                  return Center(
                    child: Text('No Data'),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data?.verses?.length,
                  itemBuilder: (context, index) {
                    if (snapshot.data?.verses?.length == 0) {
                      return Center();
                    }
                    detail.Verse? ayat = snapshot.data?.verses?[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Get.isDarkMode
                                  ? Colors.transparent
                                  : Colors.grey.shade200),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage("assets/images/octa.png"),
                                    ),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "${index + 1}",
                                    style: TextStyle(color: appPurpleLight),
                                  )),
                                ),
                                //condition => stop : button play
                                //condition => playing : button pause and stop
                                //condition => pause : button play and stop
                                GetBuilder<DetailSurahController>(
                                  builder: (c) => Row(
                                    children: [
                                      IconButton(
                                        iconSize: 28,
                                        color: appPurpleLight,
                                        onPressed: () {
                                          Get.defaultDialog(
                                              title: "Bookmark",
                                              middleText: "Add to",
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    c.addBookmark(
                                                        true, snapshot.data!, ayat!, index);
                                                  },
                                                  child: Text("Last Read"),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              appPurpleLight),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    c.addBookmark(false, snapshot.data!, ayat!, index);
                                                  },
                                                  child: Text("Bookmark"),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              appPurpleLight),
                                                ),
                                              ]);
                                        },
                                        icon: Icon(Icons.bookmark_add_outlined),
                                      ),
                                      (ayat?.conditionAudio == 'stop')
                                          ? IconButton(
                                              iconSize: 28,
                                              color: appPurpleLight,
                                              onPressed: () =>
                                                  c.playAudio(ayat!),
                                              icon: Icon(
                                                  Icons.play_arrow_outlined),
                                            )
                                          : Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                (ayat?.conditionAudio ==
                                                        'playing')
                                                    ? IconButton(
                                                        iconSize: 28,
                                                        color: appPurpleLight,
                                                        onPressed: () =>
                                                            c.pauseAudio(ayat!),
                                                        icon: Icon(Icons.pause),
                                                      )
                                                    : IconButton(
                                                        iconSize: 28,
                                                        color: appPurpleLight,
                                                        onPressed: () => c
                                                            .resumeAudio(ayat!),
                                                        icon: Icon(Icons
                                                            .play_arrow_outlined),
                                                      ),
                                                IconButton(
                                                  iconSize: 28,
                                                  color: appPurpleLight,
                                                  onPressed: () => controller
                                                      .stopAudio(ayat!),
                                                  icon: Icon(Icons.stop),
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          "${ayat!.text?.arab}",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          "${ayat.translation?.id}",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 15, fontStyle: FontStyle.italic),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    );
                  },
                );
              }),
        ],
      ),
    );
  }
}

Widget box() {
  return Column(
    children: [
      Container(
        height: Get.height,
        margin: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 3.0),
          ],
        ),
      ),
      // Container(
      //   height: 150,
      //   margin: EdgeInsets.only(top: 10),
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     borderRadius: BorderRadius.circular(10.0),
      //     boxShadow: [
      //       BoxShadow(color: Colors.black12, blurRadius: 3.0),
      //     ],
      //   ),
      // ),
      // Container(
      //   height: 150,
      //   margin: EdgeInsets.only(top: 10),
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     borderRadius: BorderRadius.circular(10.0),
      //     boxShadow: [
      //       BoxShadow(color: Colors.black12, blurRadius: 3.0),
      //     ],
      //   ),
      // ),
    ],
  );
}

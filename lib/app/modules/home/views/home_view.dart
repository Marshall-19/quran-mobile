import 'package:al_quran/app/data/models/juz.dart' as juz;
import 'package:al_quran/app/data/models/surah.dart';
import 'package:al_quran/app/constant/color.dart';
import 'package:al_quran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: Get.isDarkMode ? 0 : 4,
        title: Text(
          'Quran App',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(Routes.SEARCH),
              icon: Icon(Icons.search))
        ],
        leading: GestureDetector(
          child: Icon(Icons.sort),
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Assalamu'alaikum",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  Text(
                    "Kota Padang, Dzuhur",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "12:15",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: appPurpleLight),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "WIB",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
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
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () => Get.toNamed(Routes.LAST_READ),
                    child: Container(
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: -30,
                            right: 10,
                            child: Opacity(
                              opacity: 0.7,
                              child: Container(
                                width: 150,
                                height: 150,
                                child: Image.asset(
                                  "assets/images/alquran.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.menu_book_rounded,
                                      color: appWhite,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Terakhir dibaca",
                                      style: TextStyle(
                                          color: appWhite, fontSize: 16),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Text(
                                  "Al-Baqarah",
                                  style: TextStyle(
                                      color: appWhite,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Ayat 3",
                                  style: TextStyle(
                                      color: appWhite,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            appPurpleLight,
                            appPurple,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TabBar(
                  indicatorColor: appPurpleLight,
                  labelColor: appPurpleLight,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                      child: Text(
                        "Surah",
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Juz",
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Bookmark",
                      ),
                    ),
                  ]),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: TabBarView(
                children: [
                  FutureBuilder<List<Surah>>(
                    future: controller.getAllSurah(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Padding(
                          padding: EdgeInsets.all(12.0),
                          child: ListView.builder(
                              itemBuilder: (BuildContext ctx, index) {
                            return Shimmer.fromColors(
                              baseColor: Get.isDarkMode
                                  ? Color.fromARGB(255, 46, 46, 46)
                                  : Colors.grey.shade300,
                              highlightColor: appPurpleStrongLight,
                              // period: Duration(seconds: 5),
                              child: box(),
                            );
                          }),
                        );
                      }
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text('No Data'),
                        );
                      }
                      // print(snapshot.data);
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Surah surah = snapshot.data![index];
                            return ListTile(
                              onTap: () {
                                Get.toNamed(Routes.DETAIL_SURAH,
                                    arguments: surah);
                                // mengirim data ke detail surah view dengan parameter surah
                              },
                              leading: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/octa.png"),
                                  ),
                                ),
                                child: Center(
                                    child: Text(
                                  "${surah.number}",
                                  style: TextStyle(color: appPurpleLight),
                                )),
                              ),
                              title: Text(
                                  "${surah.name?.transliteration?.id ?? ''}",
                                  style: TextStyle(color: appPurpleLight)),
                              subtitle: Text(
                                "${surah.numberOfVerses} ayat | ${surah.revelation?.id}",
                              ),
                              trailing: Text("${surah.name?.short ?? ''}"),
                            );
                          });
                    },
                  ),
                  FutureBuilder<List<juz.Juz>>(
                      future: controller.getAllJuz(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Padding(
                            padding: EdgeInsets.all(12.0),
                            child: ListView.builder(
                                itemBuilder: (BuildContext ctx, index) {
                              return Shimmer.fromColors(
                                baseColor: Get.isDarkMode
                                    ? Color.fromARGB(255, 46, 46, 46)
                                    : Colors.grey.shade300,
                                highlightColor: appPurpleStrongLight,
                                // period: Duration(seconds: 5),
                                child: box(),
                              );
                            }),
                          );
                        }
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text('No Data'),
                          );
                        }
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              juz.Juz detailJuz = snapshot.data![index];
                              return ListTile(
                                // onTap: () {
                                //   Get.toNamed(Routes.DETAIL_JUZ,
                                //       arguments: detailJuz);
                                // },
                                leading: Container(
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
                                    ),
                                  ),
                                ),
                                title: Text(
                                  "Juz ${index + 1}",
                                  style: TextStyle(color: appPurpleLight),
                                ),
                                subtitle: Text(
                                  "From ${detailJuz.start} to ${detailJuz.end}",
                                ),
                              );
                            });
                      }),
                  FutureBuilder<List<Map<String, dynamic>>>(
                      future: controller.getBookmark(),
                      builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: EdgeInsets.all(12.0),
                        child: ListView.builder(
                            itemBuilder: (BuildContext ctx, index) {
                          return Shimmer.fromColors(
                            baseColor: Get.isDarkMode
                                ? Color.fromARGB(255, 46, 46, 46)
                                : Colors.grey.shade300,
                            highlightColor: appPurpleStrongLight,
                            // period: Duration(seconds: 5),
                            child: box(),
                          );
                        }),
                      );
                    }
                    if (snapshot.data?.length == 0) {
                      return Center(
                        child: Text("Empty Bookmark"),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data = snapshot.data![index];
                        return ListTile(
                          onTap: () {
                            print(data);
                          },
                          title: Text("${index + 1}"),
                          leading: Text("${data['surah']}"),
                        );
                      },
                    );
                  })
                ],
              ))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.changeTheme(),
        child: Icon(
          Icons.color_lens,
          color: appWhite,
        ),
      ),
    );
  }
}

Widget box() {
  return Container(
    height: 50,
    margin: EdgeInsets.only(top: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 3.0),
      ],
    ),
  );
}

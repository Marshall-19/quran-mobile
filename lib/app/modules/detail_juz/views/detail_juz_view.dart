import 'package:al_quran/app/data/models/juz.dart' as detailJuz;
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  detailJuz.Juz juz = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Juz ${juz.juz}'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DetailJuzView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsontodartconverter/viewmodel/converter.dart';
import 'package:jsontodartconverter/viewmodel/prefs.dart';

class DrawerWidget extends StatelessWidget {
  final logic = Get.find<Preferences>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              return CheckboxListTile(
                value: logic.nullSafety.value,
                onChanged: (value) {
                  logic.nullSafety.value = value ?? false;
                  Get.find<Preferences>().dartTxt.value.text = JsonConverter.convert();
                },
                title: Text("Null Safety"),
              );
            }),
            Obx(() {
              return CheckboxListTile(
                value: logic.useFromMap.value,
                onChanged: (value) {
                  logic.useFromMap.value = value ?? false;
                  Get.find<Preferences>().dartTxt.value.text = JsonConverter.convert();
                },
                title: Text("Use fromMap-toMap"),
              );
            }),
            Obx(() {
              return CheckboxListTile(
                value: logic.typesOnly.value,
                onChanged: (value) {
                  logic.typesOnly.value = value ?? false;
                  Get.find<Preferences>().dartTxt.value.text = JsonConverter.convert();
                },
                title: Text("Types Only"),
              );
            }),
            Obx(() {
              return CheckboxListTile(
                value: logic.optionalProps.value,
                onChanged: (value) {
                  logic.optionalProps.value = value ?? false;
                  Get.find<Preferences>().dartTxt.value.text = JsonConverter.convert();
                },
                title: Text("Optional properties"),
              );
            })
          ],
        ),
      ),
    );
  }
}

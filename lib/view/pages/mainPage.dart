import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsontodartconverter/view/widgets/drawerWidget.dart';
import 'package:jsontodartconverter/view/widgets/formField.dart';
import 'package:jsontodartconverter/viewmodel/converter.dart';
import 'package:jsontodartconverter/viewmodel/prefs.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    Timer? _debounce;
    return GetBuilder<Preferences>(initState: (_) async {
      Get.put(Preferences());
      await Get.find<Preferences>().getPrefs();
    }, builder: (logic) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Json To Dart"),
        ),
        drawer: DrawerWidget(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FormFieldWidget(controller: Get.find<Preferences>().modelNameTxt.value, labelText: "Model Name"),
              Row(
                children: [
                  Flexible(
                    child: FormFieldWidget(
                      controller: Get.find<Preferences>().jsonTxt.value,
                      labelText: "Json",
                      maxLines: 30,
                      onChanged: (value) {
                        if (_debounce?.isActive ?? false) _debounce?.cancel();
                        _debounce = Timer(const Duration(milliseconds: 500), () {
                          Get.find<Preferences>().dartTxt.value.text = JsonConverter.convert();
                        });
                      },
                    ),
                  ),
                  Flexible(
                    child: FormFieldWidget(
                      controller: Get.find<Preferences>().dartTxt.value,
                      labelText: "Dart",
                      maxLines: 30,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Get.find<Preferences>().jsonTxt.value.text = JsonConverter.beautify();
                        },
                        child: Text("Beautify")),
                    ElevatedButton(
                        onPressed: () {
                          Get.find<Preferences>().dartTxt.value.text = JsonConverter.convert();
                        },
                        child: Text("Convert")),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

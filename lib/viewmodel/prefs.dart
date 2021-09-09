import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jsontodartconverter/viewmodel/converter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences extends GetxController {
  var nullSafety = true.obs;
  var useFromMap = false.obs;
  var typesOnly = false.obs;
  var optionalProps = false.obs;
  var jsonTxt = TextEditingController().obs;
  var dartTxt = TextEditingController().obs;
  var modelNameTxt = TextEditingController(text: "Example").obs;

  savePrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("jsonData", jsonTxt.value.text);
    await prefs.setString("modelName", modelNameTxt.value.text);
    await prefs.setBool("nullSafety", nullSafety.value);
    await prefs.setBool("useFromMap", useFromMap.value);
    await prefs.setBool("typesOnly", typesOnly.value);
    await prefs.setBool("optionalProps", optionalProps.value);
  }

  getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    jsonTxt.value.text = prefs.getString("jsonData") ?? "";
    modelNameTxt.value.text = prefs.getString("modelName") ?? "Example";
    nullSafety.value = prefs.getBool("nullSafety") ?? true;
    useFromMap.value = prefs.getBool("useFromMap") ?? false;
    typesOnly.value = prefs.getBool("typesOnly") ?? false;
    optionalProps.value = prefs.getBool("optionalProps") ?? false;
    dartTxt.value.text = JsonConverter.convert();
  }
}

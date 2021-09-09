import 'dart:convert';

import 'package:get/get.dart';
import 'package:jsontodartconverter/viewmodel/prefs.dart';

class JsonConverter {
  static String convert() {
    var json = Get.find<Preferences>().jsonTxt.value.text;
    var modelName = Get.find<Preferences>().modelNameTxt.value.text;
    try {
      if (json != "") {
        var converted = "";
        var variables = "";
        var decodedJson = jsonDecode(json);
        Map<String, dynamic> map = {};
        if (decodedJson is List)
          map = decodedJson.first;
        else
          map = decodedJson;
        converted = """class $modelName{
    $modelName({
    """;
        map.forEach((key, value) {
          key = key.replaceAll("_", "");
          key = key.toLowerCase();
          converted += "        this.$key,\n";
          variables += "  ${value.runtimeType}${Get.find<Preferences>().nullSafety.value ? "?" : ""} $key;\n";
        });
        converted += "});\n\n";
        converted += "$variables\n";
        if (!Get.find<Preferences>().typesOnly.value) {
          converted += "factory $modelName.${Get.find<Preferences>().useFromMap.value ? "fromMap" : "fromJson"}(Map<String, dynamic> json) => $modelName(\n";
          map.forEach((key, value) {
            var temp = key.replaceAll("_", "");
            temp = temp.toLowerCase();
            converted += "        $temp: json['$key'] ${Get.find<Preferences>().optionalProps.value ? "?? null" : ""},\n";
          });
          converted += ");\n\n";
          converted += "  Map<String, dynamic> ${Get.find<Preferences>().useFromMap.value ? "toMap" : "toJson"}() => {\n";
          map.forEach((key, value) {
            var temp = key.replaceAll("_", "");
            temp = temp.toLowerCase();
            converted += "        '$key': $temp ${Get.find<Preferences>().optionalProps.value ? "?? null" : ""},\n";
          });
          converted += "  };\n";
        }

        converted += "}";
        Get.find<Preferences>().savePrefs();
        return converted;
      }
      return "";
    } catch (e) {
      Get.snackbar("Error", "Invalid JSON Data");
      throw Exception(e);
    }
  }

  static String beautify() {
    var json = Get.find<Preferences>().jsonTxt.value.text;
    if (json != "") {
      const JsonDecoder decoder = JsonDecoder();
      const JsonEncoder encoder = JsonEncoder.withIndent('  ');
      final dynamic object = decoder.convert(json);
      final dynamic prettyString = encoder.convert(object);
      json = "";
      prettyString.split('\n').forEach((dynamic element) => json += "$element\n");
    }
    return json;
  }
}

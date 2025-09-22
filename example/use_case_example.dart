import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

class Storage<T> {
  File file;
  JsonConverter<T, Map<String, dynamic>> converter;

  Storage({required this.converter, required String location})
    : file = File(location);

  Future<T> load() async {
    var fileContents = await file.readAsString();

    var someDecodedJson = jsonDecode(fileContents);

    var object = converter.fromJson(someDecodedJson);

    return object;
  }

  Future save(T object) async {
    var json = converter.toJson(object);

    var jsonString = jsonEncode(json);

    await file.writeAsString(jsonString);
  }
}

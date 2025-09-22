Generates `JsonConverter<T, Map<String, dynamic>>` classes for types that implement `fromJson` and `toJson` methods.

## Usage

Add the `@AutoJsonConverter()` annotation to a class that implements `fromJson` and `toJson`:

```dart
import 'package:auto_json_converter/auto_json_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auto_json_converter_example.g.dart';

@JsonSerializable()
@AutoJsonConverter()
class Example {
  String name;

  Example(this.name);

  factory Example.fromJson(Map<String, dynamic> json) =>
      _$ExampleFromJson(json);

  Map<String, dynamic> toJson() => _$ExampleToJson(this);
}
```

You can then use the generated converter however you'd like. For example to work around generic constraint limitations:
```dart
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
```

Which would then allow you to do:
```dart
void main() async {
  var exampleStorage = Storage<Example>(
    converter: ExampleConverter(),
    location: 'ExampleFile.Json',
  );

  var example = Example('test');

  try {
    example = await exampleStorage.load();
  } catch (_) {}

  example.name = 'new name';

  await exampleStorage.save(example);
}
```

Generates `JsonConverter<T, Map<String, dynamic>>` classes for types that implement `fromJson` and `toJson` methods.

## Set-up

First follow the setup steps for the [json_serializable](https://pub.dev/packages/json_serializable) package.

Then add the following dependencies to your `pubspec.yaml`:
```yaml
dependencies:
  auto_json_converter_annotations: ^1.0.1

dev_dependencies:
  auto_json_converter: ^2.0.2
```

## Usage

Add the `@AutoJsonConverter()` annotation from [auto_json_converter_annotations](https://pub.dev/packages/auto_json_converter_annotations) to a class that implements `fromJson` and `toJson`:

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
You can then run the [build_runner](https://pub.dev/packages/build_runner) via `dart run build_runner` to generate the converters.

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

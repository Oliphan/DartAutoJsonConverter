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

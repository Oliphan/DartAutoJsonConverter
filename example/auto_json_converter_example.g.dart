// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auto_json_converter_example.dart';

// **************************************************************************
// AutoJsonConverterGenerator
// **************************************************************************

class ExampleConverter extends JsonConverter<Example, Map<String, dynamic>> {
  const ExampleConverter();

  @override
  Example fromJson(Map<String, dynamic> json) => Example.fromJson(json);

  @override
  Map<String, dynamic> toJson(Example object) => object.toJson();
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Example _$ExampleFromJson(Map<String, dynamic> json) =>
    Example(json['name'] as String);

Map<String, dynamic> _$ExampleToJson(Example instance) => <String, dynamic>{
  'name': instance.name,
};

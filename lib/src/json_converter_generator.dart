import 'package:analyzer/dart/element/element.dart';
import 'package:auto_json_converter_annotations/auto_json_converter_annotations.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class AutoJsonConverterGenerator
    extends GeneratorForAnnotation<AutoJsonConverter> {
  @override
  generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) return null;

    final className = element.name;
    final converterName = '${className}Converter';

    return '''
class $converterName extends JsonConverter<$className, Map<String, dynamic>> {
  const $converterName();

  @override
  $className fromJson(Map<String, dynamic> json) => $className.fromJson(json);

  @override
  Map<String, dynamic> toJson($className object) => object.toJson();
}
''';
  }
}

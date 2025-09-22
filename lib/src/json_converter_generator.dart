import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'auto_json_converter_annotation.dart';

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

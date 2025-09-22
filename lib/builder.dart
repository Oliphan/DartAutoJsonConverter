import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/json_converter_generator.dart';

Builder autoJsonConverterBuilder(BuilderOptions options) =>
    SharedPartBuilder([AutoJsonConverterGenerator()], 'auto_json_converter');

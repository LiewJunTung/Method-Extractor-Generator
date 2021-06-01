import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/generator.dart';

Builder methodExtractorBuilder(BuilderOptions options) => LibraryBuilder(
    MethodExtractorGenerator(),
    formatOutput: (generated) => generated.replaceAll(RegExp(r'//.*|\s'), ''),
    generatedExtension: '.method.gen.json');

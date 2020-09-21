import 'dart:async';

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class CustomBuilder extends Builder {
  List<Generator> generators;

  CustomBuilder(this.generators);

  @override
  FutureOr<void> build(BuildStep buildStep) async {



    var inputLibrary = await buildStep.inputLibrary;
    var libraryReader = LibraryReader(inputLibrary);
    for (var generator in generators) {
      var str = await generator.generate(libraryReader, buildStep);
      if (str != null && str.isNotEmpty) {
        AssetId inputId = buildStep.inputId;
        var copyAssetId = inputId.changeExtension('.gen.json');
        await buildStep.writeAsString(copyAssetId, str);
      }
    }
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        '.dart': ['.gen.json']
      };
}

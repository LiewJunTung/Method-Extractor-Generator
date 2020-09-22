import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/build.dart';
import 'package:method_extractor/method_extractor.dart';
import 'package:source_gen/source_gen.dart';

class MethodExtractorGenerator extends GeneratorForAnnotation<MethodExtractor> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element.metadata.isNotEmpty) {
      var visitor = CheckNativeAnnotation();
      element.visitChildren(visitor);
      return jsonEncode({'name': 'GeneratedFlutterVerifytPlatformSDK', 'methods': visitor.methodList});
    } else {
      return null;
    }
  }
}

class CheckNativeAnnotation extends SimpleElementVisitor {
  List<String> methodList = [];

  @override
  void visitMethodElement(MethodElement element)  => _extractMethod(element);

  @override
  visitPropertyAccessorElement(PropertyAccessorElement element) => _extractMethod(element);

  _extractMethod(Element element){
    var extractedMethod = element.metadata
        .any((element) => element.element.name == 'extractMethod');
    print(element.name);
    print(element.metadata);
    if (extractedMethod) {
      methodList.add(element.name);
    };
  }
}

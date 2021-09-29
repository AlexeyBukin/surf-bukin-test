import 'package:analyzer/dart/element/element.dart';

extension MetadataReader on ClassElement {
  List<ConstructorElement> get meta =>
      metadata.map((a) => a.element).whereType<ConstructorElement>().toList();

  ConstructorElement? get screenAnnotation {
    final screenAnnotations = meta
        .where((element) => element.returnType.toString() == 'Screen')
        .toList();
    return screenAnnotations.isEmpty ? null : screenAnnotations.first;
  }

  bool get hasScreenAnnotation => screenAnnotation != null;

  String get screenMetaParameters {
    return metadata
        .where((a) => a.element is ConstructorElement)
        .where((a) =>
            (a.element as ConstructorElement).returnType.toString() == 'Screen')
        .map(screenElementAnnotationToString)
        .join();
  }

  String screenElementAnnotationToString(ElementAnnotation elementAnnotation) {
    final elementValue = elementAnnotation.computeConstantValue();
    if (elementValue == null) {
      return '-';
    }

    final specification = elementValue.getField('specification')?.toStringValue();
    final design = elementValue.getField('design')?.toStringValue();
    final from = elementValue.getField('from')?.toListValue();
    final to = elementValue.getField('to')?.toListValue();
    final dialogs = elementValue.getField('dialogs')?.toListValue();

    return '''
    specification: $specification,
    design: $design,
    from: $from,
    to: $to,
    dialogs: $dialogs,
    ''';
  }
}

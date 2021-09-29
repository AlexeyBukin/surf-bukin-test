import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as path;
import 'package:surf/analyzer/metadata_reader.dart';

Future<void> main() async {
  const someDirectory = '/home/alex/work/surf_bukin_test';

  final starter = AnalysisStarter(directory: someDirectory);
  await starter.analyzeProject();
}

/// Starts analysis of chosen package in directory
class AnalysisStarter {
  final String directory;
  final Logger log;

  late final AnalysisContextCollection contextCollection;

  AnalysisStarter({required this.directory}) : log = Logger();

  /// Analyzes 'lib' folder of chosen project
  Future<void> analyzeProject() async {
    final dir = Directory(path.join(directory, 'lib'));
    final list = dir.listSync(recursive: true, followLinks: false);
    final files = list.whereType<File>().where((file) => file.path.length > 3).toList();
    final dirs = list.whereType<Directory>();

    contextCollection = AnalysisContextCollection(
        includedPaths: dirs.map((e) => e.path).toList()..add(dir.path));

    final work = files.map(analyzeLibrary);
    final annotatedClassesIterables = await Future.wait(work);
    final annotatedClasses =
        annotatedClassesIterables.expand((i) => i).toList();

    annotatedClasses.map(classToString).forEach(log.d);
  }

  String classToString(ClassElement element) {
    final path = element.librarySource.uri.toString();
    final name = element.displayName;
    final doc = element.documentationComment;
    // final meta = element.metadata;
    final meta = element.screenMetaParameters;
    return [path, doc, name, meta].whereType<String>().join('\n');
    // return '''
    // $path
    // $doc
    // $meta
    // $name
    // ''';
  }

  /// Analyzes one library (file)
  Future<Iterable<ClassElement>> analyzeLibrary(File libraryFile) async {
    final analysisContext =
        contextCollection.contextFor(libraryFile.parent.path);
    final session = analysisContext.currentSession;
    final library = await session.getResolvedLibrary(libraryFile.path);
    if (library is ResolvedLibraryResult) {
      final annotatedClasses = library.element.topLevelElements
          .whereType<ClassElement>()
          .where((c) => MetadataReader(c).hasScreenAnnotation);
      return annotatedClasses;
    } else {
      log.w('$libraryFile: something went wrong');
      return [];
    }
  }
}
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:encore_annotations/encore_annotations.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as path;

@screen
Future<void> main() async {
  const someDirectory = '/home/alex/work/surf_bukin_test';

  final starter = AnalysisStarter(directory: someDirectory);
  await starter.analyzeProject();
}

/// Starts analysis of chosen package in directory
@screen
class AnalysisStarter {
  final String directory;
  final Logger log;

  late final AnalysisContextCollection contextCollection;

  AnalysisStarter({required this.directory}) : log = Logger();

  /// Analyzes 'lib' folder of chosen project
  Future<void> analyzeProject() async {
    final dir = Directory(path.join(directory, 'lib'));
    final list = dir.listSync(recursive: true, followLinks: false);
    final files = list.whereType<File>().toList();
    final dirs = list.whereType<Directory>();

    contextCollection = AnalysisContextCollection(
        includedPaths: dirs.map((e) => e.path).toList()..add(dir.path));

    final work = files.map(analyzeLibrary);
    final annotatedClassesIterables = await Future.wait(work);
    final annotatedClasses =
        annotatedClassesIterables.expand((i) => i).toList();

    log.d(annotatedClasses);
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
          .where((element) => element.metadata
              .any((annotation) => annotation.element?.name == 'screen'));
      return annotatedClasses;
    } else {
      log.w('$libraryFile: something went wrong');
      return [];
    }
  }
}

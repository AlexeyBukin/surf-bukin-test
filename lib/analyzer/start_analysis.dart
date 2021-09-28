import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:logger/logger.dart';

const someDirectory = '/home/alex/work/surf_bukin_test';
const someLibrary = '/home/alex/work/surf_bukin_test/lib/analyzer/start_analysis.dart';

Future<void> main() async {
  final logger = Logger(level: Level.verbose);
  logger.d('logger created');
  final contextCollection = AnalysisContextCollection(includedPaths: [someDirectory]);
  logger.d('contextCollection created');
  final analysisContext = contextCollection.contextFor(someDirectory);
  final session = analysisContext.currentSession;
  final library = await session.getResolvedLibrary(someLibrary);
  if (library is ResolvedLibraryResult) {
    final libraryElement = library.element;
    final restoredUri = libraryElement.source.uri.toString();
    logger.d('lets go!');
    logger.d(library.units.first.content);
    logger.d(libraryElement.name);
    logger.d(libraryElement.topLevelElements);
  } else {
    logger.d('something went wrong');
  }
}

// Uses analysis driver to get info about file
class AnalysisStarter {
  static void lmao() async {
    final contextCollection = AnalysisContextCollection(includedPaths: []);

    final analysisContext = contextCollection.contextFor(someDirectory);
    final session = analysisContext.currentSession;
    final library = await session.getResolvedLibrary(someLibrary);
    if (library is ResolvedLibraryResult) {
      final libraryElement = library.element;
      final restoredUri = libraryElement.source.uri.toString();
    }
  }
}
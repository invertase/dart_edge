import 'implementation.dart';

class MemoryFileImplementation extends MemoryFsImplementation {
  List<int> bytes = [];
  DateTime lastAccessed = DateTime.now();
  DateTime lastModified = DateTime.now();
}

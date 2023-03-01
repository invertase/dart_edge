import 'package:edge_io/src/file_systems/map_based/map_based_file_system.dart';

class MemoryFileImplementation extends MapBasedFsFileImplementation {
  List<int> bytes = [];
  DateTime lastAccessed = DateTime.now();
  DateTime lastModified = DateTime.now();
  DateTime changed = DateTime.now();
}

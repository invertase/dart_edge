// part of edge_io.memory;

// class MemoryDirectory extends MemoryFsEntity implements Directory {
//   final String _path;
//   final Iterable<String> _segments;

//   MemoryDirectory(super.overrides, this._path) : _segments = _path.split('/');

//   @override
//   Future<Directory> create({bool recursive = false}) async {
//     createSync(recursive: recursive);
//     return this;
//   }

//   @override
//   void createSync({bool recursive = false}) {
    
//   }

//   @override
//   Future<Directory> createTemp([String? prefix]) async {
//     return Future.value(createTempSync(prefix));
//   }

//   @override
//   Directory createTempSync([String? prefix]) {
//     // TODO: implement createTempSync
//   }

//   @override
//   Stream<FileSystemEntity> list(
//       {bool recursive = false, bool followLinks = true}) {
//     // TODO: implement list
//     throw UnimplementedError();
//   }

//   @override
//   List<FileSystemEntity> listSync(
//       {bool recursive = false, bool followLinks = true}) {
//     // TODO: implement listSync
//     throw UnimplementedError();
//   }
// }

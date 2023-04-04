import 'dart:io';

import 'memory_fse.dart';

class MemoryLink extends MemoryFSE<Link> implements Link {
  MemoryLink(super.fs, super.path, super.type);

  @override
  Future<Link> create(String target, {bool recursive = false}) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  void createSync(String target, {bool recursive = false}) {
    // TODO: implement createSync
  }

  @override
  Link ctor(String path) {
    // TODO: implement ctor
    throw UnimplementedError();
  }

  @override
  // TODO: implement size
  int get size => throw UnimplementedError();

  @override
  Future<String> target() {
    // TODO: implement target
    throw UnimplementedError();
  }

  @override
  String targetSync() {
    // TODO: implement targetSync
    throw UnimplementedError();
  }

  @override
  Future<Link> update(String target) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  void updateSync(String target) {
    // TODO: implement updateSync
  }
}

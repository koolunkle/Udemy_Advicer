import 'dart:async';

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platform/platform.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  setUpAll(() async {
    final robotoFont = _loadMaterialFont('Roboto-Regular.ttf');

    final fontLoader = FontLoader('Roboto')..addFont(robotoFont);
    await fontLoader.load();
  });

  await testMain();
}

Future<ByteData> _loadMaterialFont(String fontName) {
  const FileSystem fs = LocalFileSystem();
  const Platform platform = LocalPlatform();

  final flutterRoot = fs.directory(platform.environment['FLUTTER_ROOT']);

  final font = flutterRoot.childFile(
    fs.path.join('bin', 'cache', 'artifacts', 'material_fonts', fontName),
  );

  final bytes = Future<ByteData>.value(
    font.readAsBytesSync().buffer.asByteData(),
  );

  return bytes;
}

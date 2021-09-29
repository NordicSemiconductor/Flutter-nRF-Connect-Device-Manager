import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:mcumgr_flutter/mcumgr_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;

import 'model/manifest.dart';

class UpdateScreen extends StatelessWidget {
  final String asset;

  UpdateScreen({Key? key, required this.asset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update'),
      ),
      body: FutureBuilder(
          future: _unpackData(context, asset),
          builder: (c, a) {
            if (a.hasData) {
              return Container();
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Future<Map<int, Uint8List>> _unpackData(
      BuildContext context, String asset) async {
    final d = await DefaultAssetBundle.of(context).load(asset);
    final buffer = d.buffer;
    final tmpDir = await getTemporaryDirectory();

    final uuid = Uuid().v4();

    final dirPath = p.join(tmpDir.path, uuid);
    final dir = Directory(dirPath);
    await dir.create(recursive: true);

    final filePath = p.join(dirPath, '$uuid.zip');

    final file = File(filePath);
    await file
        .writeAsBytes(buffer.asUint8List(d.offsetInBytes, d.lengthInBytes));

    await ZipFile.extractToDirectory(zipFile: file, destinationDir: dir);

    final manifestFile = File(p.join(dirPath, 'Manifest.json'));
    final Map<String, dynamic> content =
        json.decode(await manifestFile.readAsString());
    final Manifest manifest = Manifest.fromJson(content);
    final Map<int, Uint8List> fwScheme = {};
    manifest.files.forEach((section) async {
      final filePath = p.join(manifestFile.parent.path, section.file);
      final fileContent = await File(filePath).readAsBytes();
      final part = section.image;
      fwScheme[part] = fileContent;
    });

    return fwScheme;
  }
}

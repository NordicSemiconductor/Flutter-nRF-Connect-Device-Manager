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
  final String deviceId;

  UpdateScreen({Key? key, required this.asset, required this.deviceId})
      : super(key: key);

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
              final uManager = a.data as UpdateManager;

              final logStream = uManager.logMessageStream;
              final stateStream = uManager.updateStateStream;
              final progressStream = uManager.progressStream;

              return Column(
                children: [
                  _buildStateStreamBuilder(stateStream),
                  _buildProgressIndicator(progressStream),
                  _buildLogView(logStream),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  StreamBuilder<McuLogMessage> _buildLogView(Stream<McuLogMessage> logStream) =>
      StreamBuilder(stream: logStream, builder: (c, a) => Container());

  StreamBuilder<ProgressUpdate> _buildProgressIndicator(
          Stream<ProgressUpdate> progressStream) =>
      StreamBuilder(
          stream: progressStream,
          builder: (c, a) {
            if (a.connectionState == ConnectionState.active && a.hasData) {
              final progressData = a.data!;
              final progress = progressData.bytesSent.toDouble() /
                  progressData.imageSize.toDouble();
              return LinearProgressIndicator(value: progress);
            } else if (a.connectionState == ConnectionState.done) {
              return LinearProgressIndicator(value: 1);
            } else {
              return LinearProgressIndicator();
            }
          });

  StreamBuilder<FirmwareUpgradeState> _buildStateStreamBuilder(
          Stream<FirmwareUpgradeState> stateStream) =>
      StreamBuilder(
          stream: stateStream,
          builder: (c, a) {
            if (a.connectionState == ConnectionState.active && a.hasData) {
              final state = a.data!;
              return Text(
                state.toString(),
                style: Theme.of(c).textTheme.subtitle1,
              );
            } else if (a.connectionState == ConnectionState.done) {
              return Text(
                'Done',
                style: Theme.of(c).textTheme.subtitle1,
              );
            } else {
              return Text(
                'Waiting',
                style: Theme.of(c).textTheme.subtitle1,
              );
            }
          });

  Future<UpdateManager> _unpackData(BuildContext context, String asset) async {
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

    final manifestFile = File(p.join(dirPath, 'manifest.json'));
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

    final updateManager = await McuMgrUpdateManagerFactory().create(deviceId);
    await updateManager.multicoreUpdate(fwScheme);
    return updateManager;
  }
}

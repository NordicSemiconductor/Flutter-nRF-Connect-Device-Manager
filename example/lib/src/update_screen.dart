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
import 'package:tuple/tuple.dart';

import 'model/manifest.dart';

class UpdateScreen extends StatefulWidget {
  final String asset;
  final String deviceId;

  UpdateScreen({Key? key, required this.asset, required this.deviceId})
      : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  List<Tuple2<int, Uint8List>> fwScheme = [];
  late Stream<FirmwareUpgradeState>? stateStream;
  FirmwareUpdateManager? uManager;
  late Stream<ProgressUpdate> progressStream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update'),
      ),
      body: _buildMainBody(context),
    );
  }

  @override
  void dispose() async {
    await uManager?.kill();
    super.dispose();
  }

  Widget _buildMainBody(BuildContext context) {
    if (uManager == null) {
      return FutureBuilder(
          future: _unpackData(context, widget.asset),
          builder: (c, a) {
            if (a.hasData) {
              uManager = a.data as FirmwareUpdateManager;

              stateStream = uManager!.updateStateStream;
              progressStream = uManager!.progressStream;
              return _buildDefaultBody();
            } else {
              return Center(child: CircularProgressIndicator());
            }
          });
    } else {
      return _buildDefaultBody();
    }
  }

  Column _buildDefaultBody() {
    return Column(
      children: [
        _buildStateStreamBuilder(stateStream!, uManager!),
        _buildProgressIndicator(progressStream),
      ],
    );
  }

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

  void _retry() async {
    setState(() {
      stateStream = uManager!.setup();
    });
    await uManager!.update(fwScheme);
  }

  StreamBuilder<FirmwareUpgradeState> _buildStateStreamBuilder(
          Stream<FirmwareUpgradeState> stateStream, FirmwareUpdateManager um) =>
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
            } else if (a.hasError) {
              return Column(
                children: [
                  Text('Error: ${a.error.toString()}'),
                  ElevatedButton(onPressed: _retry, child: Text('Retry'))
                ],
              );
            } else {
              return Text(
                'Waiting',
                style: Theme.of(c).textTheme.subtitle1,
              );
            }
          });

  Future<FirmwareUpdateManager> _unpackData(
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

    final manifestFile = File(p.join(dirPath, 'manifest.json'));
    final Map<String, dynamic> content =
        json.decode(await manifestFile.readAsString());
    final Manifest manifest = Manifest.fromJson(content);

    manifest.files.forEach((section) async {
      final filePath = p.join(manifestFile.parent.path, section.file);
      final fileContent = await File(filePath).readAsBytes();
      final part = section.image;
      fwScheme.add(Tuple2(part, fileContent));
    });

    final updateManager =
        await FirmwareUpdateManagerFactory().getUpdateManager(widget.deviceId);
    updateManager.setup();
    await updateManager.update(fwScheme);
    return updateManager;
  }
}

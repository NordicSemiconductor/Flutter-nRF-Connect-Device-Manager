import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mcumgr_flutter_example/src/model/firmware_image.dart';
import 'package:mcumgr_flutter_example/src/model/firmware_update_request.dart';
import 'package:mcumgr_flutter_example/src/providers/firmware_update_request_provider.dart';
import 'package:mcumgr_flutter_example/src/repository/firmware_image_repository.dart';
import 'package:provider/provider.dart';

class FirmwareList extends StatelessWidget {
  final repository = FirmwareImageRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Firmware List')),
        body: _body(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Navigator.pop(context, 'Firmware');
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['zip', 'bin'],
            );
            if (result == null) {
              return;
            }
            final ext = result.files.first.extension;
            final fwType = ext == 'zip'
                ? FirmwareType.multiImage
                : FirmwareType.singleImage;

            final firstResult = result.files.first;
            final file = File(firstResult.path!);
            final bytes = await file.readAsBytes();

            final fw = LocalFirmware(
                data: bytes, type: fwType, name: firstResult.name);

            context.read<FirmwareUpdateRequestProvider>().setFirmware(fw);
            Navigator.pop(context);
          },
          child: const Icon(Icons.add),
        ));
  }

  Container _body() {
    return Container(
      child: FutureBuilder(
          future: repository.getFirmwareImages(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<Application> apps = snapshot.data.applications;
              return _listBuilder(apps);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget _listBuilder(List<Application> apps) {
    return ListView.builder(
      itemCount: apps.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(apps[index].appName),
          onTap: () {
            final app = apps[index];
            final version = app.versions[0];
            final board = version.board[0];
            final firmware = board.buildConfig[0];

            final selectedFW = RemoteFirmware(
              application: app,
              version: version,
              board: board,
              firmware: firmware,
            );
            context
                .read<FirmwareUpdateRequestProvider>()
                .setFirmware(selectedFW);
            Navigator.pop(context, 'Firmware $index');
          },
        );
      },
    );
  }
}

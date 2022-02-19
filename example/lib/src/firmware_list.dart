import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mcumgr_flutter_example/src/update_screen.dart';
import 'package:path/path.dart' as p;

class FirmwareList extends StatelessWidget {
  final String deviceId;
  const FirmwareList({Key? key, required this.deviceId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firmware List'),
      ),
      body: FutureBuilder(
          future:
              rootBundle.loadString('AssetManifest.json'),
          builder: (c, a) {
            if (!a.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              final data = a.data;
              final json = jsonDecode(data as String);
              final images = json.keys.toList();

              return ListView.separated(
                  separatorBuilder: (c, i) => Divider(),
                  itemCount: images.length,
                  itemBuilder: (c, i) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              c,
                              MaterialPageRoute(
                                  builder: (c) => UpdateScreen(
                                        asset: images[i],
                                        deviceId: deviceId,
                                      )));
                        },
                        child: ListTile(
                          title: Text(p.split(images[i]).last),
                        ),
                      ));
            }
          }),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

class FirmwareList extends StatelessWidget {
  const FirmwareList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firmware List'),
      ),
      body: FutureBuilder(
          future:
              DefaultAssetBundle.of(context).loadString('AssetManifest.json'),
          builder: (c, a) {
            if (!a.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              final data = a.data;
              final json = jsonDecode(data as String);
              final images = json.keys.map((e) => p.split(e).last).toList();

              return ListView.separated(
                  separatorBuilder: (c, i) => Divider(),
                  itemCount: images.length,
                  itemBuilder: (c, i) => ListTile(
                        title: Text(images[i]),
                      ));
            }
          }),
    );
  }
}

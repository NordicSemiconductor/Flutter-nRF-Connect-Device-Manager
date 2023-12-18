import 'package:flutter/material.dart';
import 'package:mcumgr_flutter_example/src/providers/update_parameters_provider.dart';
import 'package:provider/provider.dart';

class FirmwareList extends StatelessWidget {
  const FirmwareList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firmware List')),
      body: _body(),
    );
  }

  Container _body() {
    return Container(
      child: ListView.builder(itemBuilder: (context, index) {
        return ListTile(
          title: Text('Firmware $index'),
          onTap: () {
            context
                .read<UpdateParametersProvider>()
                .setFirmware('Firmware $index');
            Navigator.pop(context, 'Firmware $index');
          },
        );
      }),
    );
  }
}

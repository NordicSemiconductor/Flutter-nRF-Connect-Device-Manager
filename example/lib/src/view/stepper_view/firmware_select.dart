import 'package:flutter/material.dart';
import 'package:mcumgr_flutter_example/src/model/update_parameters.dart';
import 'package:mcumgr_flutter_example/src/providers/update_parameters_provider.dart';
import 'package:provider/provider.dart';

import '../firmware_list.dart';

class FirmwareSelect extends StatelessWidget {
  const FirmwareSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UpdateParameters updateParameters =
        context.watch<UpdateParametersProvider>().value;

    return Column(
      children: [
        if (updateParameters.firmware != null) Text(updateParameters.firmware!),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FirmwareList()),
              );
            },
            child: Text('Select Firmware')),
      ],
    );
  }
}

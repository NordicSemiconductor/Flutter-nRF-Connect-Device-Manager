import 'package:flutter/material.dart';
import 'package:mcumgr_flutter_example/src/model/firmware_update_request.dart';
import 'package:mcumgr_flutter_example/src/providers/firmware_update_request_provider.dart';
import 'package:provider/provider.dart';

import '../firmware_select/firmware_list.dart';

class FirmwareSelect extends StatelessWidget {
  const FirmwareSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirmwareUpdateRequest updateParameters =
        context.watch<FirmwareUpdateRequestProvider>().updateParameters;

    return Column(
      children: [
        if (updateParameters.firmware != null)
          Text(updateParameters.firmware!.application.appName),
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

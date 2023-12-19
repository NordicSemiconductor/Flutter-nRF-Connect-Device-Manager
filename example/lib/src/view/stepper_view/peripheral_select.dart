import 'package:flutter/material.dart';
import 'package:mcumgr_flutter_example/src/model/firmware_update_request.dart';
import 'package:mcumgr_flutter_example/src/providers/firmware_update_request_provider.dart';
import 'package:mcumgr_flutter_example/src/view/peripheral_select/peripheral_list.dart';
import 'package:provider/provider.dart';

class PeripheralSelect extends StatelessWidget {
  const PeripheralSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirmwareUpdateRequest updateParameters =
        context.watch<FirmwareUpdateRequestProvider>().value;

    return Column(
      children: [
        if (updateParameters.peripheral != null)
          Text(updateParameters.peripheral!.name),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PeripheralList()),
              );
            },
            child: Text('Select Peripheral')),
      ],
    );
  }
}

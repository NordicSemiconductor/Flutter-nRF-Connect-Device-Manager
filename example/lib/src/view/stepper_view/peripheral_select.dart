import 'package:flutter/material.dart';
import 'package:mcumgr_flutter_example/src/model/update_parameters.dart';
import 'package:mcumgr_flutter_example/src/providers/update_parameters_provider.dart';
import 'package:mcumgr_flutter_example/src/view/peripheral_select/peripheral_list.dart';
import 'package:provider/provider.dart';

class PeripheralSelect extends StatelessWidget {
  const PeripheralSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UpdateParameters updateParameters =
        context.watch<UpdateParametersProvider>().value;

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

import 'package:flutter/material.dart';
import 'package:mcumgr_flutter_example/src/model/update_parameters.dart';
import 'package:mcumgr_flutter_example/src/providers/update_parameters_provider.dart';
import 'package:mcumgr_flutter_example/src/view/firmware_list.dart';
import 'package:mcumgr_flutter_example/src/view/stepper_view/firmware_select.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UpdateParametersProvider(),
      builder: (context, child) => _materialApp(context),
    );
  }

  MaterialApp _materialApp(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('MCU Manager'),
        ),
        body: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    UpdateParameters parameters =
        context.watch<UpdateParametersProvider>().value;
    return Stepper(
      currentStep: _currentStep,
      onStepContinue: () {
        setState(() {
          _currentStep++;
        });
      },
      onStepCancel: () {
        setState(() {
          _currentStep--;
        });
      },
      steps: [
        Step(
          title: Text('Select Firmware'),
          content: Center(child: FirmwareSelect()),
          isActive: false,
        ),
        Step(
          title: Text('Select Device'),
          content: Text('Device List'),
        ),
        Step(
          title: Text('Update'),
          content: Text('Update'),
        ),
      ],
    );
  }
}

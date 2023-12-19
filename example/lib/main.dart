import 'package:flutter/material.dart';
import 'package:mcumgr_flutter_example/src/model/firmware_update_request.dart';
import 'package:mcumgr_flutter_example/src/providers/firmware_update_request_provider.dart';
import 'package:mcumgr_flutter_example/src/view/stepper_view/firmware_select.dart';
import 'package:mcumgr_flutter_example/src/view/stepper_view/peripheral_select.dart';
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
      create: (context) => FirmwareUpdateRequestProvider(),
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
    FirmwareUpdateRequest parameters =
        context.watch<FirmwareUpdateRequestProvider>().value;
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
      controlsBuilder: (context, details) {
        switch (_currentStep) {
          case 0:
            if (parameters.firmware == null) {
              return Container();
            }
            return Row(
              children: [
                ElevatedButton(
                  onPressed: details.onStepContinue,
                  child: Text('Next'),
                ),
              ],
            );
          case 1:
            if (parameters.peripheral == null) {
              return Container();
            }
            return Row(
              children: [
                TextButton(
                  onPressed: details.onStepCancel,
                  child: Text('Back'),
                ),
                ElevatedButton(
                  onPressed: details.onStepContinue,
                  child: Text('Next'),
                ),
              ],
            );
          case 2:
            return ElevatedButton(
              onPressed: details.onStepContinue,
              child: Text('Update'),
            );
          default:
            throw Exception('Unknown step');
        }
      },
      steps: [
        Step(
          title: Text('Select Firmware'),
          content: Center(child: FirmwareSelect()),
          isActive: _currentStep == 0,
        ),
        Step(
          title: Text('Select Device'),
          content: Center(child: PeripheralSelect()),
          isActive: _currentStep == 1,
        ),
        Step(
          title: Text('Update'),
          content: Text('Update'),
          isActive: _currentStep == 2,
        ),
      ],
    );
  }
}

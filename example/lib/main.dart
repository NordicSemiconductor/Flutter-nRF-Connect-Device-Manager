import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcumgr_flutter_example/src/bloc/bloc/update_bloc.dart';
import 'package:mcumgr_flutter_example/src/model/firmware_update_request.dart';
import 'package:mcumgr_flutter_example/src/providers/firmware_update_request_provider.dart';
import 'package:mcumgr_flutter_example/src/view/stepper_view/firmware_select.dart';
import 'package:mcumgr_flutter_example/src/view/stepper_view/peripheral_select.dart';
import 'package:mcumgr_flutter_example/src/view/stepper_view/update_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
    final provider = context.watch<FirmwareUpdateRequestProvider>();
    return Stepper(
      currentStep: provider.currentStep,
      onStepContinue: () {
        setState(() {
          provider.nextStep();
        });
      },
      onStepCancel: () {
        setState(() {
          provider.previousStep();
        });
      },
      controlsBuilder: _controlBuilder,
      steps: [
        Step(
          title: Text('Select Firmware'),
          content: Center(child: FirmwareSelect()),
          isActive: provider.currentStep == 0,
        ),
        Step(
          title: Text('Select Device'),
          content: Center(child: PeripheralSelect()),
          isActive: provider.currentStep == 1,
        ),
        Step(
          title: Text('Update'),
          content: Container(),
          isActive: provider.currentStep == 2,
        ),
      ],
    );
  }

  Widget _controlBuilder(BuildContext context, ControlsDetails details) {
    final provider = context.watch<FirmwareUpdateRequestProvider>();
    FirmwareUpdateRequest parameters = provider.updateParameters;
    switch (provider.currentStep) {
      case 0:
        if (parameters.firmware == null) {
          return Container();
        }
        return Center(
          child:
            ElevatedButton(
              onPressed: details.onStepContinue,
              child: Text('Next'),
            ),
        );
      case 1:
        if (parameters.peripheral == null) {
          return Container();
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
        return BlocProvider(
          create: (context) => UpdateBloc(firmwareUpdateRequest: parameters),
          child: UpdateStepView(),
        );
      default:
        throw Exception('Unknown step');
    }
  }
}

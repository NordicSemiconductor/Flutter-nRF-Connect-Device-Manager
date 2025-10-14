import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcumgr_flutter_example/src/bloc/bloc/update_bloc.dart';
import 'package:mcumgr_flutter_example/src/model/firmware_update_request.dart';
import 'package:mcumgr_flutter_example/src/providers/firmware_update_request_provider.dart';
import 'package:mcumgr_flutter_example/src/view/stepper_view/firmware_select.dart';
import 'package:mcumgr_flutter_example/src/view/stepper_view/peripheral_select.dart';
import 'package:mcumgr_flutter_example/src/view/stepper_view/update_view.dart';

class FirmwareUpdateWidget extends StatefulWidget {
  const FirmwareUpdateWidget({super.key});

  @override
  State<FirmwareUpdateWidget> createState() => _FirmwareUpdateWidgetState();
}

class _FirmwareUpdateWidgetState extends State<FirmwareUpdateWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FirmwareUpdateRequestProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firmware Update'),
      ),
      body: Stepper(
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
            title: const Text('Select Firmware'),
            content: Center(child: FirmwareSelect()),
            isActive: provider.currentStep == 0,
          ),
          Step(
            title: const Text('Select Device'),
            content: Center(child: PeripheralSelect()),
            isActive: provider.currentStep == 1,
          ),
          Step(
            title: const Text('Update'),
            content: const Text('Update'),
            isActive: provider.currentStep == 2,
          ),
        ],
      ),
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
        return Row(
          children: [
            ElevatedButton(
              onPressed: details.onStepContinue,
              child: const Text('Next'),
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
              child: const Text('Back'),
            ),
            ElevatedButton(
              onPressed: details.onStepContinue,
              child: const Text('Next'),
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

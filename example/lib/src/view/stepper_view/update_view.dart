import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcumgr_flutter_example/src/providers/firmware_update_request_provider.dart';

import '../../bloc/bloc/update_bloc.dart';

class UpdateStepView extends StatelessWidget {
  const UpdateStepView({super.key});

  @override
  Widget build(BuildContext context) {
    final request =
        context.watch<FirmwareUpdateRequestProvider>().updateParameters;
    return BlocBuilder<UpdateBloc, UpdateState>(
      builder: (context, state) {
        switch (state) {
          case UpdateInitial():
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Firmware: ${request.firmware?.application.appName}'),
                Text('Version: ${request.firmware?.version.version}'),
                Text('Board: ${request.firmware?.board.name}'),
                Text('Firmware: ${request.firmware?.firmware.name}'),
                ElevatedButton(
                  onPressed: () {
                    context.read<UpdateBloc>().add(BeginUpdateProcess());
                  },
                  child: Text('Update'),
                ),
              ],
            );
          case UpdateFirmwareStateHistory():
            return Column(
              children: [
                for (var state in state.history)
                  Row(
                    children: [
                      Icon(Icons.check_circle_outline, color: Colors.green),
                      Text(state.state),
                      if (state.progress != null)
                        Text(' ${state.progress}%'),
                    ],
                  ),
                  Text(state.currentState.state),
              ],
            );
          default:
            return Text('Unknown state');
        }
      },
    );
  }
}

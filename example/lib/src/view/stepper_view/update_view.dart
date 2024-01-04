import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcumgr_flutter_example/src/providers/firmware_update_request_provider.dart';

import '../../bloc/bloc/update_bloc.dart';

class UpdateStepView extends StatelessWidget {
  const UpdateStepView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FirmwareUpdateRequestProvider>();
    final request = provider.updateParameters;
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
                      _stateIcon(state),
                      Text(state.stage),
                    ],
                  ),
                if (state.currentState != null)
                  Row(
                    children: [
                      CircularProgressIndicator(),
                      _currentState(state),
                    ],
                  ),
                if (state.isComplete)
                  ElevatedButton(
                    onPressed: () {
                      provider.reset();
                    },
                    child: Text('Update Again'),
                  ),
              ],
            );
          default:
            return Text('Unknown state');
        }
      },
    );
  }

  Icon _stateIcon(UpdateFirmware state) {
    if (state is UpdateCompleteFailure) {
      return Icon(Icons.error_outline, color: Colors.red);
    } else {
      return Icon(Icons.check_circle_outline, color: Colors.green);
    }
  }

  Text _currentState(UpdateFirmwareStateHistory state) {
    final currentState = state.currentState;
    if (currentState == null) {
      return Text('Unknown state');
    } else if (currentState is UpdateProgressFirmware) {
      return Text("Uploading ${currentState.progress}%");
    } else {
      return Text(currentState.stage);
    }
  }
}

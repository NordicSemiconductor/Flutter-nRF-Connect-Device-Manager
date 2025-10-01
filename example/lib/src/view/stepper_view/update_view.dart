import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcumgr_flutter_example/src/model/firmware_update_request.dart';
import 'package:mcumgr_flutter_example/src/providers/firmware_update_request_provider.dart';
import 'package:mcumgr_flutter_example/src/view/logger_screen/logger_screen.dart';

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
                _firmwareInfo(context, request.firmware!),
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
                      SizedBox(width: 3),
                      CircularProgressIndicator(
                        constraints: BoxConstraints(minWidth: 17.0, minHeight: 17.0),
                        strokeWidth: 2.0,
                      ),
                      SizedBox(width: 3),
                      _currentState(state),
                    ],
                  ),
                if (state.isComplete && state.updateManager?.logger != null)
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoggerScreen(
                                      logger: state.updateManager!.logger,
                                    )));
                      },
                      child: Text('Show Log')),
                if (state.isComplete)
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<UpdateBloc>(context).add(ResetUpdate());
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

  Widget _firmwareInfo(BuildContext context, SelectedFirmware firmware) {
    if (firmware is LocalFirmware) {
      return _localFirmwareInfo(context, firmware);
    } else if (firmware is RemoteFirmware) {
      return _remoteFirmwareInfo(context, firmware);
    } else {
      return Text('Unknown firmware type');
    }
  }

  Widget _localFirmwareInfo(BuildContext context, LocalFirmware firmware) {
    return Text('Firmware: ${firmware.name}');
  }

  Widget _remoteFirmwareInfo(BuildContext context, RemoteFirmware firmware) {
    return Column(
      children: [
        Text('Firmware: ${firmware.application.appName}'),
        Text('Version: ${firmware.version.version}'),
        Text('Board: ${firmware.board.name}'),
        Text('Firmware: ${firmware.firmware.name}'),
      ],
    );
  }
}

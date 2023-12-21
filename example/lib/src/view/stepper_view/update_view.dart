import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcumgr_flutter_example/src/providers/firmware_update_request_provider.dart';
import 'package:provider/provider.dart';
import 'package:bloc/bloc.dart';

import '../../bloc/bloc/update_bloc.dart';

class UpdateStepView extends StatelessWidget {
  const UpdateStepView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateBloc, UpdateState>(
      builder: (context, state) {
        switch (state) {
          case UpdateInitial():
            return ElevatedButton(
              onPressed: () {
                context.read<UpdateBloc>().add(BeginUpdateProcess());
              },
              child: Text('Update'),
            );
          case UpdateFirmware():
            return Text(state.state);
          default:
            return Text('Unknown state');
        }
      },
    );
  }
}

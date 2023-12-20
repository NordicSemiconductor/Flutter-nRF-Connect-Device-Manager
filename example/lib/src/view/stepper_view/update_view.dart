import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcumgr_flutter_example/src/providers/firmware_update_request_provider.dart';
import 'package:provider/provider.dart';
import 'package:bloc/bloc.dart';

class UpdateStepView extends StatelessWidget {
  const UpdateStepView({super.key});

  @override
  Widget build(BuildContext context) {
    FirmwareUpdateRequestProvider provider =
        context.read<FirmwareUpdateRequestProvider>();
    return Placeholder();
  }
}

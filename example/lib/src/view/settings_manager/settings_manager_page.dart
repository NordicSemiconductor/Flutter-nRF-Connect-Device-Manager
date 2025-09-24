import 'package:flutter/material.dart';
import 'package:mcumgr_flutter_example/src/view/settings_manager/settings_manager_widget.dart';

class SettingsManagerPage extends StatelessWidget {
  const SettingsManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Manager'),
      ),
      body: const SettingsManagerWidget(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:mcumgr_flutter_example/src/providers/firmware_update_request_provider.dart';
import 'package:mcumgr_flutter_example/src/view/firmware_update/firmware_update_widget.dart';
import 'package:mcumgr_flutter_example/src/view/settings_manager/settings_manager_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FirmwareUpdateRequestProvider(),
      child: MaterialApp(
        title: 'MCU Manager',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainMenuPage(),
      ),
    );
  }
}

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MCU Manager'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.system_update, size: 40),
              title: const Text(
                'Firmware Update',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Update device firmware'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FirmwareUpdateWidget(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.settings, size: 40),
              title: const Text(
                'Settings Manager',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Manage device settings'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsManagerPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

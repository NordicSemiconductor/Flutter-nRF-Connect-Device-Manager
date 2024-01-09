import 'package:flutter/material.dart';
import 'package:mcumgr_flutter/mcumgr_flutter.dart';

class LoggerScreen extends StatelessWidget {
  const LoggerScreen({required this.logger, super.key});
  final FirmwareUpdateLogger logger;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Log'),
        ),
        body: _logFutureBuilder());
  }

  Widget _logFutureBuilder() {
    return FutureBuilder(
      future: logger.readLogs(),
      builder: (context, snapshot) {
        /*
          if (snapshot.hasData) {
            return Text(snapshot.data!.length
                .toString()); // _messageList(snapshot.data as List<McuLogMessage>);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return CircularProgressIndicator();
          */
        return Text('TODO');
      },
    );
  }

  Widget _messageList(List<McuLogMessage> messages) =>
      ListView.builder(itemBuilder: (context, index) {
        final message = messages[index];
        return ListTile(
          title: Text(message.message),
          subtitle: Text(message.level.toString()),
        );
      });
}

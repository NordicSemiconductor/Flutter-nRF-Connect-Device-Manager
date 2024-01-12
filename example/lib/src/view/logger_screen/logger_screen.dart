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
        if (snapshot.hasData) {
          final messages = (snapshot.data as List<McuLogMessage>)
              .where((element) => element.level.rawValue >= 1)
              .toList();
          return _messageList(messages);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget _messageList(List<McuLogMessage> messages) => ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return Text(
          message.message,
          style: TextStyle(color: _colorForLevel(message.level)),
        );
      });

  Color _colorForLevel(McuMgrLogLevel level) {
    switch (level) {
      case McuMgrLogLevel.verbose:
        return Colors.grey;
      case McuMgrLogLevel.application:
        return Colors.purple;
      case McuMgrLogLevel.debug:
        return Colors.blue;
      case McuMgrLogLevel.info:
        return Colors.green;
      case McuMgrLogLevel.warning:
        return Colors.orange;
      case McuMgrLogLevel.error:
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}

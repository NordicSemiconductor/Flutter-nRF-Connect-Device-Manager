import 'package:flutter_blue/gen/flutterblue.pb.dart';

mixin DeviceRepresentation {
  late String deviceId;
}

class Device extends BluetoothDevice with DeviceRepresentation {
  Device.fromProto(BluetoothDevice p) : super.fromProto(p);
  
  
}
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mcumgr_flutter/src/mcumgr_flutter.dart';

void main() {
  const MethodChannel channel = MethodChannel('mcumgr_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await McumgrFlutter.platformVersion, '42');
  });
}

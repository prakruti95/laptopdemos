import 'package:flutter_test/flutter_test.dart';
import 'package:accelerometer_plugin/accelerometer_plugin.dart';
import 'package:accelerometer_plugin/accelerometer_plugin_platform_interface.dart';
import 'package:accelerometer_plugin/accelerometer_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAccelerometerPluginPlatform
    with MockPlatformInterfaceMixin
    implements AccelerometerPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AccelerometerPluginPlatform initialPlatform = AccelerometerPluginPlatform.instance;

  test('$MethodChannelAccelerometerPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAccelerometerPlugin>());
  });

  test('getPlatformVersion', () async {
    AccelerometerPlugin accelerometerPlugin = AccelerometerPlugin();
    MockAccelerometerPluginPlatform fakePlatform = MockAccelerometerPluginPlatform();
    AccelerometerPluginPlatform.instance = fakePlatform;

    expect(await accelerometerPlugin.getPlatformVersion(), '42');
  });
}

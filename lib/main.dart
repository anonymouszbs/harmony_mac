import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:window_manager/window_manager.dart';

import 'config/dataconfig/global_config.dart';
import 'init/Application.dart';

void main(List<String> args) {

runZonedGuarded(
    () => init(),
    // ignore: avoid_print
    (err, stace) => print(FlutterErrorDetails(exception: err, stack: stace)),
    zoneSpecification: ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        if (line.length > 800) {
          parent.print(zone, '字符串长度为 ${line.length}');
        } else {
          parent.print(zone, line);
        }
      },
    ),
  );
}
init() async{
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true;
  await windowManager.ensureInitialized();
  await localNotifier.setup(
    appName: 'Harmony FLow',
    // 仅 Windows
    shortcutPolicy: ShortcutPolicy.requireCreate,
  );
   WindowOptions windowOptions = const  WindowOptions(
    title: "Harmony FLow",
    center: true,
    size: Size(1920, 1080), 
    minimumSize: Size(1920,1080)
   );
    windowManager.waitUntilReadyToShow(windowOptions,()async{
      await windowManager.show();
      await windowManager.focus();
    });
    await GloblConfig.init();
    runApp( Application());
}

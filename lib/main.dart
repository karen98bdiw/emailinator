import 'package:emailinator/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './app.dart';

Future<void> run() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

Future<void> main() async {
  await run();
}

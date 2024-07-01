import 'dart:io';

import 'package:flutter/material.dart';
import 'package:reach_collect/network/presistance/SQLiteHelper.dart';
import 'package:reach_collect/screens/splash_screen.dart';
import 'package:reach_collect/utils/share_preference.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//   if (Platform.isWindows) {
//     sqfliteFfiInit();
//     await PreferenceManager.init();
//      WindowManager.instance.setMinimumSize(const Size(1200, 600));
//      WindowManager.instance.setMaximumSize(const Size(2000, 2000));
//   }

//   if (Platform.isMacOS){
//     sqfliteFfiInit();
//     await PreferenceManager.init();
//   }

//  databaseFactory = databaseFactoryFfi;
  SQLiteHelper();
  await PreferenceManager.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

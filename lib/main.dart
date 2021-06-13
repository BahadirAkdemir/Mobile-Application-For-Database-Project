import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'login.dart';
import 'databaseHelper.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => login(),
    },
    debugShowCheckedModeBanner: false,
  ));
}





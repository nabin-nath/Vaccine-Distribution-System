import 'package:covid_app/register.dart';
import 'package:covid_app/time.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//SharedPreferences pref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //pref = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(body: Register()
            //(pref.getString('reg') == null) ? Register() : showTime()),
            ));
  }
}

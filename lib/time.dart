import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class showTime extends StatefulWidget {
  showTime({Key key}) : super(key: key);

  @override
  _showTimeState createState() => _showTimeState();
}

class _showTimeState extends State<showTime> {
  Future<void> post(Map<String, dynamic> data) async {
    final http.Response response = await http.post(
        'http://10.0.2.2:5000/register',
        body: jsonEncode(data),
        headers: {"content-type": "application/json"});

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to upload data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final adhaar = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Center(
        child: Column(
          children: [Text(adhaar)],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}

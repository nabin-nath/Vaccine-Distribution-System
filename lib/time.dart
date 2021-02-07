import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class showTime extends StatefulWidget {
  showTime({Key key}) : super(key: key);

  @override
  _showTimeState createState() => _showTimeState();
}

class _showTimeState extends State<showTime> {
  @override
  void initState() {
    super.initState();
  }

  String time = 'fetching.. please refresh the page';
  Future<int> getTime(Map<String, dynamic> data) async {
    final http.Response response = await http.post(
        'http://10.0.2.2:5000/gettime',
        body: jsonEncode(data),
        headers: {"content-type": "application/json"});

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      var res = jsonDecode(response.body);
      print(res);
      //int data = int.parse(res);

      return res;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to upload data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final dynamic val = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                time,
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Map<String, dynamic> data = {
            'adhaar': val[0],
            'district': val[1],
            'block': val[2]
          };

          getTime(data).then((value) => {
                setState(() {
                  if (value > 60 && value < 1440) {
                    time =
                        ' ${value ~/ 60} hours and ${value % 60} left min for your vaccination';
                  } else if (value > 1440) {
                    time =
                        ' ${value ~/ 1440} hours and ${value % 60} hours min for your vaccination';
                  } else {
                    time = '${value ~/ 1440} min left for your vaccination';
                  }
                })
              });
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}

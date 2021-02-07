import 'dart:convert';
import 'package:covid_app/time.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:covid_app/main.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

final _formKey = GlobalKey<FormState>();

class _RegisterState extends State<Register> {
  Future<void> create_post(Map<String, dynamic> data) async {
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

  final _name = TextEditingController();
  final _aadharno = TextEditingController();
  final _age = TextEditingController();

  String _occupation;
  String _state;
  String _district;
  String _block;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: buildForm());
  }

  Form buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              "Registration",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Name cant be empty";
                  }
                  return null;
                },
                controller: _name,
                decoration: InputDecoration(
                  labelText: "Name",
                  icon: Icon(
                    Icons.account_circle,
                    size: 30,
                  ),
                  hintText: "Enter your name",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Aadhar no cant be null";
                  } else if (value.length != 12) {
                    return "Aadhar no is of 12 digits";
                  }

                  return !RegExp(r"\d\d\d\d\d\d\d\d\d\d\d\d").hasMatch(value)
                      ? "*Please enter a valid aadhar no"
                      : null;
                },
                controller: _aadharno,
                decoration: InputDecoration(
                  labelText: "Aadhar No",
                  icon: Icon(
                    Icons.account_circle,
                    size: 30,
                  ),
                  hintText: "Enter your Aadhar no",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Age no cant be empty";
                  }
                  return null;
                },
                controller: _age,
                decoration: InputDecoration(
                  labelText: "Age",
                  icon: Icon(
                    Icons.account_circle,
                    size: 30,
                  ),
                  hintText: "Enter your Age",
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(45, 0, 0, 0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new DropdownButton<String>(
                      value: _occupation,
                      items: <String>[
                        'Working',
                        'Unhealthy',
                        'Frontline Workers',
                        'Lactating Women',
                        'Rest'
                      ].map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        _occupation = value;
                        setState(() {
                          FocusScope.of(context).requestFocus(FocusNode());
                          super.setState(() {});
                        });
                      },
                      hint: Text('Category'),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new DropdownButton<String>(
                      value: _state,
                      items: <String>[
                        'Uttar Pradesh',
                        'Bihar',
                        'West Bengal',
                        'Assam',
                      ].map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        _state = value;
                        setState(() {
                          FocusScope.of(context).requestFocus(FocusNode());
                          super.setState(() {});
                        });
                      },
                      hint: Text('State'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(45, 0, 0, 0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new DropdownButton<String>(
                      value: _district,
                      items: <String>[
                        'Agra',
                        'Varanasi',
                        'Mirzapur',
                        'Ghaziabad',
                      ].map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        _district = value;
                        setState(() {
                          FocusScope.of(context).requestFocus(FocusNode());
                          super.setState(() {});
                        });
                      },
                      hint: Text('District'),
                    ),
                  ),
                  SizedBox(
                    width: 140,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new DropdownButton<String>(
                      value: _block,
                      items: <String>[
                        '1',
                        '2',
                        '3',
                        '4',
                      ].map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        _block = value;
                        setState(() {
                          FocusScope.of(context).requestFocus(FocusNode());
                          super.setState(() {});
                        });
                      },
                      hint: Text('Block'),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              onPressed: () async {
                if (_formKey.currentState.validate() &&
                    _age != null &&
                    _aadharno != null) {
                  String name = _name.value.text;
                  String aadharno = _aadharno.value.text;
                  String age = _age.value.text;
                  String occupation = _occupation;
                  String state = _state;
                  String district = _district;
                  String block = _block;

                  Map<String, dynamic> data = {
                    "name": name,
                    "age": age,
                    "aadhar_no": aadharno,
                    "occupation": occupation,
                    "state": state,
                    "district": district,
                    "block": block
                  };

                  create_post(data).then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => showTime(),
                            settings: RouteSettings(arguments: [
                              _aadharno.value.text,
                              district,
                              _block
                            ]),
                            fullscreenDialog: true));
                    //pref.setString('reg', 'done');
                  });
                }
              },
              child: Icon(Icons.done),
            )
          ],
        ));
  }
}

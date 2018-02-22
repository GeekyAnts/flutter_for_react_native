import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

void main() {
  runApp(new APICalls());
}

class APICalls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MyAPICalls(),
    );
  }
}

class MyAPICalls extends StatefulWidget {
  MyAPICalls({Key key}) : super(key: key);

  @override
  _MyAPICallsState createState() => new _MyAPICallsState();
}

class _MyAPICallsState extends State<MyAPICalls> {
  var _ipAddress = 'Unknown';
  final httpClient = createHttpClient();
  final url = 'https://httpbin.org/ip';
  _getIPAddressUsingFuture() {
    Future<Response> response = httpClient.get(url);
    response.then((value) {
      setState(() {
        _ipAddress = JSON.decode(value.body)['origin'];
      });
    }).catchError((error) => print(error));
  }

  _getIPAddressUsingAwait() async {
    var response = await httpClient.read(url);
    var ip = JSON.decode(response)['origin'];
    setState(() {
      _ipAddress = ip;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('Your current IP address is:'),
            new Text('$_ipAddress.'),
            new Padding(
              padding: new EdgeInsets.all(8.0),
              child: new RaisedButton(
                onPressed: _getIPAddressUsingFuture,
                child: new Text('Get IP address'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

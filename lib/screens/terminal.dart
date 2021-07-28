import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Terminal extends StatefulWidget {
  @override
  _TerminalState createState() => _TerminalState();
}

class _TerminalState extends State<Terminal> {
  var fsconnect = FirebaseFirestore.instance;
  var cmd;
  var x;
  var webdata;
  var _controller = TextEditingController();
  TextEditingController ipController = new TextEditingController();
  web(cmd) async {
    var url = 'http://${ipController.text}/cgi-bin/web.py?x=${cmd}';
    var response = await http.get(url);
    setState(() {
      webdata = response.body;
    });
    fsconnect.collection("linuxcmdoutput").add({'$cmd': '$webdata'});
    print(webdata);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'Linux Terminal App',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontStyle: FontStyle.italic,
          ),
        ),
        leading: Icon(
          FontAwesomeIcons.linux,
          color: Colors.black,
          size: 50,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: ipController,
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide(color: Colors.orangeAccent, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide(color: Colors.orangeAccent, width: 1),
                ),
                hintText: 'Enter the IP of remote LinuxOS',
                prefixIcon: Icon(
                  FontAwesomeIcons.networkWired,
                  color: Colors.deepOrange,
                ),
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              color: Colors.black,
              padding: EdgeInsets.all(10),
              child: Text(
                'Remote Linux Access',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Card(
              child: TextField(
                controller: _controller,
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(
                      color: Colors.orangeAccent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(
                      color: Colors.orangeAccent,
                    ),
                  ),
                  hintText: 'Enter the linux command',
                  prefixIcon: Icon(
                    FontAwesomeIcons.keyboard,
                    color: Colors.deepOrange,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onChanged: (value) {
                  cmd = value;
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            RaisedButton(
              onPressed: () {
                web(cmd);
              },
              color: Colors.black,
              child: Text(
                'Submit',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.deepOrange,
                  width: 2,
                ),
              ),
              child: FlatButton(
                  onPressed: _controller.clear,
                  child: Text(
                    'Clear',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 5, color: Colors.orangeAccent),
              ),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      child: Text(
                        webdata ?? "\n COMMAND OUTPUT",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

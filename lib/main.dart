import 'dart:async';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(home:CreateAccount()));
}

class myApp extends StatelessWidget {
  static int failures = 0;
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Attention Timer"),
          centerTitle: true,
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("MyImages/image.jpg"),
                  fit: BoxFit.cover)),
          child: ListView(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(40, 40, 40, 40),
                            child: TableTimer()),

                        Padding(
                            padding: EdgeInsets.fromLTRB(40, 40, 40, 40),
                            child: TableTimer()),

                        Padding(
                            padding: EdgeInsets.fromLTRB(40, 40, 40, 40),
                            child: TableTimer()),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(40, 40, 40, 40),
                            child: TableTimer()),

                        Padding(
                            padding: EdgeInsets.fromLTRB(40, 40, 40, 40),
                            child: TableTimer()),

                        Padding(
                            padding: EdgeInsets.fromLTRB(40, 40, 40, 40),
                            child: TableTimer()),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )
                  ]
              ),
               Padding(padding: EdgeInsets.fromLTRB(20,20, 20,20)),
               RaisedButton(

                 child: Text("See performance"),
                   onPressed: () {
                     Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (context) => SecondScreen(per: failures,),
                         ));
                   },
               )
            ]
          ),
        ),
        ),
    );
  }
}

class TableTimer extends StatefulWidget {
  @override
  State<TableTimer> createState() => _TableTimerState();
}

class _TableTimerState extends State<TableTimer> {
  Timer _timer;
  int _counterMinute = 1;
  int _counterSeconds = 0;
  NumberFormat formatter = new NumberFormat("00");
  void _startTimer(){
    if(_timer != null){
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if(!(_counterMinute == 0 && _counterSeconds == 0)) {
          if (_counterSeconds == 0) {
            _counterMinute--;
            _counterSeconds = 60;
          }
          _counterSeconds--;
        } else {
          color = Colors.red;
          showToast("Please attend to customer", duration: Toast.LENGTH_SHORT);
          myApp.failures ++;
          _timer.cancel();

        }
      });
    });
  }
  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
  Color color;
  initState() {
    super.initState();
    color = Colors.yellow;
  }
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (color == Colors.green) {
            _timer.cancel();
            color = Colors.yellow;
            _counterSeconds = 0;
            _counterMinute = 0;
          } else {
            color = Colors.green;
            _counterMinute = 1;
            _counterSeconds = 0;
            _startTimer();
          }
        });
      },

      child: Column(
      children: [
        Container(
          child: Icon(
          Icons.fastfood,
          color: color,
          size: 100,
        )
        // padding: EdgeInsets.all(10),
        ),

      Container(
      child: Text("Wait time:   $_counterMinute:${formatter.format(_counterSeconds)}",
          style: TextStyle(
        color: Colors.red,
      )),
      ),
      ]

    ),
    );
  }
}
class SecondScreen extends StatelessWidget {
  final int per;

  // receive data from the FirstScreen as a parameter
  SecondScreen({Key key, @required this.per}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Performance:Tables Unattended')),
      body: Center(
        child: Text(
          per.toString(),
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class CreateAccount extends StatelessWidget{
  var infoArray = new List(3);

  @override //overrides StatelessWidget build method
  Widget build(context) { //flutter calls this and something to print to screen must be returned
    return MaterialApp( //this widget object wraps the entire thing into a widget --> like a root widget //parameters home: whats drawn on screen
        home: Scaffold( //Scaffold parameter for where on screen example appBar is for blue strip at top
          body: Container(
              padding: EdgeInsets.all(20.0),
              alignment: Alignment.center,
              color: Colors.white,//cyan[50], //background color
              child: ListView(
                children: <Widget> [
                  Padding(padding: EdgeInsets.fromLTRB(0, 100, 0, 0)),
                  Container(child:
                    Center(
                      child: Text("Timely Tables",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.cyanAccent[400],
                        )
                      ),
                    )
                  ),

                  Container(
                    padding: EdgeInsets.fromLTRB(60, 10, 60, 20),  //change username space
                    child: TextField(
                      onChanged: (String str) {
                        infoArray[0] = str;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(60, 0, 60, 20),
                    child: TextField(
                      onChanged: (String str) {
                        infoArray[1] =  str;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  Container(
                    child: RaisedButton(
                      onPressed: (){

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => myApp()
                              ));
                      },
                      color: Colors.cyanAccent[400],
                      disabledColor: Colors.red[900],
                      highlightColor: Colors.red,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10), //change button height/width
                        child: Text('Sign In',
                          style: TextStyle(     //change text inside button
                              color: Colors.red[900]
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        //side: BorderSide(color: Colors.red), //change border color
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(40, 0, 40, 10),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(60, 0, 60, 80),
                      child: FlatButton(
                          onPressed: () {},
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0), //change button height/width
                            child: Text("Forgot Password",
                              style: TextStyle(
                                color: Colors.red[900],
                              ),
                            ),
                          )
                      )

                  ),
                ],
              )
          ),
        )
    );
  }
}



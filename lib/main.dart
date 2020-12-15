import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_poc/views/what_is_my_dose_coach.dart';
import 'views/country_selection.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
        routes: <String, WidgetBuilder>{
          '/returning-user': (BuildContext context) =>
              CountryScreen(title: 'Screen 1'),
          '/what-is-my-dose-coach': (BuildContext context) =>
              WhatIsMyDoseCoach()
        });
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: _getScreen(context),
    );
  }

  _getScreen(BuildContext context) {
    return Column(children: <Widget>[_topView(), _bottomView(context)]);
  }

  _topView() {
    return Expanded(
        flex: 7,
        child: Container(
            color: Color.fromRGBO(91, 95, 180, 1),
            width: double.infinity,
            child: FractionallySizedBox(
              heightFactor: 0.9,
              widthFactor: 0.9,
              child: Container(
                child: Padding(
                    padding: EdgeInsets.all(50),
                    child: Image(image: AssetImage("lib/assets/logo.png"))),
                alignment: Alignment.center,
                decoration: new BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
              ),
            )));
  }

  _bottomView(BuildContext context) {
    return Expanded(
        flex: 3,
        child: Container(
            color: Colors.white,
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                Row(children: [
                  Expanded(
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/returning-user');
                      },
                      child: Text("I'm a new user"),
                      color: Color.fromRGBO(91, 95, 180, 1),
                      textColor: Colors.white,
                      height: 40,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                    ),
                  )
                ]),
                SizedBox(height: 10),
                Row(children: [
                  Expanded(
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/returning-user');
                      },
                      child: Text("I'm a returning user"),
                      color: Color.fromRGBO(91, 95, 180, 0.2),
                      height: 40,
                      textColor: Color.fromRGBO(91, 95, 180, 1),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                    ),
                  )
                ])
              ],
            )));
  }
}

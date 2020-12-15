import 'package:flutter/material.dart';

class CountryScreen extends StatefulWidget {
  CountryScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  String countryValue = 'United States';

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: _getScreen(context),
        backgroundColor: Color.fromRGBO(91, 95, 180, 1));
  }

  _getScreen(BuildContext context) {
    return Column(
        children: <Widget>[_topView(), _midView(), _bottomView(context)]);
  }

  _topView() {
    return Container(
        color: Color.fromRGBO(91, 95, 180, 1),
        height: 90,
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(left: 16),
        child: Text(
          'Your country of residence',
          style: TextStyle(color: Colors.white, fontSize: 22),
          textAlign: TextAlign.left,
        ));
  }

  _midView() {
    return Expanded(
        flex: 1,
        child: Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 32),
            color: Colors.white,
            alignment: Alignment.topCenter,
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton(
                      value: countryValue,
                      isExpanded: true,
                      items: _getCountries(),
                      onChanged: (String newValue) {
                        setState(() {
                          countryValue = newValue;
                        });
                      }),
                )
              ],
            )));
  }

  _bottomView(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(children: [
              Expanded(
                child: Text(
                    "If you need to change your display language you can set that in your phone's settings."),
              )
            ]),
            SizedBox(height: 10),
            Row(children: [
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/what-is-my-dose-coach');
                  },
                  child: Text("Next"),
                  color: Color.fromRGBO(91, 95, 180, 1),
                  height: 40,
                  textColor: Colors.white,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                ),
              )
            ])
          ],
        ),
      ),
    );
  }

  _getCountries() {
    return <String>['United States', 'Argentina', 'Brazil', 'Chile']
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Row(
          children: [
            IconButton(
              icon: Image.asset('icons/flags/png/us.png',
                  package: 'country_icons'),
              onPressed: () {},
            ),
            SizedBox(width: 10),
            Text(value)
          ],
        ),
      );
    }).toList();
  }
}

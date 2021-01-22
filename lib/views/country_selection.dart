import 'package:flutter_poc/database/db_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_poc/repositories/user_repository.dart';

class CountryScreen extends StatefulWidget {
  CountryScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  static const countries = {
    "Argentina": "icons/flags/png/ar.png",
    "Germany": 'icons/flags/png/de.png',
    "United States": 'icons/flags/png/us.png',
  };
  String countryValue = 'United States';

  @override
  void initState() {
    super.initState();
  }

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
                    _saveCountry(countryValue);
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
    List<DropdownMenuItem<String>> countryItems = [];

    countries.forEach((key, value) {
      countryItems.add(DropdownMenuItem<String>(
        value: key,
        child: Row(
          children: [
            IconButton(
              icon: Image.asset(
                value,
                package: 'country_icons',
              ),
              onPressed: () {},
            ),
            SizedBox(width: 10),
            Text(key),
          ],
        ),
      ));
    });
    return countryItems;
  }

  void _saveCountry(String country) async {
    UserRepository().saveCountry(country);
  }
}

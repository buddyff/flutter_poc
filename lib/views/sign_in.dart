import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
              child: Image(
                image: AssetImage("lib/assets/logo.png"),
              ),
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }

  _bottomView(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 24, left: 12, right: 12, bottom: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Setup will take 5 minutes. Please make sure you have your medication and blood glucose meter (if any) with you',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/sign-in-form');
                    },
                    child: Text('Sign in'),
                    color: Color.fromRGBO(91, 95, 180, 1),
                    textColor: Colors.white,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>['email'],
);

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GoogleSignInAccount _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _saveUserData();
      }
    });
    _googleSignIn.signInSilently();
  }

  void _saveUserData() async {
    SharedPreferences userDefaults = await SharedPreferences.getInstance();

    var names = _currentUser.displayName.split(" ");

    userDefaults.setString('firstName', names.first);
    userDefaults.setString('lastName', names.last);
    userDefaults.setString('email', _currentUser.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_currentUser != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: _currentUser,
            ),
            title: Text(_currentUser.displayName ?? ''),
            subtitle: Text(_currentUser.email ?? ''),
          ),
          const Text("Signed in successfully."),
          ElevatedButton(
            child: const Text('SIGN OUT'),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
            onPressed: _handleSignOut,
          ),
          ElevatedButton(
            child: const Text('START ONBOARDING'),
            style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(91, 95, 180, 1),
            ),
            onPressed: _navigateToStartOnBoarding,
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text(
            "You are not currently signed in.",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(91, 95, 180, 1),
            ),
            child: const Text('SIGN IN'),
            onPressed: _handleSignIn,
          ),
        ],
      );
    }
  }

  _navigateToStartOnBoarding() {
    Navigator.pushNamed(context, '/start-onboarding');
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();
}
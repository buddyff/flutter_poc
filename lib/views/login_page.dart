import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_poc/repositories/user_repository.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    var names = _currentUser.displayName.split(" ");
    UserRepository().saveLoginData(
      names.first,
      names.last,
      _currentUser.email,
    );
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
          const Text(
            "Signed in successfully.",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
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
          _buildPlatformLogo(),
          const Text(
            "You are not currently signed in.",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          _buildSignInWidget(),
        ],
      );
    }
  }

  Widget _buildSignInWidget() {
    // return ElevatedButton(
    //   style: ElevatedButton.styleFrom(
    //     primary: Color.fromRGBO(91, 95, 180, 1),
    //   ),
    //   child: Text('SIGN IN'),
    //   onPressed: _handleSignIn,
    // );

    return SignInButton(
      Buttons.GoogleDark,
      onPressed: _handleSignIn,
    );
  }

  Widget _buildPlatformLogo() {
    String basePath = "lib/assets/";
    String imageName = "";
    if (Platform.isAndroid) {
      imageName = "android.png";
    } else if (Platform.isIOS) {
      imageName = "apple.png";
    }
    return Image(
      image: AssetImage("$basePath$imageName"),
      height: 100,
      fit: BoxFit.fitWidth,
    );
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

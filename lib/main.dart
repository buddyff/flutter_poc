import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_poc/views/consent.dart';
import 'package:flutter_poc/views/license_agreement.dart';
import 'package:flutter_poc/views/medication_list.dart';
import 'package:flutter_poc/views/privacy_policy.dart';
import 'package:flutter_poc/views/select_your_smart_pens.dart';
import 'package:flutter_poc/views/sign_in.dart';
import 'package:flutter_poc/views/sign_in_form.dart';
import 'package:flutter_poc/views/what_is_my_dose_coach.dart';
import 'package:flutter_poc/views/your_medication.dart';
import 'views/country_selection.dart';
import 'views/login_page.dart';
import 'views/onboarding_start.dart';

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
        initialRoute: '/login',
        routes: <String, WidgetBuilder>{
          '/login': (BuildContext context) => LoginPage(),
          '/start-onboarding': (BuildContext context) =>
              OnboardingStart(title: 'Flutter Demo Home Page'),
          '/returning-user': (BuildContext context) =>
              CountryScreen(title: 'Screen 1'),
          '/what-is-my-dose-coach': (BuildContext context) =>
              WhatIsMyDoseCoach(),
          '/select-your-smart-pens': (BuildContext context) =>
              SelectYourSmartPens(),
          '/sign-in': (BuildContext context) => SignIn(),
          '/sign-in-form': (BuildContext context) => SignInForm(),
          '/license-agreement': (BuildContext context) => LicenseAgreement(),
          '/privacy-policy': (BuildContext context) => PrivacyPolicy(),
          '/consent': (BuildContext context) => Consent(),
          '/your-medication': (BuildContext context) => YourMedication(),
          '/medication-list': (BuildContext context) => MedicationList(),
        },
        localizationsDelegates: [
          // ... app-specific localization delegate[s] here
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''), // English
          // ... other locales the app supports
        ]);
  }
}

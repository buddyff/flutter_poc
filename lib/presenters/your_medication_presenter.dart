import 'package:flutter_poc/views/your_medication.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class YourMedicationPresenter {
  YourMedicationInterface view;

  Future<List<String>> sendOnboarding() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String country = prefs.getString('country');
    String name = prefs.getString('name');
    String lastName = prefs.getString('lastName');
    String birthdate = prefs.getString('birthdate');
    String phone = prefs.getString('phone');
    String email = prefs.getString('email');

    List<String> medications = [];
    final response = await http.post(
      "https://run.mocky.io/v3/5bf3daa4-74c7-420f-ba79-bfa593b74bca",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'country': country,
          'name': name,
          'lastName': lastName,
          'birthdate': birthdate,
          'phone': phone,
          'email': email
        },
      ),
    );

    if (response.statusCode == 200) {
      print('uepa');
      view.onboardingOK();
    }
  }
}

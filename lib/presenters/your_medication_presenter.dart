import 'dart:convert';

import 'package:flutter_poc/repositories/user_repository.dart';
import 'package:flutter_poc/views/your_medication.dart';
import 'package:http/http.dart' as http;

class YourMedicationPresenter {
  YourMedicationInterface view;

  sendOnboarding() async {
    var data = await UserRepository().getUser();

    final response = await http.post(
      "https://run.mocky.io/v3/ea1d89e0-1e80-43c0-ab47-a5b4d912b332",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'country': data.country,
          'name': data.name,
          'lastName': data.lastName,
          'birthdate': data.birthDate,
          'phone': data.phone,
          'email': data.email
        },
      ),
    );

    if (response.statusCode == 200) {
      view.onboardingOK();
    }
  }
}

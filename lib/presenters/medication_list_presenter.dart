import 'package:flutter_poc/views/medication_list.dart';
import 'package:flutter_poc/models/medication_list_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MedicationListPresenter {
  MedicationListInterface view;

  /*void viewLoaded() {
    List<String> medications = getMedications();
    view.loadMedications(medications);
  }*/

  Future<List<String>> getMedications() async {
    print('invocada');
    List<String> medications = [];
    final response = await http.get(
        'https://350cc076-df72-4fe5-bbf4-00a4f362f677.mock.pstmn.io/api/2.0/medications');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      for (Map map in data['data']) {
        medications.add(Medication.fromJson(map).fullName);
      }

      medications.sort();
      view.loadMedications(medications);
    }
  }
}

import 'package:flutter_poc/database/db_manager.dart';
import 'package:flutter_poc/views/medication_list.dart';
import 'package:flutter_poc/models/medication_list_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MedicationListPresenter {
  MedicationListInterface view;

  Future<List<Medication>> getMedications() async {
    List<Medication> medications = await DBManager.db.getAllMeds();

    if (medications.isEmpty) {
      final response = await http.get(
          'https://350cc076-df72-4fe5-bbf4-00a4f362f677.mock.pstmn.io/api/2.0/medications');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        for (Map map in data['data']) {
          var newMed = Medication.fromMap(map);
          await DBManager.db.newMed(newMed);
          medications.add(newMed);
        }

        medications.sort((a, b) => a.fullName.compareTo(b.fullName));
        view.loadMedications(medications);
      } else {}
    } else {
      medications.sort((a, b) => a.fullName.compareTo(b.fullName));
      view.loadMedications(medications);
    }
  }
}

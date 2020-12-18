import 'package:flutter/material.dart';
import 'package:flutter_poc/presenters/medication_list_presenter.dart';

class MedicationListInterface {
  void loadMedications(List<String> medications) {}
}

class MedicationList extends StatefulWidget {
  final MedicationListPresenter presenter = MedicationListPresenter();

  @override
  createState() => MedicationListState();
}

class MedicationListState extends State<MedicationList>
    implements MedicationListInterface {
  List<String> medications = [];

  @override
  void initState() {
    super.initState();
    this.widget.presenter.view = this;
    this.widget.presenter.getMedications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: _getScreen(context),
      backgroundColor: Color.fromRGBO(91, 95, 180, 1),
    );
  }

  _getScreen(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 64, left: 24, bottom: 24),
                child: Text(
                  'Select your insulin',
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
        Visibility(
          visible: (medications.length == 0),
          child: Expanded(
            child: Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          ),
        ),
        Visibility(
          visible: (medications.length > 0),
          child: Expanded(
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Table(
                  children: _getTableRows(context),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  _getTableRows(BuildContext context) {
    List<TableRow> rows = [];

    medications.forEach((med) {
      rows.add(
        TableRow(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context, med);
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                ),
                child: Text(
                  med,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
    return rows;
  }

  @override
  void loadMedications(List<String> medications) {
    setState(() {
      this.medications = medications;
    });
  }
}

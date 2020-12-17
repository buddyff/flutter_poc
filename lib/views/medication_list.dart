import 'package:flutter/material.dart';

class MedicationList extends StatefulWidget {
  @override
  createState() => MedicationListState();
}

class MedicationListState extends State<MedicationList> {
  final List<String> medications = [
    'Admelog (U100/ml)',
    'Apidra (U100/ml)',
    'Basaglar (U100/ml)',
    'FIAsp (U100/ml)',
    'Humalog (U100/ml)',
    'Humalog (U200/ml)',
    'Lantus (U100/ml)',
    'Levemir (U100/ml)',
    'NovoLog (U100/ml)',
    'Soliqua 100/33 (100/33)',
    'Toujeo (U300/ml)',
    'Tresiba (U100/ml)',
    'Tresiba (U200/ml)',
    'Xultophy (U100/ml)',
  ];
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
        Expanded(
            child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Table(
              children: _getTableRows(context),
            ),
          ),
        ))
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
                print(med);
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
}

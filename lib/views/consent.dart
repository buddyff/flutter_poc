import 'package:flutter/material.dart';

class Consent extends StatefulWidget {
  @override
  createState() => ConsentState();
}

class ConsentState extends State<Consent> {
  ScrollController _controller;
  bool showDescription = true;
  bool firstCheck = false;
  bool secondCheck = false;
  bool thirdCheck = false;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (_controller.offset >= 70) {
      setState(() {
        showDescription = false;
      });
    } else {
      setState(() {
        showDescription = true;
      });
    }
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
    return CustomScrollView(
      controller: _controller,
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          backgroundColor: Color.fromRGBO(91, 95, 180, 1),
          expandedHeight: 180.0,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(left: 8, right: 8, bottom: 16),
            title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Consent',
                    textAlign: TextAlign.left,
                  ),
                  Visibility(
                    child: Text(
                        'Embody cannot be used without your consent to the use of your health data. Please read and acknowledge the following:',
                        style: TextStyle(fontSize: 12)),
                    visible: showDescription,
                  )
                ]),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return _bottomView();
            },
            childCount: 1,
          ),
        ),
        SliverFillRemaining(
          child: Container(
            padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: FlatButton(
                    child: Text('I accept'),
                    color: Color.fromRGBO(91, 95, 180, 1),
                    disabledColor: Color.fromRGBO(91, 95, 180, 0.2),
                    textColor: Colors.white,
                    disabledTextColor: Color.fromRGBO(91, 95, 180, 0.4),
                    onPressed: _allChecked()
                        ? () {
                            Navigator.of(context).pushNamed("/your-medication");
                          }
                        : null,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  _bottomView() {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
        child: Column(
          children: [
            _getConsents(1),
            SizedBox(height: 30),
            _getConsents(2),
            SizedBox(height: 30),
            _getConsents(3),
          ],
        ));
  }

  _getConsents(int index) {
    String text;

    if (index == 1) {
      text =
          'I confirm my consent for the processing of my health data by Embody to use these services.';
    } else if (index == 2) {
      text =
          'I consent to the processing  of my de-identified health data for scientific  research purposes';
    } else if (index == 3) {
      text =
          'I acknowledge that the Embody app is not a replacement for your medication or smart pen instructions for use. It is recommended that you read and understand these instructions.';
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: (index == 1)
              ? firstCheck
              : (index == 2)
                  ? secondCheck
                  : thirdCheck,
          onChanged: (newValue) {
            setState(() {
              if (index == 1) {
                firstCheck = newValue;
              } else if (index == 2) {
                secondCheck = newValue;
              } else {
                thirdCheck = newValue;
              }
            });
          },
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 17),
          ),
        ),
      ],
    );
  }

  _allChecked() {
    return firstCheck && secondCheck && thirdCheck;
  }
}

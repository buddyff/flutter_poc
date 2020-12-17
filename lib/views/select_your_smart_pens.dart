import 'package:flutter/material.dart';

class SelectYourSmartPens extends StatefulWidget {
  @override
  createState() => SelectYourSmartPensState();
}

class SelectYourSmartPensState extends State<SelectYourSmartPens> {
  bool showDescription = true;
  int selectedBox = 0;
  int numberOfDevices = 0;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: _getScreen(context),
        backgroundColor: Color.fromRGBO(91, 95, 180, 1));
  }

  _getScreen(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        pinned: true,
        backgroundColor: Color.fromRGBO(91, 95, 180, 1),
        expandedHeight: 120.0,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.only(left: 8, right: 8, bottom: 16),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text('Select your smart pens'),
            ],
          ),
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
      new SliverFillRemaining(
        hasScrollBody: false,
        child: new Container(
          padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
          color: Colors.white,
          child: Column(
            children: [
              Expanded(flex: 1, child: Container()),
              Row(
                children: [
                  Expanded(
                      child: FlatButton(
                    onPressed: selectedBox != 0
                        ? () {
                            _showModal(context);
                          }
                        : null,
                    child: Text("Next"),
                    color: Color.fromRGBO(91, 95, 180, 1),
                    disabledColor: Color.fromRGBO(91, 95, 180, 0.2),
                    disabledTextColor: Color.fromRGBO(91, 95, 180, 1),
                    height: 40,
                    textColor: Colors.white,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                  ))
                ],
              )
            ],
          ),
        ),
      )
    ]);
  }

  _bottomView() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(children: [
        _getBox(BoxType.AllStar),
        _getBox(BoxType.Embody),
        _getBox(BoxType.Qr)
      ]),
    );
  }

  _getBox(BoxType box) {
    String title;
    String description;
    String image;
    int boxID;

    switch (box) {
      case BoxType.AllStar:
        {
          title = "AllStart Connect";
          description = "Reusable connected smart pens";
          image = "lib/assets/twoAllstars.png";
          boxID = 1;
        }
        break;
      case BoxType.Embody:
        {
          title = "Embody Connect";
          description = "Smart base for disposable pens";
          image = "lib/assets/twoEmbodys.png";
          boxID = 2;
        }
        break;
      case BoxType.Qr:
        {
          title = "Scan your QR code";
          description = "Scan the code on your smart pen box";
          image = "lib/assets/qr.png";
          boxID = 3;
        }
    }

    return GestureDetector(
        onTap: () {
          switch (box) {
            case BoxType.AllStar:
              {
                setState(() {
                  selectedBox = 1;
                });
              }
              break;
            case BoxType.Embody:
              {
                setState(() {
                  selectedBox = 2;
                });
              }
              break;
            case BoxType.Qr:
              {
                setState(() {
                  selectedBox = 3;
                });
              }
          }
        },
        child: Row(
          children: [
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                  color: ((boxID == selectedBox)
                      ? Color.fromRGBO(91, 95, 180, 0.2)
                      : Colors.white)),
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(8),
              child: Row(children: [
                Expanded(
                    flex: 2,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(title,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(description,
                                style: TextStyle(fontSize: 18)),
                          ),
                        ])),
                Image(
                    image: AssetImage(image), height: 100, fit: BoxFit.fitWidth)
              ]),
            ))
          ],
        ));
  }

  void _showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => BottomSheet(),
    );
  }
}

enum BoxType { AllStar, Embody, Qr }

class BottomSheet extends StatefulWidget {
  @override
  BottomSheetState createState() => BottomSheetState();
}

class BottomSheetState extends State<BottomSheet> {
  int numberOfDevices = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 335,
      margin: EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 16),
      child: Column(
        children: [
          Text(
            'How many AllStar Connect insuling pens do you have?',
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      numberOfDevices = 1;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(10.0),
                      color: (numberOfDevices == 1)
                          ? Color.fromRGBO(91, 95, 180, 0.2)
                          : Colors.white,
                    ),
                    child: Column(
                      children: [
                        Text(
                          '1 pen',
                          style: TextStyle(fontSize: 20),
                        ),
                        Image(
                          image: AssetImage('lib/assets/oneAllStar.png'),
                          height: 100,
                          fit: BoxFit.fitWidth,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      numberOfDevices = 2;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(10.0),
                      color: (numberOfDevices == 2)
                          ? Color.fromRGBO(91, 95, 180, 0.2)
                          : Colors.white,
                    ),
                    child: Column(
                      children: [
                        Text(
                          '2 pens',
                          style: TextStyle(fontSize: 20),
                        ),
                        Image(
                          image: AssetImage('lib/assets/twoAllstars.png'),
                          height: 100,
                          fit: BoxFit.fitWidth,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: FlatButton(
                  onPressed: numberOfDevices == 0
                      ? null
                      : () {
                          _goToNextStep();
                        },
                  child: Text('Next'),
                  disabledColor: Color.fromRGBO(91, 95, 180, 0.2),
                  color: Color.fromRGBO(91, 95, 180, 1),
                  textColor: Colors.white,
                  disabledTextColor: Color.fromRGBO(91, 95, 180, 0.5),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: FlatButton(
                  onPressed: () => {
                    Navigator.of(context).pop(),
                    setState(() {
                      numberOfDevices = 0;
                    })
                  },
                  child: Text('Back'),
                  color: Color.fromRGBO(91, 95, 180, 1),
                  textColor: Colors.white,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _goToNextStep() {
    Navigator.of(context).pushNamed('/sign-in');
  }
}

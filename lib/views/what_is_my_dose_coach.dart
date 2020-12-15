import 'package:flutter/material.dart';

class WhatIsMyDoseCoach extends StatefulWidget {
  @override
  createState() => WhatIsMyDoseCoachState();
}

class WhatIsMyDoseCoachState extends State<WhatIsMyDoseCoach> {
  bool showDescription = true;
  double opacity = 1.0;
  ScrollController _controller;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: _getScreen(context),
        backgroundColor: Color.fromRGBO(91, 95, 180, 1));
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (_controller.offset >= 90) {
      setState(() {
        showDescription = false;
      });
    } else {
      setState(() {
        showDescription = true;
      });
    }
  }

  _getScreen(BuildContext context) {
    return CustomScrollView(
      controller: _controller,
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          backgroundColor: Color.fromRGBO(91, 95, 180, 1),
          expandedHeight: 200.0,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(left: 8, right: 8, bottom: 16),
            title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('What is My Dose Coach?'),
                  Visibility(
                    child: Text(
                        'My Dose Coach connects your smart insulin pens to a digital logbook, helps you dose safely, and links to your diabetes apps.',
                        style: TextStyle(fontSize: 12)),
                    visible: showDescription,
                  )
                ]),
          ),
        ),
        SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
          return _bottomView();
        }, childCount: 1)),
      ],
    );
  }

  _bottomView() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('My Dose Coach works with:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 30),
          Text('AllStar Connect',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Image(image: AssetImage("lib/assets/pen1.png"), width: 200),
          SizedBox(height: 20),
          Text(
            'AllStar Connect is a reusable Bluetooth-enabled pen for use with 3ml Sanofi insulin cartridges. The pen automatically captures, stores, and transmits ypur dose to My Dose Coach.',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 30),
          Text('Embody Connect',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Image(image: AssetImage("lib/assets/pen2.png"), width: 200),
          SizedBox(height: 20),
          Text(
            'Mallya is a reusable Bluetooth-enabled smart base that connects to you disposable insulin pens. Mallya automatically captures, stores, and transmits your dose to My Dose Coach.',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          Row(children: [
            Expanded(
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/returning-user');
                },
                child: Text("Learn more and get a smart pen"),
                color: Color.fromRGBO(91, 95, 180, 1),
                textColor: Colors.white,
                height: 40,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
              ),
            )
          ]),
          SizedBox(height: 20),
          Row(children: [
            Expanded(
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/select-your-smart-pens');
                },
                child: Text("I have a smart pen"),
                color: Color.fromRGBO(91, 95, 180, 0.2),
                height: 40,
                textColor: Color.fromRGBO(91, 95, 180, 1),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
              ),
            )
          ])
        ],
      ),
    );
  }
}

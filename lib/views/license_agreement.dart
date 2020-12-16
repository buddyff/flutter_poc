import 'package:flutter/material.dart';

class LicenseAgreement extends StatefulWidget {
  @override
  createState() => LicenseAgreementState();
}

class LicenseAgreementState extends State<LicenseAgreement> {
  ScrollController _controller;
  bool showDescription = true;

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
                    'End user license agreement',
                    textAlign: TextAlign.left,
                  ),
                  Visibility(
                    child: Text('Please read and accept this statement',
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
        padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
        child: Column(
          children: [
            Text(
              'My Dose Coach End User License Agreement',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              style: TextStyle(fontSize: 19),
            ),
            SizedBox(height: 60),
            Row(
              children: [
                Expanded(
                    child: FlatButton(
                  child: Text('I accept'),
                  color: Color.fromRGBO(91, 95, 180, 1),
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pushNamed("");
                  },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ))
              ],
            )
          ],
        ));
  }
}

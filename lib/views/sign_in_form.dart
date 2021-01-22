import 'package:flutter/material.dart';
import 'package:flutter_poc/models/user.dart';
import 'package:flutter_poc/repositories/user_repository.dart';

class SignInForm extends StatefulWidget {
  @override
  createState() => SignInFormState();
}

class SignInFormState extends State<SignInForm> {
  bool showDescription = true;
  String selectedDate = "";
  ScrollController _controller;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

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
                    'About you',
                    textAlign: TextAlign.left,
                  ),
                  Visibility(
                    child: Text(
                        'So we can get to know you, please tell us a little about yourself.',
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
        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'First name',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Text(
                  'Last name',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _lastNameController,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Text(
                  'Date of birth',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _dateController,
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2019, 1),
                        lastDate: DateTime(2021, 12),
                      ).then(
                        (value) => setState(() {
                          if (value != null) {
                            setState(() {
                              selectedDate = value.toString();
                              _dateController.text = selectedDate;
                            });
                          }
                        }),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Text(
              'Contact information',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 20),
            Text(
              'This will help us identify you and allow us to send you important updates.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 50),
            Row(
              children: [
                Text(
                  'Phone number',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Text(
                  'Email',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _emailController,
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Text(
              'Your doctor',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 20),
            Text(
              'If you have medical questions, you can contact your care team directly from My Dose Coach.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 50),
            Row(
              children: [
                Text(
                  "Doctor's phone number",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 80),
            Row(
              children: [
                Expanded(
                  child: FlatButton(
                    onPressed: _isValidForm()
                        ? () {
                            _saveForm();
                            Navigator.of(context)
                                .pushNamed('/license-agreement');
                          }
                        : null,
                    child: Text('Next'),
                    color: Color.fromRGBO(91, 95, 180, 1),
                    disabledColor: Color.fromRGBO(91, 95, 180, 0.2),
                    textColor: Colors.white,
                    disabledTextColor: Color.fromRGBO(91, 95, 180, 0.4),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  _isValidForm() {
    return _nameController.text != "" &&
        _nameController.text != null &&
        _lastNameController.text != "" &&
        _lastNameController.text != null &&
        _dateController.text != "" &&
        _dateController.text != null &&
        _phoneController.text != "" &&
        _phoneController.text != null &&
        _emailController.text != "" &&
        _emailController.text != null;
  }

  void _saveForm() async {
    UserRepository().saveUser(
      User(
        name: _nameController.text,
        lastName: _lastNameController.text,
        birthDate: _dateController.text,
        phone: _phoneController.text,
        email: _emailController.text,
      ),
    );
  }
}

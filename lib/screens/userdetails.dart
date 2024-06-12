import 'package:flutter/material.dart';
import 'package:campus_connect/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:campus_connect/screens/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class MyUser extends StatefulWidget {
  static const String id = 'user';
  @override
  State<MyUser> createState() => _UserState();
}

class _UserState extends State<MyUser> {
  late String name, phone, linkedIn;
  bool showSpinner=false;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late String dropdownCollege = 'Model Engineering College';
  late String dropdownGender = 'Male';
  late String dropdownBranch = 'Computer Science';
  late String dropdownYear = '1';
  late String dropdownRole = 'Student';
  late String dropdownSem= 'S1';
  late String dropdownDiv='A';
  late User loggedinUser;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
        print(loggedinUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Tell us more about you',
          style: kreusablecardtextstyle.copyWith(
              color: Colors.black, fontSize: 22),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'What Should we call you?',
                      style: kreusablecardtextstyle.copyWith(color: Colors.black),
                    ),
                  ),//What Should we call you?'
                  widthbox,
                  TextField(
                    keyboardType: TextInputType.name,
                    textAlign: TextAlign.left,
                    onChanged: (value) {
                      name = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Your Name/ Name of Organisation',
                    ),
                  ), //name
                  widthbox,
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Choose Your Institution?',
                      style: kreusablecardtextstyle.copyWith(color: Colors.black),
                    ),
                  ), //'Choose Your Institution?'
                  widthbox,
                  Container(
                    child: DropdownButton<String>(
                      value: dropdownCollege,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 5,
                      style: kreusablecardtextstyle.copyWith(
                          color: Colors.black, fontSize: 17),
                      underline: Container(
                        height: 1,
                        color: Colors.red,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownCollege = newValue!;
                        });
                      },
                      items: <String>['Model Engineering College']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ), // for college
                  widthbox,
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'What is your Major?',
                      style: kreusablecardtextstyle.copyWith(color: Colors.black),
                    ),
                  ),
                  widthbox,
                  Container(

                    child: DropdownButton<String>(
                      value: dropdownBranch,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 5,
                      style: kreusablecardtextstyle.copyWith(
                          color: Colors.black, fontSize: 17),
                      underline: Container(
                        height: 1,
                        color: Colors.red,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownBranch = newValue!;
                        });
                      },
                      items: <String>['Computer Science', 'Electronics', 'Electrical', 'Bio-Medical', 'Mechanical']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  widthbox,
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Which year?',
                      style: kreusablecardtextstyle.copyWith(color: Colors.black),
                    ),
                  ),
                  widthbox,//for branch
                  DropdownButton<String>(
                    value: dropdownYear,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 5,
                    style: kreusablecardtextstyle.copyWith(
                        color: Colors.black, fontSize: 17),
                    underline: Container(
                      height: 1,
                      color: Colors.red,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownYear = newValue!;
                      });
                    },
                    items: <String>['1', '2', '3', '4']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  widthbox,
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Which Semester?',
                      style: kreusablecardtextstyle.copyWith(color: Colors.black),
                    ),
                  ),
                  widthbox,//for branch
                  DropdownButton<String>(
                    value: dropdownSem,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 5,
                    style: kreusablecardtextstyle.copyWith(
                        color: Colors.black, fontSize: 17),
                    underline: Container(
                      height: 1,
                      color: Colors.red,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownSem = newValue!;
                      });
                    },
                    items: <String>['S1', 'S2', 'S3', 'S4','S5','S6','S7','S8']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  widthbox,
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Which Division?',
                      style: kreusablecardtextstyle.copyWith(color: Colors.black),
                    ),
                  ),
                  widthbox,//for branch
                  DropdownButton<String>(
                    value: dropdownDiv,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 5,
                    style: kreusablecardtextstyle.copyWith(
                        color: Colors.black, fontSize: 17),
                    underline: Container(
                      height: 1,
                      color: Colors.red,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownDiv = newValue!;
                      });
                    },
                    items: <String>['A', 'B','-']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  //for year
                  widthbox,
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Are you a student, faculty or Organisation?',
                      style: kreusablecardtextstyle.copyWith(color: Colors.black),
                    ),
                  ),
                  widthbox,
                  DropdownButton<String>(
                    value: dropdownRole,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 5,
                    style: kreusablecardtextstyle.copyWith(
                        color: Colors.black, fontSize: 17),
                    underline: Container(
                      height: 1,
                      color: Colors.red,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownRole = newValue!;
                      });
                    },
                    items: <String>['Student', 'Faculty', 'Organisation']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ), //for faculty/student
                  widthbox,
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'What is your gender?',
                      style: kreusablecardtextstyle.copyWith(color: Colors.black),
                    ),
                  ),
                  widthbox,
                  DropdownButton<String>(
                    value: dropdownGender,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 5,
                    style: kreusablecardtextstyle.copyWith(
                        color: Colors.black, fontSize: 17) ,
                    underline: Container(
                      height: 1,
                      color: Colors.red,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownGender = newValue!;
                      });
                    },
                    items: <String>['Male', 'Female', 'Other']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ), //for gender
                  widthbox,
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Your LinkedIn profile link',
                      style: kreusablecardtextstyle.copyWith(color: Colors.black),
                    ),
                  ),
                  widthbox,

                  TextField(
                    keyboardType: TextInputType.url,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      linkedIn = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter Your LinkedIn URL',
                    ),
                  ), //linkedin
                  widthbox,
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'What is your mobile no.?',
                      style: kreusablecardtextstyle.copyWith(color: Colors.black),
                    ),
                  ),
                  widthbox,
                  TextField(
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      phone = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Phone No.',
                    ),
                  ), //whatsapp
                  widthbox,
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Material(
                      color: Colors.red.shade800,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      elevation: 5.0,
                      child: MaterialButton(
                        onPressed: () async {
                          setState(() {
                            showSpinner=true;
                          });
                          try {
                            DocumentReference<Map<String, dynamic>> users= _firestore.collection('userdetails').doc('${loggedinUser.email}');

                              var data= ({
                              'name': name,
                              'phone': phone,
                              'gender': dropdownGender,
                              'college': dropdownCollege,
                              'branch': dropdownBranch,
                              'year': dropdownYear,
                              'role': dropdownRole,
                              'linkedin': linkedIn,
                              'email': loggedinUser.email,
                                'div': dropdownDiv,
                                'sem': dropdownSem
                            });
                              users.set(data);
                            setState(() {
                              showSpinner=false;
                            });
                            Navigator.pushNamedAndRemoveUntil(
                                context, Home.id, (_) => false);
                          } catch (e) {
                            print(e);
                          }
                        },
                        minWidth: 200.0,
                        height: 42.0,
                        child: Text(
                          'Continue',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ), //continue button
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

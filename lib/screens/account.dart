import 'package:flutter/material.dart';
import 'package:campus_connect/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:campus_connect/components/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:campus_connect/screens/welcomescreen.dart';
import 'package:campus_connect/components/reusablecontainer.dart';
import 'package:campus_connect/screens/lights.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Account extends StatefulWidget {
  static const String id = 'account';
  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool showSpinner=false;
  late String div;
  late String name;
  late String branch;
  late String college;
  late String gender;
  late String phone;
  late String linkedin;
  late String role;
  final _auth = FirebaseAuth.instance;
  late User loggedinUser;
  final _firestore = FirebaseFirestore.instance;

  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {

      final user = await _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
        var person = await FirebaseFirestore.instance
            .collection('userdetails')
            .doc('${loggedinUser.email}')
            .get();
        if (person.exists) {
          print('user found');
          Map<String, dynamic>? details = person.data()!;
          setState(() {
            name = details['name'];
            branch = details['branch'];
            div= details['div'];
            college = details['college'];
            gender = details['gender'];
            phone = details['phone'];
            linkedin = details['linkedin'];
            role = details['role'];
          });
        }
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
        title: Text('BlackBoard',
        style: kAppnameText,),
      ),
      bottomNavigationBar: Navbar(),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widthbox,
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  alignment: Alignment.centerLeft,
                  child: Text('Account Settings',
                      style: kreusablecardtextstyle.copyWith(color: Colors.black, fontSize: 25)),
                ),
                widthbox,
                TextButton(
                  onPressed: () { Navigator.pushNamed(context, WebSocketLed.id); },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    alignment: Alignment.centerLeft,
                    child: ReusableContainer('Device Controls',40, double.infinity) ,
                  ),
                ),
                TextButton(onPressed: () {  },
                child: ReusableContainer('Update Profile',40, double.infinity)),
                widthbox,
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    color: Colors.red.shade800,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () async {
                        Navbar.setindex();
                        try{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.remove("name");
                          prefs.remove("branch");
                          prefs.remove("sem");
                          prefs.remove("email");
                          prefs.remove("phone");
                          prefs.remove("linkedin");
                          prefs.remove("role");
                          prefs.remove("college");
                          prefs.remove("gender");
                          prefs.remove("div");
                          prefs.remove("year");
                          _auth.signOut();
                          Navigator.pushNamedAndRemoveUntil(context, WelcomeScreen.id, (_) => false);
                        } catch (e) {
                          print(e);
                        }
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Logout',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ), //Log-Out button



              ],
            ),
          ),

        ),
      ),
    );
  }
}

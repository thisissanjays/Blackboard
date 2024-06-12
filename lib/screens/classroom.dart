import 'package:campus_connect/screens/semester.dart';
import 'package:flutter/material.dart';
import 'package:campus_connect/constants.dart';
import 'package:campus_connect/components/reusablecontainer.dart';
import 'package:campus_connect/components/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:campus_connect/screens/uploadnotes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:campus_connect/main.dart';

class Classroom extends StatefulWidget {
  static const String id='classroom';


  @override
  State<Classroom> createState() => ClassroomState();
}

class ClassroomState extends State<Classroom> {
  bool isFac = false;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late User loggedinUser;
  late String name;
  late String branch;
  late String div;
  late String sem;
  late String college;
  late String email;
  late String gender;
  late String linkedin;
  late String phone;
  late String role;
  late String year;


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
          role = details['role'];
          print(role);
          if (role == 'Faculty') {
            setState(() {
              isFac = true;
            });
            print(isFac);
          } else {
            print(isFac);
          }
          print(loggedinUser.email);
        }
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Container(
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                alignment: Alignment.centerLeft,
                child: Text('Choose Your Department',
                  style: kreusablecardtextstyle.copyWith(color: Colors.black, fontSize: 25)),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                           branchpref.setvalues('Electronics');
                            Navigator.pushNamed(context, Semester.id) ; },
                          child: ReusableContainer('Electronics and Communication',150,200)),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: ()  {
                            branchpref.setvalues('Computer Science');
                            Navigator.pushNamed(context, Semester.id) ; },
                          child: ReusableContainer('Computer Science',150,200)),
                    )]
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            branchpref.setvalues('Electrical');
                        Navigator.pushNamed(context, Semester.id ) ; },
                          child: ReusableContainer('Electrical and Electronics',150,150)),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            branchpref.setvalues('Bio-Medical');
                            Navigator.pushNamed(context, Semester.id) ;  },
                          child: ReusableContainer('Electrical and Bio-Med',150,150)),
                    )
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: ()  {
                          branchpref.setvalues('Mechanical');
                          Navigator.pushNamed(context, Semester.id) ; },
                        child: ReusableContainer('Mechanical Engineering',150,150)),
                  ),
                ],
              ),
            ],
          ),
        ),

      ),
      floatingActionButton: (isFac)? Postbutton(): null,
    );
  }
}
class Postbutton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, UploadNotes.id) ;
        },
        backgroundColor: Colors.red,
        elevation: 10,
        icon: Icon(
          Icons.post_add_rounded,
        ),
        label: const Text('Upload notes'));
  }
}

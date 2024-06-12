import 'package:flutter/material.dart';
import 'package:campus_connect/constants.dart';
import 'package:campus_connect/components/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:campus_connect/screens/updates.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:campus_connect/screens/uploadnotes.dart';

class Courses extends StatefulWidget {
  static const String id = 'courses';
  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
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

  // void sharedpref() async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     name= prefs.getString('name')!;
  //     branch= prefs.getString('branch')!;
  //     year= prefs.getString('year')!;
  //     div= prefs.getString('div')!;
  //     sem= prefs.getString('sem')!;
  //     college= prefs.getString('college')!;
  //     email= prefs.getString('email')!;
  //     gender= prefs.getString('gender')!;
  //     linkedin= prefs.getString('linkedin')!;
  //     phone= prefs.getString('phone')!;
  //     role= prefs.getString('role')!;
  //   });
  //
  //
  //   if(role=='Faculty'){
  //     setState(() {
  //       isFac= true;
  //     });
  //   }
  // }
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
            role = details['role'];
            name = details['name'];
            branch = details['branch'];
            div = details['div'];
            sem = details['sem'];
            college = details['college'];
            email = details['email'];
            gender = details['gender'];
            linkedin = details['linkedin'];
            phone = details['phone'];
            year = details['year'];
          });

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

  // void getCurrentUser() async {
  //   try {
  //     final user = await _auth.currentUser;
  //     if (user != null) {
  //       loggedinUser = user;
  //       var person = await FirebaseFirestore.instance
  //           .collection('userdetails')
  //           .doc('${loggedinUser.email}')
  //           .get();
  //       if (person.exists) {
  //         print('user found');
  //         Map<String, dynamic>? details = person.data()!;
  //         String role = details['role'];
  //         print(role);
  //         if (role == 'Faculty') {
  //           setState(() {
  //             isFac = true;
  //           });
  //           print(isFac);
  //         } else {
  //           print(isFac);
  //         }
  //         print(loggedinUser.email);
  //       }
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // void Courses() async {
  //   try {
  //     final user = await _auth.currentUser;
  //     if (user != null) {
  //       loggedinUser = user;
  //       final courses = _firestore
  //           .collection('courses')
  //           .get();
  //       if (courses.exists) {
  //         print('user found');
  //         Map<String, dynamic>? details = courses.data()!;
  //         String role = details['role'];
  //         String branch= details['branch'];
  //         String year= details['year'];
  //         print(role);
  //         if (role == 'Faculty') {
  //           setState(() {
  //             isFac = true;
  //           });
  //           print(isFac);
  //         } else {
  //           print(isFac);
  //         }
  //         print(loggedinUser.email);
  //       }
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    // getUsertype();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'BlackBoard',
          textAlign: TextAlign.center,
          style: kAppnameText,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                alignment: Alignment.topLeft,
                child: Text('Enrolled Courses',
                    style: kreusablecardtextstyle.copyWith(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('courses').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text(
                        'Nothing to Show',
                        style: kreusablecardtextstyle.copyWith(
                            color: Colors.black45),
                      ),
                    );
                  }
                  List<QueryDocumentSnapshot<Object?>> courses =
                      snapshot.data!.docs;
                  List<ListTile> Courses = [];
                  for (var course in courses) {
                    var fcoursename = course['coursename'];
                    print(fcoursename);
                    var fbranch = course['branch'];
                    print(fbranch);
                    var fdiv = course['div'];
                    var ffacultyname = course['facultyname'];
                    var fsem = course['sem'];

                    if ((fsem == sem) && (fbranch == branch) && (fdiv == div)) {
                      final course = ListTile(
                        title: fcoursename,
                        subtitle: ffacultyname,
                        onTap: () {
                          Navigator.pushNamed(context, UploadNotes.id);
                        },
                      );
                      Courses.add(course);
                    }
                  }
                  return Expanded(
                      child: ListView(
                    children: Courses,
                  ));
                },
              )
            ],
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: Navbar(),
      floatingActionButton: (isFac) ? Postbutton() : null,
    );
  }
}

class Postbutton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Colors.red,
        elevation: 10,
        icon: Icon(
          Icons.post_add_rounded,
        ),
        label: const Text('New Course'));
  }
}

class CourseBubble extends StatelessWidget {
  final String coursename;
  final String facultyname;
  CourseBubble(this.coursename, this.facultyname);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(color: Colors.black, width: 0.1),
            bottom: BorderSide(color: Colors.black, width: 0.1),
            left: BorderSide(color: Colors.black, width: 0.1),
            right: BorderSide(color: Colors.black, width: 0.1)),
      ),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            coursename,
            style: kreusablecardtextstyle.copyWith(
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            facultyname,
            style: kreusablecardtextstyle.copyWith(
                fontSize: 15, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

// StreamBuilder<QuerySnapshot>(
// stream: _firestore.collection('courses').snapshots(),
// builder: (BuildContext context,
//     AsyncSnapshot<QuerySnapshot> snapshot) {
// if (!snapshot.hasData) {
// return Center(
// child: Text(
// 'Nothing to Show',
// style: kreusablecardtextstyle.copyWith(color: Colors.black45),
// ),
// );
// }
// List<QueryDocumentSnapshot<Object?>> courses =
// snapshot.data!.docs;
// List<MessageBubble> messageBubbles = [];
// for (var course in courses) {
// var updateBranch = course['branch'];
// print(updateBranch);
// final updateYear = course['year'];
// print(updateYear);
//
// final currentUser = loggedinUser.email;
//
// final messageBubble = MessageBubble(updateSender, updateText);
//
// messageBubbles.add(messageBubble);
// }
// return Expanded(
// child: ListView(
// padding:
// EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
// children: messageBubbles,
// ),
// );
// },
// )

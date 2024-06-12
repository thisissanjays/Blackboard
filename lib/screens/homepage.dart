import 'package:flutter/material.dart';
import 'package:campus_connect/constants.dart';
import 'package:campus_connect/components/reusablecontainer.dart';
import 'package:campus_connect/components/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:campus_connect/screens/updates.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  static const String id = 'home';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isOrg = false;
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
          name= details['name'];
          branch = details['branch'];
          div= details['div'];
          sem = details['sem'];
          college= details['college'];
          email = details['email'];
          gender= details['gender'];
          linkedin = details['linkedin'];
          phone= details['phone'];
          year = details['year'];
          print(role);
          if (role == 'Organisation') {
            setState(() {
              isOrg = true;
            });
            print(isOrg);
          } else {
            print(isOrg);
          }
          print(loggedinUser.email);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  // void sharedpref() async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('name', name);
  //   prefs.setString('branch', branch);
  //   prefs.setString('div', div);
  //   prefs.setString('sem', sem);
  //   prefs.setString('college', college);
  //   prefs.setString('email', email);
  //   prefs.setString('gender', gender);
  //   prefs.setString('linkedin', linkedin);
  //   prefs.setString('phone', phone);
  //   prefs.setString('role', role);
  //   prefs.setString('year', year);
  // }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              alignment: Alignment.topLeft,
              child: Text('DashBoard',
                  style: kreusablecardtextstyle.copyWith(
                      color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('updates').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Text(
                      'Nothing to Show',
                      style: kreusablecardtextstyle.copyWith(color: Colors.black45),
                    ),
                  );
                }
                List<QueryDocumentSnapshot<Object?>> messages =
                    snapshot.data!.docs;
                List<MessageBubble> messageBubbles = [];
                for (var message in messages) {
                  var updateText = message['message'];
                  print(updateText);
                  final updateSender = message['sender'];
                  print(updateSender);

                  final currentUser = loggedinUser.email;

                  final messageBubble = MessageBubble(updateSender, updateText);

                  messageBubbles.add(messageBubble);
                }
                return Expanded(
                  child: ListView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    children: messageBubbles,
                  ),
                );
              },
            )
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: Navbar(),
      floatingActionButton: (isOrg) ? Postbutton() : null,
    );
  }
}

class Postbutton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, Updates.id);
        },
        backgroundColor: Colors.red,
        elevation: 10,
        icon: Icon(
          Icons.post_add_rounded,
        ),
        label: const Text('Post'));
  }
}

class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  MessageBubble(this.sender, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black, width: 0.1),
          bottom: BorderSide(color: Colors.black, width: 0.1),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: kreusablecardtextstyle.copyWith(color: Colors.black, ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: kreusablecardtextstyle.copyWith(fontSize: 15, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

// body: SafeArea(
// child: SingleChildScrollView(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Container(
// padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20) ,
// alignment: Alignment.topLeft,
// child: Text('DashBoard',
// style: kreusablecardtextstyle.copyWith(color: Colors.black, fontSize: 25)),
// ),
// SizedBox(height: 20,),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// Expanded(child: TextButton(onPressed: () {  },
// child: ReusableContainer('Office Updates',150,150))),
// SizedBox(width: 10,),
// Expanded(child: TextButton(onPressed: () {  },
// child: ReusableContainer('Training Cell',150,150))),
// ],
// ),
// SizedBox(height: 10,),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// Expanded(child: TextButton(onPressed: () {  },
// child: ReusableContainer('Placement Cell',150,150))),
// SizedBox(width: 10,),
// Expanded(child: TextButton(onPressed: () {  },
// child: ReusableContainer('Excel',150,150))),
// ],
// ),
// SizedBox(height: 10,),
// TextButton(onPressed: () {  },
// child: ReusableContainer('Clubs',150,150))
// ],
// ),
// ),
//
// ),

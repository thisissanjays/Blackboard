import 'package:flutter/material.dart';
import 'package:campus_connect/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:campus_connect/components/navbar.dart';

class Connect extends StatefulWidget {
  static const String id ='connect';
  @override
  State<Connect> createState() => _ConnectState();
}

class _ConnectState extends State<Connect> {
  bool showSpinner= false;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late User loggedinUser;

  void getCurrentUser() async {
    setState(() {
      showSpinner=true;
    });
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
        }
        print(loggedinUser.email);
      }
      setState(() {
        showSpinner=false;
      });
    } catch (e) {
      print(e);
    }
  }
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    // getUsertype();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner ,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                alignment: Alignment.topLeft,
                child: Text('Let\'s Connect',
                    style: kreusablecardtextstyle.copyWith(
                        color: Colors.black, fontSize: 25)),
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('userdetails').snapshots(),
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
                  List<QueryDocumentSnapshot<Object?>> messages =
                      snapshot.data!.docs;
                  List<MessageBubble> messageBubbles = [];
                  for (var message in messages) {
                    final name = message['name'];
                    final branch  = message['branch'];
                    final role  = message['role'];
                    final college  = message['college'];
                    final phone  = message['phone'];
                    final linkedin  = message['linkedin'];
                    final email  = message['email'];
                    final year  = message['year'];

                    final currentUser = loggedinUser.email;

                    final messageBubble = MessageBubble(name, email, role, branch, phone, college, linkedin, year);

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
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String name;
  final String email;
  final String role;
  final String branch;
  final String phone;
  final String college;
  final String linkedin;
  final String year;

  MessageBubble(this.name, this.email, this.role, this.branch, this.phone, this.college, this.linkedin, this.year);

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
            name,
            style: kreusablecardtextstyle.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            role,
            style: kreusablecardtextstyle.copyWith(
                fontSize: 12, color: Colors.black),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Year: ${year}',
                style: kreusablecardtextstyle.copyWith(
                    fontSize: 15, color: Colors.black),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                college,
                style: kreusablecardtextstyle.copyWith(
                    fontSize: 14, color: Colors.black),
              ),
            ],
          ),


        ],
      ),
    );
  }
}

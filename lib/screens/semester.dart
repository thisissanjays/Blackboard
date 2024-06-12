import 'package:campus_connect/screens/classroom.dart';
import 'package:campus_connect/screens/Notepage.dart';
import 'package:flutter/material.dart';
import 'package:campus_connect/constants.dart';
import 'package:campus_connect/components/reusablecontainer.dart';
import 'package:campus_connect/components/navbar.dart';
import 'package:campus_connect/screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:campus_connect/main.dart';


class Semester extends StatefulWidget {
  static const String id = 'semester';
  static const List route= [
    Home.id,
    Classroom.id,
  ];

  @override
  State<Semester> createState() => _SemesterState();
}

class _SemesterState extends State<Semester> {
  late String sem;
  late String branch;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
          title:Text('Semester',
            style: TextStyle(
              fontSize: 23,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w900,
            ),)
      ),
      bottomNavigationBar: Navbar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
              alignment: Alignment.topLeft,
              child: Text('Choose Your Semester',
                style: kreusablecardtextstyle.copyWith(color: Colors.black, fontSize: 25) ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(onPressed: () {
                    sempref.setvalues('S1');
                    Navigator.pushNamed(context, Notes.id) ;
                  },
                  child: ReusableContainer('S1',90,90)),
                  TextButton(onPressed: () {
                    sempref.setvalues('S2');
                    Navigator.pushNamed(context, Notes.id) ;
                    },
                  child: ReusableContainer('S2',90,90))]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(onPressed: () {
                    sempref.setvalues('S3');
                    Navigator.pushNamed(context, Notes.id) ;
                  },
                  child: ReusableContainer('S3',90,90)),
                  TextButton(onPressed: () {
                    sempref.setvalues('S4');
                    Navigator.pushNamed(context, Notes.id) ;
                    },
                  child: ReusableContainer('S4',90,90))]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(onPressed: () {
                    sempref.setvalues('S5');
                    Navigator.pushNamed(context, Notes.id) ;
                  },
                  child: ReusableContainer('S5',90,90)),
                  TextButton(onPressed: () {
                    sempref.setvalues('S6');
                    Navigator.pushNamed(context, Notes.id) ;
                  },
                  child: ReusableContainer('S6',90,90))]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(onPressed: () {
                    sempref.setvalues('S7');
                    Navigator.pushNamed(context, Notes.id) ;
                  },
                  child: ReusableContainer('S7',90,90)),
                  TextButton(onPressed: () {
                    sempref.setvalues('S8');
                    Navigator.pushNamed(context, Notes.id) ;
                  },
                  child: ReusableContainer('S8',90,90))]
            ),
          ],
        ),
      ),
    );
  }
}

// class reusablecontainer extends StatelessWidget {
//   const reusablecontainer({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         gradient: LinearGradient(
//           colors: [Colors.grey.shade500, Colors.blueGrey.shade800],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       width: 100,
//       height: 100,
//       alignment: Alignment.center,
//       child:
//       Text('$branch',
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           fontSize: 20,
//           fontFamily: 'Montserrat',
//           fontWeight: FontWeight.w700,
//           color: Colors.white,
//         ),),
//
//     );
//   }
// } //Semester Choosing Page

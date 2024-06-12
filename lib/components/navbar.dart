import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:campus_connect/screens/homepage.dart';
import 'package:campus_connect/screens/classroom.dart';
import 'package:campus_connect/screens/account.dart';
import 'package:campus_connect/screens/connect.dart';
import 'package:campus_connect/screens/courses.dart';
int _selectedIndex=0;
class Navbar extends StatefulWidget {
  static void setindex(){
    _selectedIndex=0;
  }

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {

  static const List route= [
    Home.id,
    Classroom.id,
    Connect.id,
    Account.id,
  ];

  void _screenchange(int index){
    setState(() {
      _selectedIndex=index;
    });
    Navigator.restorablePushNamedAndRemoveUntil(context, route[index], (_) => false);

  }

  @override
  Widget build(BuildContext context) {
    return DotNavigationBar(
      borderRadius: 20,
      enableFloatingNavBar: true,
      boxShadow: const [],
      paddingR: EdgeInsets.symmetric(vertical: 5),
      backgroundColor: Colors.black,
      unselectedItemColor: Colors.white,
      currentIndex: _selectedIndex,
      onTap: _screenchange ,
      items: [
        DotNavigationBarItem(
          icon: Icon(Icons.dashboard_rounded),
          selectedColor: Colors.red,
        ),

        /// Likes
        DotNavigationBarItem(
          icon: Icon(Icons.school_rounded),
          selectedColor: Colors.red,
        ),

        /// Search
        DotNavigationBarItem(
          icon: Icon(Icons.bolt_rounded),
          selectedColor: Colors.red,
        ),

        /// Profile
        DotNavigationBarItem(
          icon: Icon(Icons.blur_circular_rounded),
          selectedColor: Colors.red,
        ),

      ],

    ); ;
  }
}







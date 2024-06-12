import 'package:campus_connect/screens/Login.dart';
import 'package:campus_connect/screens/connect.dart';
import 'package:campus_connect/screens/registration.dart';
import 'package:campus_connect/screens/userdetails.dart';
import 'package:campus_connect/screens/welcomescreen.dart';
import 'package:flutter/material.dart';
import 'package:campus_connect/screens/semester.dart';
import 'package:campus_connect/screens/classroom.dart';
import 'package:campus_connect/screens/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:campus_connect/screens/account.dart';
import 'package:campus_connect/screens/updates.dart';
import 'package:campus_connect/screens/courses.dart';
import 'package:campus_connect/screens/lights.dart';
import 'package:campus_connect/screens/uploadnotes.dart';
import 'package:campus_connect/screens/Notepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await branchpref.init();
  await sempref.init();
  runApp(MaterialApp(
    home: MyApp(),
  ));
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          color: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white12,
          selectedIconTheme: IconThemeData(
            color: Colors.white12,
            size: 40,
          ),
          unselectedIconTheme: IconThemeData(
            color: Colors.white54,
            size: 35,
          ),
        ),
      ),
      initialRoute:
          Home.id,
      routes: <String, WidgetBuilder>{
        LoginScreen.id: (context)=> LoginScreen(),
        WelcomeScreen.id: (context)=> WelcomeScreen(),
        Home.id: (context)=>Home(),
        Semester.id : (context)=> Semester(),
        Classroom.id : (context)=> Classroom(),
        RegistrationScreen.id: (context)=> RegistrationScreen(),
        MyUser.id: (context)=> MyUser(),
        Account.id: (context)=> Account(),
        Updates.id: (context)=> Updates(),
        Connect.id: (context)=>Connect(),
        Courses.id: (context)=>Courses(),
        WebSocketLed.id: (context)=>WebSocketLed(),
        UploadNotes.id: (context)=>UploadNotes(),
        Notes.id: (context)=> Notes(),
      },
    );
  }
}
class branchpref {
  static SharedPreferences? _preferences;

  static const _keybranch = 'Electronics';
  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static Future setvalues(String displayName) async {
    await _preferences!.setString(_keybranch, displayName);
  }
  static String? getDisplayName() => _preferences!.getString(_keybranch);
}
class sempref {
  static SharedPreferences? _preferences;

  static const _keysem = 'S1';
  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static Future setvalues(String displayName) async {
    await _preferences!.setString(_keysem, displayName);
  }
  static String? getDisplayName() => _preferences!.getString(_keysem);
}


// class ReusableCard extends StatelessWidget {
//   int newIcon;
//   String branch;
//
//   ReusableCard( this.newIcon,this.branch){
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         backgroundBlendMode: BlendMode.darken ,
//         gradient: LinearGradient(
//         colors: [Colors.grey.shade500, Colors.blueGrey.shade800],
//         begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//     ),
//     ),
//       child:
//       Column(
//         children: [
//           iconlist[newIcon],
//           Text('$branch',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 15,
//               fontFamily: 'Montserrat',
//               fontWeight: FontWeight.w700,
//               color: Colors.white,
//             ),),
//         ],
//       ),
//
//     );
//   }
// }
//

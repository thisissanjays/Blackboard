import 'package:flutter/material.dart';
// import 'package:flutter/src/material/bottom_navigation_bar.dart';
void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      routes: <String, WidgetBuilder>{
        '/Semester': (context)=> Semester(),
        '/Branch' : (context)=> LoginPage(),
      },
    );
  }
}

dynamic iconlist= <dynamic>[
  Icon(
    Icons.cable_outlined,
    size: 100,
    color: Colors.white,
  ),
  Icon(
    Icons.settings_ethernet_outlined,
    size: 100,
  ),
  Icon(
    Icons.electrical_services_outlined,
    size: 100,
  ),
  Icon(
    Icons.biotech_outlined,
    size: 100,
  ),
  Icon(
    Icons.precision_manufacturing_outlined,
    size: 100,
  ),

];
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade800,
        title: Text('Notes',
        style: TextStyle(
          fontSize: 23,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w900,
        ),),
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.horizontal(left: Radius.circular(20.0), right: Radius.circular(20.0)),
            //     gradient: LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade600],
            //       begin: Alignment.topLeft,
            //       end: Alignment.bottomRight,
            //       tileMode: TileMode.clamp,
            //     )
            //   ),
            //   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            //   child: Row(
            //     children: [
            //       Icon(
            //         Icons.search_outlined,
            //         size: 20,
            //       ),
            //       SizedBox(
            //         width: 20,
            //       ),
            //       Text(
            //         'search',
            //         style: TextStyle(
            //           fontSize: 20,
            //         ),
            //       ),
            //     ],
            //   ),
            // ), //Search Bar
            Container(
              alignment: Alignment.centerLeft,
              child: Text('Choose Your Department',
              style: TextStyle(
                fontSize: 23,
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () { Navigator.pushNamed(context, '/Branch') ; },
                child: newcontainer(0,'Electronics and Communication')),
                TextButton(onPressed: () { Navigator.pushNamed(context, '/Semester') ; },
                child: newcontainer(1, 'Computer Science'))]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(onPressed: () { Navigator.pushNamed(context, '/Semester') ; },
                child: newcontainer(2,'Electrical and Electronics')),
                TextButton(onPressed: () { Navigator.pushNamed(context, '/Semester') ;  },
                child: newcontainer(3, 'Electrical and Bio-Med'))
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(onPressed: () { Navigator.pushNamed(context, '/Semester') ; },
                child: newcontainer(4, 'Mechanical Engineering')),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  int newIcon;
  String branch;

  ReusableCard( int no,String text){
    newIcon=no;
    branch= text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        backgroundBlendMode: BlendMode.darken ,
        gradient: LinearGradient(
        colors: [Colors.grey.shade500, Colors.blueGrey.shade800],
        begin: Alignment.topLeft,
          end: Alignment.bottomRight,
    ),
    ),
      child:
      Column(
        children: [
          iconlist[newIcon],
          Text('$branch',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),),
        ],
      ),

    );
  }
}

class Semester extends StatelessWidget {
  const Semester({Key? key}) : super(key: key);
  Container newcontainer(String branch){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Colors.grey.shade500, Colors.blueGrey.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      width: 100,
      height: 100,
      alignment: Alignment.center,
      child:
      Text('$branch',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),),

    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade800,
        title:Row(
          children: [
            Text('Semester',
            style: TextStyle(
              fontSize: 23,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w900,
            ),)
          ],
        )
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text('Choose Your Semester',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  newcontainer('S1'),
                  newcontainer('S2')]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  newcontainer('S3'),
                  newcontainer('S4')]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  newcontainer('S5'),
                  newcontainer('S6')]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  newcontainer('S7'),
                  newcontainer('S8')]
            ),
          ],
        ),
      ),
    );
  }
} //Semester Choosing Page

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade800,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Campus',
            style: TextStyle(
              fontFamily: 'DancingScript',
              fontSize: 26,
              fontWeight: FontWeight.w900,
            ),),
        Icon(
          Icons.chat_bubble_rounded,
        ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.blueGrey.shade900,
      //   items: [
      //   BottomNavigationBarItem(icon: Icon(
      //     Icons.home_rounded,
      //     size: 20,
      //   ),),
      //   BottomNavigationBarItem(icon: Icon(
      //     Icons.search,
      //     size: 20,
      //   ),),
      //   BottomNavigationBarItem(icon: Icon(
      //     Icons.notifications_rounded,
      //     size: 20,
      //   ),),
      //     BottomNavigationBarItem(icon: Icon(
      //       Icons.account_circle_rounded,
      //     ),)
      // ],
      //
      // ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () { Navigator.pushNamed(context, '/Branch') ; },
                      child: newcontainer('Notes')),
                  TextButton(onPressed: () {  },
                      child: newcontainer('Club Updates'))]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () { },
                      child: newcontainer('Mec Updates')),
                  TextButton(onPressed: () { },
                      child: newcontainer('Ktu Updates'))]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () { },
                      child: newcontainer('Placement and Training Updates')),
                ],
            ),
        ]
      ),
    )
    );
  }
}
// class Login extends StatelessWidget {
//   const Login({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blueGrey.shade800,
//         title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//         Text('Campus',
//         style: TextStyle(
//         fontFamily: 'DancingScript',
//         fontSize: 26,
//         fontWeight: FontWeight.w900,
//         ),)
//     );
//   }
// }

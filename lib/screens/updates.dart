import 'package:flutter/material.dart';
import 'package:campus_connect/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

final _firestore =FirebaseFirestore.instance;
late User loggedinUser;
class Updates extends StatefulWidget {
  static const String id='updates';
  @override
  _UpdatesState createState() => _UpdatesState();
}

class _UpdatesState extends State<Updates> {

  final _auth= FirebaseAuth.instance;
  late String messageText;
  late String name;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser()async{

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
          name = details['name'];
          print(loggedinUser.email);
        }
      }

    }catch(e){
      print(e);
    }

  }

  // void messageStream() async{
  //   await for(var snapshots in _firestore.collection('updates').snapshots()){
  //     for(var message in snapshots.docs){
  //
  //     }
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post',
        style: kreusablecardtextstyle.copyWith( color: Colors.black),),
        elevation: 0,
        actions: [
          MaterialButton(
            onPressed: () {
              _firestore.collection('updates').add({'message': messageText, 'sender' : name });
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                'Send',
                style: kreusablecardtextstyle.copyWith(fontSize: 18),
              ),
            ),
          ),

        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              Container(
                decoration: kMessageContainerDecoration,
                child: Expanded(
                  child: TextField(
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: 20,
                    onChanged: (value) {
                      messageText=value;
                    },
                    decoration: kMessageTextFieldDecoration,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class MessagesStream extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _firestore.collection('officeupdates').snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (!snapshot.hasData) {
//           return Center(
//             child: CircularProgressIndicator(
//               backgroundColor: Colors.redAccent,
//             ),
//           );
//         }
//         QuerySnapshot<Object?>? messages = snapshot.data;
//         List<MessageBubble> messageBubbles = [];
//         for (var message in messages) {
//           final messageText = message.data['text'];
//           final messageSender = message.data['sender'];
//
//           final currentUser = loggedinUser.email;
//
//           final messageBubble = MessageBubble(messageSender, messageText);
//
//           messageBubbles.add(messageBubble);
//         }
//         return Expanded(
//           child: ListView(
//             reverse: true,
//             padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
//             children: messageBubbles,
//           ),
//         );
//       },
//     );
//   }
// }



// class MessageBubble extends StatelessWidget {
//   final String sender;
//   final String text;
//   MessageBubble(this.sender, this.text);
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(10.0),
//       child: Column(
//         children: <Widget>[
//           Text(
//             sender,
//             style: TextStyle(
//               fontSize: 12.0,
//               color: Colors.black54,
//             ),
//           ),
//           Material(
//             borderRadius: isMe
//                 ? BorderRadius.only(
//                 topLeft: Radius.circular(30.0),
//                 bottomLeft: Radius.circular(30.0),
//                 bottomRight: Radius.circular(30.0))
//                 : BorderRadius.only(
//               bottomLeft: Radius.circular(30.0),
//               bottomRight: Radius.circular(30.0),
//               topRight: Radius.circular(30.0),
//             ),
//             elevation: 5.0,
//             color: isMe ? Colors.lightBlueAccent : Colors.white,
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//               child: Text(
//                 text,
//                 style: TextStyle(
//                   color: isMe ? Colors.white : Colors.black54,
//                   fontSize: 15.0,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

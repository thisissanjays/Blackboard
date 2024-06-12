import 'package:flutter/material.dart';

const kAppnameText = TextStyle(
  fontFamily: 'DancingScript',
  fontSize: 35,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.redAccent, width: 2.0),
  ),
);
const kSendButtonTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your password.',

  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10),
  ),),
  enabledBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.white, width: 0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.black38, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
  hintText: 'What\'s the announcement?',
  hintStyle: TextStyle(
    fontSize: 17,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,
    color: Colors.black45,
  ),
  border: InputBorder.none,
);

const kreusablecardtextstyle =TextStyle(
  fontSize: 17,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.w700,
  color: Colors.white,
);
const widthbox= SizedBox(
  height: 20,
);


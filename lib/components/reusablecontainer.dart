import 'package:flutter/material.dart';
import 'package:campus_connect/constants.dart';

class ReusableContainer extends StatelessWidget {
  double h=double.infinity;
  double w=double.infinity;
  String title;
  ReusableContainer(this.title, this.h,this.w);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          tileMode: TileMode.clamp,
          colors: [Colors.grey.shade500, Colors.blueGrey.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      height:h,
      width: w,
      alignment: Alignment.center,
      child:
      Text(title,
        textAlign: TextAlign.center,
        style: kreusablecardtextstyle
      ),

    );
  }
}
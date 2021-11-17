import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NothingToShow extends StatelessWidget {
  final String iconPath;
  final String primaryMessage;
  final String secondaryMessage;
  const NothingToShow({Key key,this.iconPath: "assets/icons/empty_box.svg",
    this.primaryMessage: "Nothing to show, sorry",
    this.secondaryMessage: ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Column(
        children: [
          SvgPicture.asset(
            iconPath,
            color: Color(0xFF757575),
            width: 75,
          ),
          SizedBox(height: 10,),
          Text(
            primaryMessage,style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 13,
            fontWeight: FontWeight.w800
          ),
          ),
          Text(secondaryMessage, style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),),
        ],
      ),
    );
  }
}

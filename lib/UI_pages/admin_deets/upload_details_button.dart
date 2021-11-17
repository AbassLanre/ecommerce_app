import 'package:ecommerce_app/utils/colors.dart';
import 'package:flutter/material.dart';

class DefaultUploadButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color;

  DefaultUploadButton({Key key,@required this.text,@required this.press, this.color = kPrimaryColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        onPressed: press,
        child: Text(text, style: TextStyle(color:Colors.white),),
      ),
    );
  }
}

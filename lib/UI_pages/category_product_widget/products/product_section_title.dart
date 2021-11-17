import 'package:flutter/material.dart';

class ProductSectionTitle extends StatelessWidget {
  final String title;
  final GestureTapCallback press;


  const ProductSectionTitle({Key key, @required this.title, @required this.press}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Nunito',
          fontSize: 19
        ),
      ),
    );
  }
}

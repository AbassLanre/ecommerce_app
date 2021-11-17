import 'package:flutter/material.dart';

class CustomSearchTextField extends StatelessWidget {

  final Function onSubmitted;
  CustomSearchTextField({@required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(27)
      ),
      child: TextField(
        onSubmitted: onSubmitted ,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: 'Search Product',
          hintStyle: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 15,
            fontWeight: FontWeight.w300,
            color: Colors.blueGrey,
          ),
          prefixIcon: Icon(Icons.search, color: Colors.blueGrey, size: 20,),

        ),
      ),
    );
  }
}

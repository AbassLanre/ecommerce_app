import 'package:flutter/material.dart';

import 'custom_text_search_field.dart';

class HeaderSection extends StatefulWidget {
  final Function onSearchSubmitted;
  HeaderSection({@required this.onSearchSubmitted});
  @override
  _HeaderSectionState createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Search text field
        Expanded(child: CustomSearchTextField(onSubmitted: widget.onSearchSubmitted,)),
        SizedBox(width: 5,),
        //notification icon
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.transparent)
          ),
          child: IconButton(
            icon: Icon(Icons.notifications_none_rounded,color: Colors.blue,size: 25,),
            onPressed: (){},
          ),
        ),

      ],
    );
  }
}

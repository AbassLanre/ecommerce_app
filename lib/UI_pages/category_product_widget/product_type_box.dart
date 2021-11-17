import 'package:ecommerce_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductTypeBox extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onPressed;

  const ProductTypeBox({Key key, @required this.icon, @required this.title, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      splashColor: kPrimaryColor,
      onTap: onPressed,
      child: AspectRatio(
          aspectRatio: 1.05,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.09),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: kPrimaryColor.withOpacity(0.18))
            ),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AspectRatio(
                        aspectRatio: 1,
                    child: SvgPicture.asset(icon, color: kPrimaryColor,),
                    ),
                  ),
                ),
                Text(
                  title,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 12,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          )),
    );
  }
}

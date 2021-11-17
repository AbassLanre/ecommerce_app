import 'package:ecommerce_app/UI_pages/category_product_widget/product_type_enum.dart';
import 'package:ecommerce_app/UI_pages/category_product_widget/products/product_section.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import '../custom_text_search_field.dart';

class CategoryProducts extends StatefulWidget {
  final ProductType productType;
  const CategoryProducts({Key key, @required this.productType}) : super(key: key);

  @override
  _CategoryProductsState createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  String bannerFromProductType(){
    switch (widget.productType){
      case ProductType.Electronics:
       return 'assets/images/electronics_banner.jpg';
      case ProductType.Books:
        return 'assets/images/books_banner.jpg';
      case ProductType.Fashion:
        return 'assets/images/fashions_banner.jpg';
      case ProductType.Groceries:
        return 'assets/images/groceries_banner.jpg';
      case ProductType.Art:
        return 'assets/images/arts_banner.jpg';
      case ProductType.Others:
        return 'assets/images/others_banner.jpg';
      default:
        return 'assets/images/others_banner.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 26,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.west_outlined,color: kPrimaryColor,),
                onPressed: (){Navigator.pop(context);},
              ),
              Expanded(child: CustomSearchTextField(onSubmitted: (value){},))
            ],
          ),
          SizedBox(height: 10,),
          SizedBox(
            height: (0.23) * MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(bannerFromProductType()),
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(kPrimaryColor, BlendMode.hue)
                    ),
                    borderRadius: BorderRadius.circular(25)
                  ),

                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(EnumToString.convertToString(widget.productType),style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                      color: Colors.white

                    ),),
                  ),
                ),
              ],

            ),
          ),
          SizedBox(height: 10,),
          ProductSection(sectionTitle: 'Products you like', emptyMessageToShow: 'No message to show here', productStreamController: null,),
        ],
      ),
    );
  }
}



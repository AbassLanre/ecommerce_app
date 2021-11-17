import 'package:ecommerce_app/UI_pages/category_product_page.dart';
import 'package:ecommerce_app/UI_pages/category_product_widget/products/product_section.dart';
import 'package:ecommerce_app/UI_pages/category_product_widget/products/product_section_title.dart';
import 'package:ecommerce_app/services/favourite_product_stream.dart';
import 'package:flutter/material.dart';

import 'category_product_widget/header_section.dart';
import 'category_product_widget/product_type_box.dart';
import 'category_product_widget/product_type_enum.dart';


const String ICON_KEY = 'icon';
const String TITLE_KEY = 'title';
const String PRODUCT_TYPE_KEY = 'product_type';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final productCategories = <Map<String, dynamic>>[
    {
      ICON_KEY: 'assets/icons/Electronics.svg',
      TITLE_KEY: 'Electronics',
      PRODUCT_TYPE_KEY: ProductType.Electronics,
    },
    {
      ICON_KEY: 'assets/icons/Books.svg',
      TITLE_KEY: 'Books',
      PRODUCT_TYPE_KEY: ProductType.Books,
    },
    {
      ICON_KEY: 'assets/icons/Fashion.svg',
      TITLE_KEY: 'Fashion',
      PRODUCT_TYPE_KEY: ProductType.Fashion,
    },
    {
      ICON_KEY: 'assets/icons/Groceries.svg',
      TITLE_KEY: 'Groceries',
      PRODUCT_TYPE_KEY: ProductType.Groceries,
    },
    {
      ICON_KEY: 'assets/icons/Art.svg',
      TITLE_KEY: 'Art',
      PRODUCT_TYPE_KEY: ProductType.Art,
    },
    {
      ICON_KEY: 'assets/icons/Others.svg',
      TITLE_KEY: 'Others',
      PRODUCT_TYPE_KEY: ProductType.Others,
    },
  ];
  //init
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favouriteProductStream.init();
  }

  //dispose
  @override
  void dispose(){
    favouriteProductStream.dispose();
    super.dispose();
  }


  final FavouriteProductStream favouriteProductStream = FavouriteProductStream();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 8,),
              // header section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: HeaderSection(
                  onSearchSubmitted: (value){
                    //hmmmmmm
                  },
                ),
              ),
              SizedBox(height: 10,),
              // category section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  height: 130,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      ...List.generate(productCategories.length,
                              (index) => ProductTypeBox(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (_)=> CategoryProductPage(productType: productCategories[index][PRODUCT_TYPE_KEY],)));
                                },
                                icon: productCategories[index][ICON_KEY],
                                title: productCategories[index][TITLE_KEY],)),
                    ],
                  ),
                ),
              ),
              ProductSection(sectionTitle: 'Products you like', productStreamController: favouriteProductStream)
            ],
          ),
        ),
      ),
    );  }
}

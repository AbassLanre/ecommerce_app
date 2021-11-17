
import 'package:flutter/material.dart';

import 'category_product_widget/categories/category_product.dart';
import 'category_product_widget/product_type_enum.dart';

class CategoryProductPage extends StatefulWidget {
  final ProductType productType;
  const CategoryProductPage({Key key, @required this.productType}) : super(key: key);

  @override
  _CategoryProductPageState createState() => _CategoryProductPageState();
}

class _CategoryProductPageState extends State<CategoryProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CategoryProducts(productType: widget.productType,),
    );
  }
}

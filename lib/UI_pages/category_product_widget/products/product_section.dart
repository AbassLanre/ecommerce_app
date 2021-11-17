import 'package:ecommerce_app/UI_pages/category_product_widget/products/nothing_to_show.dart';
import 'package:ecommerce_app/UI_pages/category_product_widget/products/product_section_title.dart';
import 'package:ecommerce_app/UI_pages/category_product_widget/products/single_product_card.dart';
import 'package:ecommerce_app/services/data_stream_services.dart';
import 'package:flutter/material.dart';

class ProductSection extends StatefulWidget {
  final String sectionTitle;
  final String emptyMessageToShow;
  final DataStream productStreamController;

  const ProductSection(
      {Key key,
      @required this.sectionTitle,
      @required this.productStreamController,
      this.emptyMessageToShow})
      : super(key: key);

  @override
  _ProductSectionState createState() => _ProductSectionState();
}

class _ProductSectionState extends State<ProductSection> {

  Widget buildProductGrid(List<String> productId) {
    return GridView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 4,
            childAspectRatio: 0.7,
            mainAxisSpacing: 4,
            crossAxisCount: 2,
        ),
        itemCount: productId.length,
        itemBuilder: (_, index) {
          return SingleProductCard(
            //single_product_card
          );
        });
  }

  Widget buildProductList() {
    return StreamBuilder<List<String>>(
        stream: widget.productStreamController.stream,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length == 0) {
              return Center(
                child: NothingToShow(
                  secondaryMessage: widget.emptyMessageToShow,
                ),
              );
            }
            return buildProductGrid(snapshot.data);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            final error = snapshot.error;
            return NothingToShow(
              iconPath: "assets/icons/empty_box.svg",
              primaryMessage: "Something went wrong somewhere",
              secondaryMessage: 'Unable to connect to database',
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xFFF5F6F5),
      ),
      child: Column(
        children: [
          ProductSectionTitle(
            title: widget.sectionTitle,
            press: () {},
          ),
          SizedBox(
            height: 10,
          ),
          buildProductList(),
        ],
      ),
    );
  }
}

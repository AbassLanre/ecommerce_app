import 'dart:io';

import 'package:ecommerce_app/UI_pages/admin_deets/upload_details_button.dart';
import 'package:ecommerce_app/UI_pages/category_product_widget/product_type_enum.dart';
import 'package:ecommerce_app/models/product_details.dart';
import 'package:ecommerce_app/services/choose_images_to_add.dart';
import 'package:ecommerce_app/services/exceptions/image_picking_exceptions.dart';
import 'package:ecommerce_app/services/exceptions/local_file_handling_exception.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _basicDetailsFormKey = GlobalKey<FormState>();
  final _describeProductFormKey = GlobalKey<FormState>();
  final _uploadProductFormKey = GlobalKey<FormState>();
  final _tagStateKey = GlobalKey<TagsState>();

  Product product = Product('');

  final TextEditingController basicDetailTitleController =
      TextEditingController();
  final TextEditingController basicDetailOriginalPriceController =
      TextEditingController();
  final TextEditingController basicDetailDiscountPriceController =
      TextEditingController();
  final TextEditingController basicDetailSellerController =
      TextEditingController();

  final TextEditingController describeProductHighlightController =
      TextEditingController();
  final TextEditingController describeProductDescriptionController =
      TextEditingController();

  Future<void> addImages(int index) async {
    //add images from services
    final productDetails = Provider.of<ProductDetail>(context, listen: false);
    if (index == null && productDetails.selectedImages.length >= 3) {
      Fluttertoast.showToast(
          msg: 'Max 3 images can be uploaded',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.blue,
          textColor: Colors.white);

      return;
    }

    String path;
    String toast;
    try {
      path = await chooseImagesFromLocalDevice(context);
      if (path == null) {
        throw LocalImagePickingUnknownReasonFailureException();
      }
    } on LocalFileHandlingException catch (e) {
      toast = e.toString();
    } catch (e) {
      toast = e.toString();
    } finally {
      if (toast != null) {
        Fluttertoast.showToast(
            msg: toast,
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.blue,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.white);
      }
    }
    if (path == null) {
      return;
    }
    if (index == null) {
      productDetails.addNewSelectedImages(
          CustomImage(path: path, imageType: ImageType.local));
    } else {
      productDetails.setSelectedImages(
          CustomImage(path: path, imageType: ImageType.local), index);
    }
  }

  Future saveProduct() async {
    if (!validateBasicDetailsForm()) {
      Fluttertoast.showToast(
          msg: 'Errors in Basic Detail',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: kPrimaryColor,
          textColor: Colors.white);
      return;
    }
    if (!validateDescribeProductForm()) {
      Fluttertoast.showToast(
          msg: 'Errors in product Description',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: kPrimaryColor,
          textColor: Colors.white);
      return;
    }
    final productDetail = Provider.of<ProductDetail>(context, listen: false);
    if(productDetail.selectedImages.length< 1){
      Fluttertoast.showToast(
          msg: 'At least 1 picture must be uploaded',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: kPrimaryColor,
          textColor: Colors.white);
      return;
    }

    if(productDetail.productType == null){
      Fluttertoast.showToast(
          msg: 'Please select the product type',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: kPrimaryColor,
          textColor: Colors.white);
      return;
    }

    if(productDetail.searchTags.length< 3){
      Fluttertoast.showToast(
          msg: 'Please select at least 3 tags',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: kPrimaryColor,
          textColor: Colors.white);
      return;
    }
  }

  bool validateBasicDetailsForm() {
    if (_basicDetailsFormKey.currentState.validate()) {
      _basicDetailsFormKey.currentState.save();
      product.title = basicDetailTitleController.text;
      product.originalPrice =
          double.tryParse(basicDetailOriginalPriceController.text);
      product.discountPrice =
          double.tryParse(basicDetailDiscountPriceController.text);
      product.seller = basicDetailSellerController.text;
      return true;
    }
    return false;
  }

  bool validateDescribeProductForm() {
    if (_describeProductFormKey.currentState.validate()) {
      _describeProductFormKey.currentState.save();
      product.highlights = describeProductHighlightController.text;
      product.description = describeProductDescriptionController.text;
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.01,
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        title: Text(
          'Add Products',
          style: TextStyle(
              fontFamily: 'Nunito',
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            )),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, top: 20, bottom: 15, right: 8.0),
              child: Text(
                'Fill Product Details',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontFamily: 'Nunito'),
              ),
            ),
            //Product details
            SizedBox(
              height: 10,
            ),
            Form(
              key: _basicDetailsFormKey,
              child: ExpansionTile(
                title: Text(
                  'Basic Product Detail',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: Colors.grey[700],
                  ),
                ),
                leading: Icon(
                  Icons.art_track_rounded,
                  color: Colors.blue[900],
                ),
                childrenPadding: EdgeInsets.symmetric(vertical: 15.0),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      controller: basicDetailTitleController,
                      keyboardType: TextInputType.text,
                      validator: (_) {
                        if (basicDetailTitleController.text.isEmpty ||
                            basicDetailTitleController.text == '') {
                          return 'This field is required';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: 'e.g., Samsung Galaxy 27',
                        labelText: 'Product Name',
                        hintStyle: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 13.0,
                            color: Colors.grey),
                        labelStyle: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 14.0,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      controller: basicDetailOriginalPriceController,
                      keyboardType: TextInputType.number,
                      validator: (_) {
                        if (basicDetailOriginalPriceController.text.isEmpty ||
                            basicDetailOriginalPriceController.text == '') {
                          return 'This field is required';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: 'e.g., 20000',
                        labelText: 'Original Price',
                        hintStyle: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 13.0,
                            color: Colors.grey),
                        labelStyle: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 15.0,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      controller: basicDetailDiscountPriceController,
                      keyboardType: TextInputType.number,
                      validator: (_) {
                        if (basicDetailDiscountPriceController.text.isEmpty ||
                            basicDetailDiscountPriceController.text == '') {
                          return 'This field is required';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: 'e.g., 10000',
                        labelText: 'Discount Price',
                        hintStyle: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 13.0,
                            color: Colors.grey),
                        labelStyle: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 15.0,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      controller: basicDetailSellerController,
                      keyboardType: TextInputType.text,
                      validator: (_) {
                        if (basicDetailSellerController.text.isEmpty ||
                            basicDetailSellerController.text == '') {
                          return 'This field is required';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: 'e.g., AbleGod Tech',
                        labelText: 'Seller Info',
                        hintStyle: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 13.0,
                            color: Colors.grey),
                        labelStyle: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 15.0,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //Descrition and highliight
            SizedBox(
              height: 30,
            ),
            Form(
              key: _describeProductFormKey,
              child: ExpansionTile(
                leading: Icon(
                  Icons.description,
                  color: Colors.blue[900],
                ),
                title: Text(
                  'Describe Product',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: Colors.grey[900],
                  ),
                ),
                childrenPadding: EdgeInsets.symmetric(vertical: 15.0),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      controller: describeProductHighlightController,
                      keyboardType: TextInputType.text,
                      validator: (_) {
                        if (describeProductHighlightController.text.isEmpty ||
                            describeProductHighlightController.text == '') {
                          return 'This field is required';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'e.g., RAM: 4GB | Front Camera: 30px',
                        labelText: 'Highlight',
                        hintStyle: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 13.0,
                            color: Colors.grey),
                        labelStyle: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 14.0,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      controller: describeProductDescriptionController,
                      keyboardType: TextInputType.multiline,
                      validator: (_) {
                        if (describeProductDescriptionController.text.isEmpty ||
                            describeProductDescriptionController.text == '') {
                          return 'This field is required';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'e.g.,This Nexus Phone is made by......',
                        labelText: 'Description',
                        hintStyle: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 13.0,
                            color: Colors.grey),
                        labelStyle: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 14.0,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // upload image
            SizedBox(
              height: 30,
            ),
            Form(
              key: _uploadProductFormKey,
              child: ExpansionTile(
                leading: Icon(
                  Icons.image_rounded,
                  color: Colors.blue[900],
                ),
                title: Text(
                  'Upload Images',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: Colors.grey[900],
                  ),
                ),
                childrenPadding: EdgeInsets.symmetric(vertical: 15.0),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: IconButton(
                        onPressed: () {
                          addImages(null);
                        },
                        icon: Icon(
                          Icons.add_a_photo_rounded,
                          color: Colors.blue[900],
                        )),
                  ),
                  Consumer<ProductDetail>(
                      builder: (context, productDetails, child) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...List.generate(
                              productDetails.selectedImages.length,
                              (index) => GestureDetector(
                                    onTap: () {
                                      addImages(index);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: SizedBox(
                                          height: 80,
                                          width: 80,
                                          child: productDetails
                                                      .selectedImages[index]
                                                      .imageType ==
                                                  ImageType.local
                                              ? Image.memory(File(productDetails
                                                      .selectedImages[index]
                                                      .path)
                                                  .readAsBytesSync())
                                              : Image.network(productDetails
                                                  .selectedImages[index].path)),
                                    ),
                                  )),
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Consumer<ProductDetail>(
                  builder: (context, productDetail, child) {
                return DropdownButton(
                  value: productDetail.productType,
                  items: ProductType.values
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(EnumToString.convertToString(e)),
                          ))
                      .toList(),
                  onChanged: (value) {
                    productDetail.productType = value;
                  },
                  hint: Container(
                    child: Text('Choose Product type'),
                  ),
                  alignment: Alignment.center,
                );
              }),
            ),
            SizedBox(
              height: 30,
            ),
            ExpansionTile(
              leading: Icon(
                Icons.check_circle_sharp,
                color: Colors.blue[900],
              ),
              title: Text(
                'Search tags',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  color: Colors.grey[900],
                ),
              ),
              childrenPadding: EdgeInsets.symmetric(vertical: 15.0),
              children: [
                Text('Your products will be searched fro using this Tags'),
                SizedBox(
                  height: 10,
                ),
                Consumer<ProductDetail>(builder: (_, productDetails, child) {
                  return Tags(
                    key: _tagStateKey,
                    horizontalScroll: true,
                    textField: TagsTextField(
                        lowerCase: true,
                        constraintSuggestion: true,
                        hintText: 'Add Search tags',
                        keyboardType: TextInputType.name,
                        width: 120,
                        onSubmitted: (String str) {
                          productDetails.addSearchTags(str.toLowerCase());
                        }),
                    itemCount: productDetails.searchTags.length,
                    itemBuilder: (index) {
                      return ItemTags(
                          index: index,
                          active: true,
                          activeColor: kPrimaryColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          alignment: MainAxisAlignment.spaceBetween,
                          removeButton: ItemTagsRemoveButton(
                              // backgroundColor: Colors.white,
                              onRemoved: () {
                            productDetails.removeSearchTags(index);
                            return true;
                          }),
                          title: productDetails.searchTags[index]);
                    },
                  );
                })
              ],
            ),
            SizedBox(
              height: 10,
            ),
            // final upload button
            DefaultUploadButton(
              text: 'Save',
              press: () {
                saveProduct();
              },
            ),
          ],
        ),
      ),
    );
  }
}

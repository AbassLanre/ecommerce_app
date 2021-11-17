import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/UI_pages/category_product_widget/product_type_enum.dart';
import 'package:ecommerce_app/services/authentification.dart';

class ProductServices{
  ProductServices._privateConstructor();

  static const String FAV_PRODUCT_KEY= 'favourite_products';

  static ProductServices _instance = ProductServices._privateConstructor();

  factory ProductServices(){
    return _instance;
  }

  FirebaseFirestore _firebaseFirestore;
  FirebaseFirestore get firestore{
    if(_firebaseFirestore == null){
      _firebaseFirestore =FirebaseFirestore.instance;
    }
    return _firebaseFirestore;
  }

  Future<Product> getProductAndId(String productsId) async {
    final docSnapshot = await firestore.collection('Products').doc(productsId).get();
    if(docSnapshot.exists){
      return Product.fromMap(docSnapshot.data(), docSnapshot.id);
    }
    return null;
  }

  //user favourite products
  Future<List> userFavouriteProductList() async{
    String uid =Authentification().auth.currentUser.uid;
    final userDocSnapshot = await firestore.collection('users').doc(uid);
    final userDocData = (await userDocSnapshot.get()).data();
    final favList = userDocData[FAV_PRODUCT_KEY];

    return favList;
  }

}
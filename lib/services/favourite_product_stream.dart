

import 'package:ecommerce_app/services/data_stream_services.dart';
import 'package:ecommerce_app/services/product_services.dart';

class FavouriteProductStream extends DataStream<List<String>>{
  @override
  void reload() {
    // Show all favourite products
    final favouriteProductsFuture =ProductServices().userFavouriteProductList();
    favouriteProductsFuture.then((favProducts) { addData(favProducts.cast<String>());} ).catchError((e){addError(e);});

  }



}

import 'package:ecommerce_app/UI_pages/category_product_widget/product_type_enum.dart';
import 'package:flutter/cupertino.dart';

enum ImageType{
  local,
  network,
}

class CustomImage{
  final ImageType imageType;
  final String path;

  CustomImage({this.imageType = ImageType.local, @required this.path});

}

class ProductDetail extends ChangeNotifier{
  List<CustomImage> _selectedImages =[];
  ProductType _productType;
  List<String> _searchTags =[];
  List<CustomImage> get selectedImages => _selectedImages;

  set initialSelectedImages(List<CustomImage> selectedImages){
    _selectedImages = selectedImages;
  }

  set selectedImages(List<CustomImage> selectedImages){
    _selectedImages = selectedImages;
    notifyListeners();
  }

  setSelectedImages(CustomImage image, int index){
    if(index< _selectedImages.length){
      _selectedImages[index] = image;
      notifyListeners();
    }
  }

  addNewSelectedImages(CustomImage images){
    _selectedImages.add(images);
    notifyListeners();
  }

  ProductType get productType => _productType;

  set initialProductType(ProductType productType){
    _productType = productType;
  }

  set productType(ProductType productType){
    _productType = productType;
    notifyListeners();
  }

  List<String> get searchTags => _searchTags;

  set initialSearchTags(List<String> searchTags){
    _searchTags =searchTags;
  }

  set searchTags(List<String> searchTags){
    _searchTags =searchTags;
    notifyListeners();
  }

  addSearchTags(String tags){
    _searchTags.add(tags);
    notifyListeners();
  }

  removeSearchTags(int index){
    if(index == null){
      _searchTags.removeLast();
    }
    else{
      _searchTags.removeAt(index);
    }
    notifyListeners();
  }

}


import 'dart:io';
import 'package:ecommerce_app/services/exceptions/local_file_handling_exception.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ecommerce_app/services/exceptions/image_picking_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<String> chooseImagesFromLocalDevice(BuildContext context, {int maxSizeInKb =1024, int minSizeInKb = 5}) async{
  //ask permission
  final PermissionStatus imagePermission = await Permission.photos.request();

  if(!imagePermission.isGranted){
    throw LocalFileHandlingStorageReadPermissionDeniedException(message: 'Photo Permission must be granted');
  }


  final imgPicker= ImagePicker();
  final imgSource= await showDialog(context: context, builder: (_)=> AlertDialog(
    title: Text('Choose Image Source', style:
    TextStyle(fontFamily:'Nunito',),),
    actions: [
      //camera
      ElevatedButton(onPressed: (){
        Navigator.pop(context,ImageSource.camera);
      }, child: Text('Camera', style: TextStyle(fontFamily: 'Nunito'),)),
      //gallery
      ElevatedButton(onPressed: (){
        Navigator.pop(context,ImageSource.gallery);

      }, child: Text('Gallery', style: TextStyle(fontFamily: 'Nunito'),))

    ],

  ));

  if (imgSource== null){
    throw LocalImagePickingInvalidImageException(message: 'No Image Source Selected');
  }

  final PickedFile imgPicked = await imgPicker.getImage(source: imgSource);

  if (imgPicked== null){
    throw LocalImagePickingInvalidImageException();
  }else{
    final fileLength = await File(imgPicked.path).length();
    if( fileLength > (maxSizeInKb * 1024) || fileLength < (minSizeInKb * 1024)){
      throw LocalImagePickingFileSizeOutOfBoundsException(message: 'Image Size must not exceed 1MB');
    }else{
      return imgPicked.path;
    }
  }


}

import 'dart:async';

abstract class DataStream<T>{
  StreamController<T> streamController;

  void init(){
    //initialize the streamController
    streamController = StreamController();
  }

  Stream get stream => streamController.stream;

  //add data
  void addData(T data){
    streamController.sink.add(data);
  }
  //add error
  void addError(dynamic e){
    streamController.sink.addError(e);
  }
  //reload
  void reload();
  //close stream
  void dispose(){
    streamController.sink.close();
  }


}
import 'package:flutter/material.dart';


class MyProductScreen extends StatefulWidget {
  const MyProductScreen({Key key}) : super(key: key);

  @override
  _MyProductScreenState createState() => _MyProductScreenState();
}

class _MyProductScreenState extends State<MyProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
      elevation: 0.01,
      centerTitle: true,
      backgroundColor: Colors.blue[900],
      title: Text('My Products', style: TextStyle(fontFamily: 'Nunito', color: Colors.white, fontWeight: FontWeight.bold),),
      leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white,)),
    ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:8.0, top: 20, bottom: 15, right: 8.0),
              child: Text('Fill Product Details', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),),

            ),
          ],
        ),
      ),
    );
  }
}

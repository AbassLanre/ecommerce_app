import 'package:ecommerce_app/UI_pages/landing_page.dart';
import 'package:ecommerce_app/models/product_details.dart';
import 'package:ecommerce_app/provider/auth_notifier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> AuthNotifier()),
        ChangeNotifierProvider(create: (_)=> ProductDetail())
      ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: LandingPage(),
    );
  }
}


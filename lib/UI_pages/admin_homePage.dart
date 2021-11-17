
import 'package:ecommerce_app/UI_pages/admin_deets/edit_product_screen.dart';
import 'package:ecommerce_app/UI_pages/admin_deets/my_product_screen.dart';
import 'package:ecommerce_app/provider/auth_notifier.dart';
import 'package:ecommerce_app/services/authentification.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AdminPage extends StatefulWidget {

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  Authentification _authentification = Authentification();


  void signOutUser(){
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context,listen:  false);

    if (authNotifier.user != null){
      _authentification.signOut(authNotifier, context);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.01,
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        title: Text('PocketZone Admin', style: TextStyle(fontFamily: 'Nunito', color: Colors.white, fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
              onPressed: (){
                signOutUser();
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            ListTile(
              title: Text('Add New Products', style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 18,
                color: Colors.black,
              ),),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>EditProductScreen()));
              },
            ),
            ListTile(
              title: Text('Manage My Products', style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 18,
                color: Colors.black,
              ),),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>MyProductScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

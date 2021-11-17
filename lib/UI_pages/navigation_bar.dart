import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommerce_app/UI_pages/account_page.dart';
import 'package:ecommerce_app/UI_pages/cart_page.dart';
import 'package:ecommerce_app/UI_pages/home_page.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatefulWidget {
  int selectedIndex;
  NavigationBar({@required this.selectedIndex});

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {

  final List<Widget> _children =[
    //3 screen Widget,
    //HomePage
    HomePage(),
    //Cart Screen
    CartPage(),
    //Account Screen
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[widget.selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: widget.selectedIndex,
        onTap: (value){
          setState(() {
            widget.selectedIndex=value;
          });
        },
        height: 50,
        buttonBackgroundColor: Colors.blue[300],
        backgroundColor: Colors.transparent,
        color: Colors.blue,
        items: [
          Icon(Icons.home, size: 20, color: Colors.white,),
          Icon(Icons.add_shopping_cart, size: 20, color: Colors.white,),
          Icon(Icons.account_circle_rounded, size: 20, color: Colors.white,),

        ],
      ),
    );
  }
}

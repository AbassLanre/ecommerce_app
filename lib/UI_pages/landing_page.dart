import 'package:ecommerce_app/UI_pages/admin_homePage.dart';
import 'package:ecommerce_app/UI_pages/home_page.dart';
import 'package:ecommerce_app/UI_pages/loginPage.dart';
import 'package:ecommerce_app/UI_pages/navigation_bar.dart';
import 'package:ecommerce_app/provider/auth_notifier.dart';
import 'package:ecommerce_app/services/authentification.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Authentification _authentification=Authentification();

  @override
  void initState() {

    super.initState();
    AuthNotifier authNotifier =
    Provider.of<AuthNotifier>(context, listen: false);
    _authentification.initializeCurrentUser(authNotifier);
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.white,
          Colors.white,
          Colors.blue,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pocket',
              style: TextStyle(
                fontSize: 60,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              '                MarketZone',
              style: TextStyle(
                fontSize: 27,
                fontFamily: 'Nunito',
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                (authNotifier.user == null)
                    ? Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => LoginPage()))
                    : (authNotifier.userDetails == null)
                        ? print('wait')
                        : (authNotifier.userDetails.role == 'admin')
                            ? Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => AdminPage()))
                            : Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => NavigationBar(selectedIndex: 0,)));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Explore',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w500,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

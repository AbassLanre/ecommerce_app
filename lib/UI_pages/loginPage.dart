import 'package:ecommerce_app/UI_pages/home_page.dart';
import 'package:ecommerce_app/UI_pages/signUp_page.dart';
import 'package:ecommerce_app/models/user.dart';
import 'package:ecommerce_app/provider/auth_notifier.dart';
import 'package:ecommerce_app/services/authentification.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

bool showPassword = true;

class _LoginPageState extends State<LoginPage> {
  Users _users = Users();
  Authentification _authentification = Authentification();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    //initialize current _users
    _authentification.initializeCurrentUser(authNotifier);
    super.initState();
  }

  toast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.blue,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    RegExp regExp =
        RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$');
    if (!regExp.hasMatch(_users.email)) {
      //toast
      toast('Enter a valid email ID');
    } else if (_users.password.length < 8) {
      toast('Password must be longer than 8');
    } else {
      //login function from authentication
      _authentification.login(_users, authNotifier, context);
    }
  }

  @override
  Widget build(BuildContext context) {

    Widget _buildLoginForm() {
      return Column(
        children: [
          // email formfield
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: TextFormField(
              validator: (value) {
                return null;
              },
              onSaved: (newValue) {
                _users.email = newValue;
              },
              cursorColor: Colors.lightBlueAccent,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.email,
                  size: 17,
                  color: Colors.lightBlueAccent,
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'Email',
                hintStyle: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 12,
                    color: Colors.lightBlueAccent,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          // password formfield
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: TextFormField(
              obscureText: showPassword,
              validator: (value) {
                return null;
              },
              onSaved: (newValue) {
                _users.password = newValue;
              },
              cursorColor: Colors.lightBlueAccent,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    icon: Icon(
                      (showPassword)
                          ? Icons.visibility_off
                          : Icons.visibility,
                      size: 17,
                      color: Colors.lightBlueAccent,
                    ),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    }),
                icon: Icon(
                  Icons.lock,
                  size: 17,
                  color: Colors.lightBlueAccent,
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'Password',
                hintStyle: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 12,
                    color: Colors.lightBlueAccent,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
              ),
              Text(
                'Forgot Password?',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomePage()));
            },
            child: GestureDetector(
              onTap: () {
                _submitForm();
              },
              child: Container(
                width: 100,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
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
                _buildLoginForm(),
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not registered yet? ',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.blue,
                        )),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => SignUpPage()));
                      },
                      child: Text('Sign Up',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

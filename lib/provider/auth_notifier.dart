

import 'package:ecommerce_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthNotifier extends ChangeNotifier{
  User _user;
  User get user => _user;

  setUser(User user){
    _user =user;
    // notifyListeners();
  }

  Users _userDetails;
  Users get userDetails => _userDetails;
  setUserDetails(Users userDetails){
    _userDetails =userDetails;
    notifyListeners();
  }




}
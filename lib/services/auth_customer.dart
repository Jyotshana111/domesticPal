import 'package:domestic_pal/models/user.dart';
import 'package:domestic_pal/services/database_customer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _authCustomer = FirebaseAuth.instance;

  //create user object on FIrebaeUser
  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid, category: 'C') : null;
  }

  //auth changes user stream
  Stream<User> get user {
    return _authCustomer.onAuthStateChanged.map(_userFromFirebase);
  }

  //sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _authCustomer.signInAnonymously();
      FirebaseUser user = result.user;

      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _authCustomer.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _authCustomer.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      await DatabaseCustomerService(uid: user.uid)
          .updateCustomerUserData('C', 'new customer', null, null);

      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _authCustomer.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

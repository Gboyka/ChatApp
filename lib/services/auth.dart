import 'package:gupshup/helper/helperfunctions.dart';
import 'package:gupshup/modules/user.dart' ;
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthMethods {

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  HelperFunction helperFunction=new HelperFunction();

  User _userFromFirebaseUser(auth.User user){
    return user!=null? User(userId:user.uid):null;
  }


  Future signInWithEmailAndPassword(String email, String password) async
  {
    try {
      auth.UserCredential result = await _auth.signInWithEmailAndPassword
        (email: email, password: password);
      auth.User firebaseUser = result.user;


      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());

    }
  }


  Future signUpWithEmailAndPassword(String email,String password)async{
    try{
      auth.UserCredential result = await _auth.createUserWithEmailAndPassword
        (email: email, password: password);
      auth.User firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    }
    catch(e){
      print(e.toString());
    }
  }

  Future resetPassword(String email)async{
    try{

      return await _auth.sendPasswordResetEmail(email: email);

    }
    catch(e)
    {
      print(e.toString());
    }
  }

  Future signMeOut()async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
    }
  }

}


import 'package:firebase_auth/firebase_auth.dart';

class AuthService
{
  final FirebaseAuth _auth= FirebaseAuth.instance;


  //register with and email and password
Future registerWithEmailAndPassword(String email,String password) async
{
  try
  {
    return await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }catch(e)
  {
    print(e.toString());
  }

}
//sign in with and email and password
  Future signWithEmailAndPassword(String email,String password) async{

    try
    {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    }catch(e)
    {
      print(e.toString());
      print('echouer');
      return null;
    }

  }
  //sign out
Future signOut() async{
    try
    {
      return await _auth.signOut();
    }catch(e)
    {
    print(e.toString());
    return null;
    }
}
//sign in annon
Future signInAnon() async{
  try
  {
    UserCredential result=await _auth.signInAnonymously();
    User? user=result.user;
    print('firebaseUser: $user');
    return user;
  }catch(e)
  {
    print(e.toString());
    return null;
  }

}

Stream<User?>  get userChange => _auth.authStateChanges();

}
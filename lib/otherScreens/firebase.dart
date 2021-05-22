import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myloginapp/widgets/loginfirebase.dart';
import 'package:myloginapp/widgets/profile.dart';

class FirebaseScreen extends StatefulWidget {
  const FirebaseScreen({Key key,this.title}) : super(key: key);
  final String title;

  @override
  _FirebaseScreenState createState() => _FirebaseScreenState();

}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class _FirebaseScreenState extends State<FirebaseScreen> {
  bool isBusy = false;
  bool isLoggedIn = false;
  String name;
  String picture;
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: isBusy
              ? CircularProgressIndicator()
              : isLoggedIn
              ? Profile(_googleSignout, name, picture)
              : LoginFirebase(_googleSignIn,_signIn,_signUp),
        ),
      )
    );
  }
  // _signInGoogle() async{
  //   final GoogleSignInAccount googleUser = await googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  //
  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //       idToken: googleAuth.idToken,
  //       accessToken: googleAuth.accessToken);
  //
  //   final User user  = (await firebaseAuth.signInWithCredential(credential)).user;
  // }
  Future<void> _googleSignIn() async {
    User currentUser;

    setState(() {
      isBusy = true;
    });

    try {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser
          .authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken,);
      final User user = (await firebaseAuth.signInWithCredential(credential))
          .user;
      assert(user.email != null);
      assert(user.displayName != null);
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      currentUser = firebaseAuth.currentUser;
      assert(user.uid == currentUser.uid);
      print(currentUser);
      print("User Name : ${currentUser.displayName}");
     setState(() {
       isBusy = false;
       isLoggedIn = true;
       name = currentUser.displayName == null ? currentUser.email : currentUser.displayName;
       picture = currentUser.photoURL == null ? '' : currentUser.photoURL ;
     });
    } catch (e) {
      print(e);
      setState(() {
        isBusy = false;
        isLoggedIn = false;
      });

    }
  }

  void _googleSignout() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
    setState(() {
      isLoggedIn = false;
      isBusy = false;
    });
  }


 Future<void> _signUp(email, password) async {
    setState(() {
      isBusy = true;
    });
    try {
      final User user = (await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user;
      assert(user != null);
      assert(await user.getIdToken() != null);
      var token = await user.getIdToken();
      print(token);
      print(user);
      setState(() {
        isBusy = false;
        isLoggedIn = true;
        name = user.displayName == null ? user.email : user.displayName;
        picture = user.photoURL == null ? '' : user.photoURL ;
      });

    } catch (e) {
      //handleError(e);
      print(e);
      setState(() {
        isBusy = false;
        isLoggedIn = false;
      });
      //return null;
    }
  }

  Future <void> _signIn(String email, String password) async {
    setState(() {
      isBusy = true;
    });
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;
      assert(user != null);
      assert(await user.getIdToken() != null);
      final User currentUser = firebaseAuth.currentUser;
      assert(user.uid == currentUser.uid);
      print (user);
      setState(() {
        isBusy = false;
        isLoggedIn = true;
        name = user.displayName == null ? user.email : user.displayName;
        picture = user.photoURL == null ? '' : user.photoURL ;
      });
    } catch (e) {
      print(e);
      setState(() {
        isBusy = false;
        isLoggedIn = false;
      });
    }
  }
}

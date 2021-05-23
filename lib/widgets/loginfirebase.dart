import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginFirebase extends StatelessWidget {
  final loginActionG;
  final loginActionE;
  final registerE;

  const LoginFirebase(this.loginActionG,this.loginActionE, this.registerE);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    UserPeople _userPeople = UserPeople();
    return SingleChildScrollView(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white,width: 2.0),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.google),
                SizedBox(width: 20,),
                Text('Google',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              ],),
          ),
          SizedBox(height: 10,),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
              ),
              onPressed: (){
                loginActionG();
              },
              child: Text(
                  'Google Login'
              )),
          SizedBox(height: 30,),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white,width: 2.0),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.envelope),
                SizedBox(width: 20,),
                Text('Email',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              ],),
          ),
          SizedBox(height: 10,),
          Divider(height: 10,),
          Text('LOGIN',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          SizedBox(height: 5,),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  onSaved: (val) => _userPeople.email = val,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'Mail',
                      icon: Icon(Icons.mail)
                  ),
                  maxLength: 100,
                  validator: (value) {
                    if (value.isEmpty) return "This field must be filled";
                    if ((!value.contains('@')) || (!value.contains('.com'))) return "The text must be a valid mail";
                    return null;
                  },
                ),
                TextFormField(
                  onSaved: (val) => _userPeople.secret = val,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      icon: Icon(Icons.lock)
                  ),
                  maxLength: 12,
                  validator: (value) {
                    if (value.isEmpty) return "This field must be filled";
                    if (value.length <= 6) return "This field must contain at least 6 characters";
                    return null;
                  },
                ),
                ElevatedButton(
                  child: Text('Login'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      loginActionE(_userPeople.email,_userPeople.secret);
                    }
                  },
                ),
              ],
            ),
          ),
          OutlinedButton(
              style: ButtonStyle(
               side: MaterialStateProperty.all(BorderSide(width: 2.5))
              ),
              onPressed:()=> registerE('matheusmrqfaino@gmail.com','123456'),
              child: Text(
                  'Register',
                style: TextStyle(color: Colors.black),
              )),
        ],
      ),
    );
  }
}

class UserPeople {
  String email;
  String secret;
  String confirmSecret;

  UserPeople({this.email,this.secret,this.confirmSecret});
}
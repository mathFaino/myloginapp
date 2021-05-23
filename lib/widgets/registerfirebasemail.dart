import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myloginapp/models/userpeople.dart';

class RegisterFirebaseMail extends StatelessWidget {
  RegisterFirebaseMail(this.register);
  final register;
  final _formKeyR = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    UserPeople _userPeople = UserPeople();
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Register'),
      ),
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
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
                    FaIcon(FontAwesomeIcons.envelope),
                    SizedBox(width: 20,),
                    Text('REGISTER',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  ],),
              ),
              SizedBox(height: 10,),
              Form(
                key: _formKeyR,
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
                    TextFormField(
                      onSaved: (val) => _userPeople.confirmSecret = val,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          labelText: 'Confirm Password',
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
                        if (_formKeyR.currentState.validate()) {
                          _formKeyR.currentState.save();
                          if(_userPeople.secret == _userPeople.confirmSecret){
                            register(_userPeople.email,_userPeople.secret);
                            Navigator.pop(context);
                          }else{
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  content: Text(
                                      "As senhas devem ser iguais! Por favor confira os dados!"),
                                  actions: <Widget>[
                                    OutlinedButton(
                                      child: Text("Fechar",style: TextStyle(color: Colors.red),),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ));
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
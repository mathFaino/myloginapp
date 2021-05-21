import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginFirebase extends StatelessWidget {
  final loginActionG;
  final loginActionE;
  final registerE;

  const LoginFirebase(this.loginActionG,this.loginActionE, this.registerE);

  @override
  Widget build(BuildContext context) {
    return Column(
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
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
            ),
            onPressed:()=> registerE('',''),
            child: Text(
                'Register'
            )),
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
            ),
            onPressed:()=> loginActionE('',''),
            child: Text(
                'Login'
            )),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:myloginapp/otherScreens/auth0.dart';
import 'package:myloginapp/otherScreens/firebase.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication Tests',
      theme: ThemeData.dark(
      ),
      home: MyHomePage(title: 'Login Testing'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(children: [Expanded(child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                  ),
                  onPressed:()=> Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FirebaseScreen(title: 'Firebase',)),
                  ),
                  child: Text(
                      'Firebase'
                  )),),],),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [Expanded(child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                    ),
                    onPressed:()=> Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Auth0Screen(title: 'Auth0',),
                        )
                    ),
                    child: Text(
                        'Auth0'
                    )),)],
              )
            ],
          ),
        ),
      )
    );
  }
}

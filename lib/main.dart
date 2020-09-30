import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quiz/quizscreen.dart';

void main() {
  runApp(App());
}

//main app class
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //backgound sistem ui
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
    ));
    //page
    //background apps
    return Scaffold(
      backgroundColor: Color(0xFF2D046E),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 90,
              ),
              Center(
                child: Image(
                  image: AssetImage('assets/first.png'),
                  width: 300,
                  height: 300,
                ),
              ),
              Text(
                'Quiz',
                style: TextStyle(
                  color: Color(0xffa20cbe),
                  fontSize: 90,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 40.0,
                ),
                child: RaisedButton(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      'PLAY',
                      style: TextStyle(
                        fontSize: 32,
                      ),
                    ),
                    color: Color(0xffffba00),
                    textColor: Colors.white,
                    onPressed: () {
                      // goto quiz screen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuizScreen()));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

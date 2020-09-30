import 'package:flutter/material.dart';
import 'package:flutter_quiz/quizscreen.dart';

class ResultScreen extends StatelessWidget {

  final int score;

  ResultScreen({this.score});

  @override
  Widget build(BuildContext context) {
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
                'Result',
                style: TextStyle(
                  color: Color(0xffa20cbe),
                  fontSize: 35,
                ),
              ),
              Text(
                '$score/10',
                style: TextStyle(
                  color: Color(0xFFFFBA00),
                  fontSize: 60,
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
                      'RESTART',
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
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(
                  horizontal: 30.0,
                ),
                child: RaisedButton(
                    padding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      'EXIT',
                      style: TextStyle(
                        fontSize: 32,
                      ),
                    ),
                    color: Color(0xFF511AA8),
                    textColor: Colors.white,
                    onPressed: () {
                      // exit screen
                      Navigator.pop(context);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

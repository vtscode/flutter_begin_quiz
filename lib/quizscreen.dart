import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quiz/QuizHelper.dart';
import 'package:flutter_quiz/ResultScreen.dart';
import 'package:http/http.dart' as http;

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

  String apiURL = "https://opentdb.com/api.php?amount=10&category=18&type=multiple";
  QuizHelper quizHelper;

  int currentQuestion = 0;
  int totalSeconds = 30;
  int elapsedSeconds = 0;

  Timer timer;

  int score = 0;

  @override
  void initState() {
    // TODO: implement initState
    // fetch question here
    fetchAllQuiz();
    //init state will initiate the variable
    super.initState();
  }

  quizHelperRender(){
    quizHelper.results[currentQuestion].incorrectAnswers.add(
        quizHelper.results[currentQuestion].correctAnswer
    );
    quizHelper.results[currentQuestion].incorrectAnswers.shuffle();
  }

  fetchAllQuiz() async{
    var response = await http.get(apiURL);
    var body = response.body;
    var json = jsonDecode(body);
    setState(() {
      quizHelper = QuizHelper.fromJson(json);
      quizHelperRender();
      initTimer();
    });
  }

  initTimer(){
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if(timer.tick == totalSeconds + 1){
        print('Time completed');
        timer.cancel();
        changeQuestion();
      }else{
        setState(() {
          elapsedSeconds = timer.tick;
        });
      }
    });
  }

  @override
  void dispose(){
    timer.cancel();
    super.dispose();
  }

  checkAnswer(answer) {
    String correctAnswer = quizHelper.results[currentQuestion].correctAnswer;
    if(correctAnswer == answer){
      score += 1;
    }else{
      print('Wrong');
    }
    changeQuestion();
  }

  changeQuestion(){
    timer.cancel();
  //  check if it is las question
    if(currentQuestion == quizHelper.results.length - 1){
      print('Quiz Completed');
      print('Score: $score');
      
      //navigate to result screen
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => ResultScreen(score: score,)
      ));
      
    }else{
      setState(() {
        currentQuestion += 1;
      });
      quizHelperRender();
      initTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    if(quizHelper != null){
      return Scaffold(
        backgroundColor: Color(0xFF2D046E),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 60.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(
                        image: AssetImage('assets/first.png'),
                        width: 70.0,
                        height: 70.0,
                      ),
                      Text(
                        "$elapsedSeconds s",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),

                // questions
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Q. ${quizHelper.results[currentQuestion].question} ?",
                    style: TextStyle(fontSize: 35, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),

                // options
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 40.0,
                  ),
                  child: Column(
                    children:
                    quizHelper.results[currentQuestion].incorrectAnswers.map((option) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0
                        ),
                        child: RaisedButton(
                          child: Text(option,style: TextStyle(
                              fontSize: 18
                          ),),
                          color: Color(0xFF511AA8),
                          colorBrightness: Brightness.dark,
                          padding: EdgeInsets.symmetric(
                            vertical: 20.0,
                          ),
                          onPressed: () {
                            checkAnswer(option);
                          },
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }else {
      return Scaffold(
        backgroundColor: Color(0xFF2D046E),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}

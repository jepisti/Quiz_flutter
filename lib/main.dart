import 'package:flutter/material.dart';
import 'question.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];

  int questionNumber = 0;

  int questionLength = quizBrain.getListLength();

  void checkIcon(bool correct, bool t) {
    if (correct == t) {
      scoreKeeper.add(
        const Icon(
          Icons.check,
          color: Colors.green,
        ),
      );
    } else {
      scoreKeeper.add(
        const Icon(
          Icons.close,
          color: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              //quizBrain.questionBank[questionNumber].questionText,
              quizBrain.getQuestionText(questionNumber),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                bool correctAnswer =
                    quizBrain.getQuestionAnswer(questionNumber);

                setState(() {
                  //print(questionLength);
                  if (questionNumber == (questionLength - 1)) {
                    checkIcon(correctAnswer, true);

                    questionNumber = 0;
                    //scoreKeeper.clear();
                  } else {
                    if (questionNumber == 0) scoreKeeper.clear();

                    questionNumber = questionNumber + 1;

                    checkIcon(correctAnswer, true);
                  }
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                bool correctAnswer =
                    quizBrain.getQuestionAnswer(questionNumber);

                setState(() {
                  if (questionNumber == (questionLength - 1)) {
                    checkIcon(correctAnswer, false);
                    questionNumber = 0;

                    //scoreKeeper.clear();
                  } else {
                    if (questionNumber == 0) scoreKeeper.clear();
                    questionNumber = questionNumber + 1;

                    checkIcon(correctAnswer, false);
                  }
                });
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'database.dart';
import 'measure.dart';
import 'quiz_brain.dart';

QuizPoll quizPoll = QuizPoll();
List<Map<String, Object>> currentChoices = quizPoll.choicesOfPoll.elementAt(0);

ResultPoll resultPoll = ResultPoll(quizPoll.getAllChoices());

Future<List<Measure>> fetchChoicesByPollFromDatabase(int id) async {
  var dbHelper = PoliticDatabase();
  Future<List<Measure>> choices = dbHelper.choicesByTitleId(id);
  return choices;
}

class MyDynamicListView extends StatefulWidget {
  @override
  _MyDynamicListViewState createState() => _MyDynamicListViewState();
}

class _MyDynamicListViewState extends State<MyDynamicListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: ListView.builder(
                itemCount: resultPoll.ideologyQuantity,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(resultPoll.message(index)),
                    tileColor: resultPoll.getColor(index),
                  );
                })),
        Expanded(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(resultPoll.totalitarianMessage(),
                            style: TextStyle( fontSize: 17),
                      ),
        )),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Inicio'),
        ),
      ],
    );
  }
}

main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          title: Text('Test político'),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizzlerResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Resultado de test político'),
        ),
        body: MyDynamicListView(),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  var dbHelper = PoliticDatabase();

  void checkAnswer(int choiceIndex) {
    setState(() {
      if (quizPoll.isFirstPoll()) {
        resultPoll.resetAnswers();
      }
      resultPoll.selectedAnswer(currentChoices[choiceIndex]);

      if (quizPoll.isFinished() == true) {
        quizPoll.reset();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QuizzlerResultPage()),
        );
      } else {
        quizPoll.nextPoll();
      }
      currentChoices =
          quizPoll.choicesOfPoll.elementAt(quizPoll.getPollIndex());
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentChoices.length == 3) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
                child: Text(
              quizPoll.getPollDescription(),
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            )),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.amber[100]),
                    child: Text(
                      currentChoices[0]['description'].toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                    onPressed: () {
                      //The user picked true.
                      checkAnswer(0);
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: TextButton(
                  style:
                      TextButton.styleFrom(backgroundColor: Colors.amber[100]),
                  child: Text(
                    currentChoices[1]['description'].toString(),
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {
                    //The user picked false.
                    checkAnswer(1);
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: TextButton(
                  style:
                      TextButton.styleFrom(backgroundColor: Colors.amber[100]),
                  child: Text(
                    currentChoices[2]['description'].toString(),
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {
                    //The user picked false.
                    checkAnswer(2);
                  },
                ),
              ),
            ),
          ]);
    } else {
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
                child: Text(
              quizPoll.getPollDescription(),
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            )),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.amber[100]),
                    child: Text(
                      currentChoices[0]['description'].toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                    onPressed: () {
                      //The user picked true.
                      checkAnswer(0);
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: TextButton(
                  style:
                      TextButton.styleFrom(backgroundColor: Colors.amber[100]),
                  child: Text(
                    currentChoices[1]['description'].toString(),
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {
                    //The user picked false.
                    checkAnswer(1);
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: TextButton(
                  style:
                      TextButton.styleFrom(backgroundColor: Colors.amber[100]),
                  child: Text(
                    currentChoices[2]['description'].toString(),
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {
                    //The user picked false.
                    checkAnswer(2);
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: TextButton(
                  style:
                      TextButton.styleFrom(backgroundColor: Colors.amber[100]),
                  child: Text(
                    currentChoices[3]['description'].toString(),
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {
                    //The user picked false.
                    checkAnswer(3);
                  },
                ),
              ),
            ),
          ]);
    }
  }
}

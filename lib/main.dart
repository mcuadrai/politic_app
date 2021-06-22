import 'package:flutter/material.dart';

import 'database.dart';
import 'quiz_poll.dart';

QuizPoll quizPoll = QuizPoll();
List<Map<String, Object>> currentChoices = quizPoll.choicesOfPoll.elementAt(0);

ResultPoll resultPoll = ResultPoll(quizPoll.getAllChoices());


main() {
  runApp(MaterialApp(
    // Start the application with the named path.
    initialRoute: '/welcome',
    routes: {
      '/welcome': (context) => WelcomePage(),
      //When we navigate to the "/ second" path, we will create the Quizzler Widget
      '/quiz': (context) => Quizzler(),
      //When we navigate to the "/ second" path, we will create the ResultPage Widget
      '/result': (context) => ResultPage(),
    },
  ));
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test '),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Este test político es para quién lo haga se de cuenta a que ideologías políticas es afin.',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Son 6 temas y por cada tema deberá responder una sola alternativa. Escoja aquella con la que se identifica más.',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/quiz');
                    },
                    child: Text('Siguiente', style: TextStyle(fontSize: 20.0))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text('Test político'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.0),
          child: QuizPage(),
        ),
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
        Navigator.pushNamed(context, '/result');
      } else {
        quizPoll.nextPoll();
      }
      currentChoices =
          quizPoll.choicesOfPoll.elementAt(quizPoll.getPollIndex());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
              child: Text(
            quizPoll.getPollDescription(),
            style: TextStyle(fontSize: 20.0),
          )),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
                child: Center(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    for (int index = 0; index < currentChoices.length; index++)
                      ListTile(
                        title: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.amber[50]),
                          child: Text(
                            currentChoices[index]['description'].toString(),
                            style: TextStyle(
                              color: Colors.black,
                              //fontSize: 19.0,
                            ),
                          ),
                          onPressed: () {
                            checkAnswer(index);
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ]);
  }
}

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Resultado de test político'),
      ),
      body: MyDynamicListView(),
    );
  }
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
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            resultPoll.totalitarianMessage(),
            style: TextStyle(fontSize: 17),
          ),
        ))
      ],
    );
  }
}

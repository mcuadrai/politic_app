import 'package:flutter/material.dart';

import 'database.dart';

class QuizPoll {
  int _pollIndex = 0;
  List<Poll> _pollBank = [];

  var choicesOfPoll = [
    [
      {
        'description':
        'Estado deberá aplicar fijación de precios para proteger al consumidor y aumentar impuestos para entregar más beneficios a los ciudadanos',
        'ideology_id': 1,
        'totalitarian_point': 10
      },
      {
        'description':
        'El Estado debe limitar la entrada de productos de otros países para favorecer a los productores nacionales',
        'ideology_id': 2,
        'totalitarian_point': 5
      },
      {
        'description':
        'El Estado no debe limitar el comercio internacional. Éste debe ser libre y los aranceles deben reducirse hasta eliminarse',
        'ideology_id': 4,
        'totalitarian_point': 0
      }
    ],
    [
      {
        'description':
        'Las cuotas obligatorias son el mejor instrumento para remediar las situaciones de discriminación histórica',
        'ideology_id': 3,
        'totalitarian_point': 10
      },
      {
        'description':
            'Las ayudas para la integración o los beneficios fiscales a los grupos menos representados son el mejor instrumento para paliar la discriminación',
        'ideology_id': 3,
        'totalitarian_point': 3
      },
      {
        'description':
            'Cualquier tipo de imposición o beneficio basado en criterios de sexo, raza o grupo social, viola el principio de igualdad ante la ley, y no debe ser impuesto por el Estado',
        'ideology_id': 4,
        'totalitarian_point': 0
      }
    ],
    [
      {
        'description':
        'Estado deberá entregar educación escolar-universitaria y salud gratuita para todos',
        'ideology_id': 1,
        'totalitarian_point': 10
      },
      {
        'description':
        'Estado deberá gestionar servicios de educación y salud gratuita para los más necesitados o para quien lo solicite',
        'ideology_id': 2,
        'totalitarian_point': 5
      },
      {
        'description':
        'Estado sólo entrega vales de educación y salud a los más desposeídos',
        'ideology_id': 3,
        'totalitarian_point': 3
      },
      {
        'description':
        'Estado sin servicio público de educación ni de salud',
        'ideology_id': 4,
        'totalitarian_point': 1
      }
    ],
    [
      {
        'description':
        'Estado debe tener parlamentarios, cargos políticos, y cargos regionales electos por sufragio universal',
        'ideology_id': 2,
        'totalitarian_point': 8
      },
      {
        'description': 'Estado debe tener parlamentarios y cargos políticos de confianza nombrados por el Presidente',
        'ideology_id': 2,
        'totalitarian_point': 5
      },
      {
        'description':
            'Estado debe tener sólo el Presidente y embajadores',
        'ideology_id': 4,
        'totalitarian_point': 1
      }
    ],
    [
      {
        'description':
        'Estado debe eliminar impuesto a la herencia, al impuesto verde, y contribuciones, etc., excepto para vigilancia y seguridad',
        'ideology_id': 4,
        'totalitarian_point': 1
      },
      {
        'description':
        'El Estado debe imponer entre un 12% y 20% de impuesto a las empresas para solventar el gasto social',
        'ideology_id': 2,
        'totalitarian_point': 5
      },
      {
        'description': 'El Estado debe imponer sobre un 20% de tasa de impuestos a las empresas',
        'ideology_id': 1,
        'totalitarian_point': 10
      },
      {
        'description':
        'Estado debe rebajar impuestos a empresas cuando usan tecnología en beneficio del medio ambiente',
        'ideology_id': 3,
        'totalitarian_point': 3
      }
    ],
    [
      {
        'description':
        'Estado exige contribuciones a sistema único de jubilación estatal',
        'ideology_id': 2,
        'totalitarian_point': 10
      },
      {
        'description':
        'Estado exige contribuciones obligatorias para el sistema de jubilación privados',
        'ideology_id': 3,
        'totalitarian_point': 5
      },
      {
        'description':
        'Las pensiones son un asunto de ahorro y planificación individual',
        'ideology_id': 4,
        'totalitarian_point': 0
      }
    ]
  ];

  QuizPoll() {
    _allPolls();
  }

  _allPolls() {
    var dbHelper = PoliticDatabase();
    _pollBank = dbHelper.polls();
  }

  int getPollQuantity() {
    return _pollBank.length;
  }

  List<List<Map<String, Object>>> getAllChoices() {
    return choicesOfPoll;
  }

  String getPollDescription() {
    return _pollBank[_pollIndex].description;
  }

  int getPollIndex() {
    return _pollIndex;
  }

  nextPoll() {
    if (_pollIndex < _pollBank.length - 1) {
      _pollIndex++;
    }
  }

  reset() {
    _pollIndex = 0;
  }

  bool isFinished() {
    if (_pollIndex >= _pollBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }
  bool isFirstPoll() {
    if (_pollIndex == 0) {
      return true;
    } else {
      return false;
    }
  }
}

class ResultPoll {
  List<int> answer = List.filled(5, 0);
  int totalPoints = 0;
  int totalitarianTotal = 0;
  int ideologyQuantity = 0;
  PoliticDatabase _dbHelper = PoliticDatabase();

  final double totalitarianPercent = 0.0;

  ResultPoll(List<List<Map<String, Object>>> allChoices) {
    _countTotal(allChoices);
    ideologyQuantity = _dbHelper.ideologies().length;

  }

  selectedAnswer(Map<String, Object> currentChoice) {
    totalPoints =
        totalPoints + int.parse(currentChoice['totalitarian_point'].toString());
    switch (currentChoice['ideology_id']) {
      case 1:
        {
          //Comunismo
          answer[0]++;
        }
        break;
      case 2:
        {
          //Socialismo
          answer[1]++;
        }
        break;
      case 3: //Socialismo light
        {
          answer[2]++;
        }
        break;
      case 4:
        {
          //Minarquismo
          answer[3]++;
        }
        break;
      case 5:
        {
          //Anarcocapitalismo
          answer[4]++;
        }
        break;
      default:
        {
          //statements;
        }
        break;
    }
  }

  _countTotal(List<List<Map<String, Object>>> allChoices) {
    allChoices.forEach((element) {
      element.forEach((element) {
        totalitarianTotal = totalitarianTotal +
            int.parse(element['totalitarian_point'].toString());
      });
    });
  }

  String message(int index) {
    String percentage =
        ((answer[index] / _dbHelper.polls().length)*100).round().toString();
    String ideologyDescription = _dbHelper.ideologies()[index].description;
    return '$percentage % ---  $ideologyDescription';
  }

  String totalitarianMessage() {
    int percentage = ((totalPoints/totalitarianTotal)*100).round();
    return '$percentage % de Totalitarismo.  $totalPoints puntos obtenidos de un total de $totalitarianTotal';
  }

  Color getColor(int index) {
      Color colore;
       switch(index) {
         case 0:  colore = Colors.red.shade900; break;
         case 1:  colore = Colors.deepOrange.shade600; break;
         case 2:  colore = Colors.deepOrange.shade100; break;
         case 3:  colore = Colors.yellow.shade100; break;
         case 4:  colore = Colors.yellow.shade600; break;
         default: colore = Colors.red; break;
       }
       return colore;
  }



  resetAnswers(){
    answer = List.filled(5, 0);
    totalPoints = 0;
  }
}

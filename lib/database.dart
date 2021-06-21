import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'measure.dart';
import 'dart:async';

class PoliticDatabase {
  static final String _databaseName = "politic.db";
  static final _databaseVersion = 1;

  // only have a single app-wide reference to the database
  static Database? _database;

  Future<Database> get database async {
    WidgetsFlutterBinding.ensureInitialized();
    return _database ??= await _initDatabase();
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    print('la ruta es $path');
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate) ;
  }

  // Future close() async {
  //   await database.close();
  // }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute(
       "CREATE TABLE measures(id INTEGER PRIMARY KEY, description TEXT, title_id INTEGER, ideology_id INTEGER, totalitarian_point INTEGER )"
        );
    print('tabla creada');
    await db.execute(
        ''' INSERT INTO measures (id, description, title_id, ideology_id, totalitarian_point) VALUES (1, 'Estado deberá aplicar fijación de precios para proteger al consumidor y aumentar impuestos para entregar más beneficios a los ciudadanos', 1, 1, 10);INSERT INTO measures (id, description, title_id, ideology_id, totalitarian_point) VALUES (1, 'Estado deberá aplicar fijación de precios para proteger al consumidor y aumentar impuestos para entregar más beneficios a los ciudadanos', 1, 1, 10);INSERT INTO measures (id, description, title_id, ideology_id, totalitarian_point) VALUES (2, 'El Estado debe limitar la entrada de productos de otros países para favorecer a los productores nacionales.', 1, 2, 5);
  INSERT INTO measures (id, description, title_id, ideology_id, totalitarian_point) VALUES (3, 'El Estado no debe limitar el comercio internacional. Éste debe ser libre y los aranceles deben reducirse hasta eliminarse.', 1, 4, 0);
  INSERT INTO measures (id, description, title_id, ideology_id, totalitarian_point) VALUES (4, 'Las cuotas obligatorias son el mejor instrumento para remediar las situaciones de discriminación histórica.', 2, 3, 10);
  INSERT INTO measures (id, description, title_id, ideology_id, totalitarian_point) VALUES (5, 'Las ayudas para la integración o los beneficios fiscales a los grupos menos representados son el mejor instrumento para paliar la discriminación.', 2, 3, 3);
  INSERT INTO measures (id, description, title_id, ideology_id, totalitarian_point) VALUES (6, 'Cualquier tipo de imposición o beneficio basado en criterios de sexo, raza o grupo social, viola el principio de igualdad ante la ley, y no debe ser impuesto por el Estado.', 2, 4, 0);
  INSERT INTO measures (id, description, title_id, ideology_id, totalitarian_point) VALUES (7, 'Estado garantiza derechos de educación, salud. Gratuito  para todos.', 3, 1, 10);
  INSERT INTO measures (id, description, title_id, ideology_id, totalitarian_point) VALUES (8, 'Estado deberá gestionar instituciones que dan servicios sociales de educación y salud', 3, 2, 5);
  INSERT INTO measures (id, description, title_id, ideology_id, totalitarian_point) VALUES (9, 'Estado sólo entrega vales de educación y salud a los más desposeídos', 3, 3, 3);
  INSERT INTO measures (id, description, title_id, ideology_id, totalitarian_point) VALUES (10,'Estado entrega sólo servicios de seguridad y vigilancia. Sin derechos sociales', 3, 4, 1);

  INSERT INTO measures (id, description, title_id, ideology_id, totalitarian_point) VALUES (11, 'Estado debe tener la mayor cantidad de cargos políticos y parlamentarios', 4, 2, 8);
  INSERT INTO measures (id, description, title_id, ideology_id, totalitarian_point) VALUES (12, 'Estado debe tener pocos parlamentarios y políticos ', 4, 2, 5);
  INSERT INTO measures (id, description, title_id, ideology_id, totalitarian_point) VALUES (13, 'Estado debe tener sólo Presidente y embajadores. Como en el gobierno de Pinochet', 4, 4, 1);

  INSERT INTO measures (id, description, title_id, ideology_id, totalitarian_point) VALUES (14, 'Estado debe eliminar impuesto a la herencia, al impuesto verde, y contribuciones, etc., excepto para vigilancia y seguridad', 5, 4, 1);
  INSERT INTO measures (id, description, title_id, ideology_id, totalitarian_point) VALUES (15, 'Es necesario los impuestos para solventar las políticas públicas (entre 10% y 20% de impuesto a empresas)', 5, 2, 5);
  INSERT INTO measures (id, description, title_id, ideology_id, totalitarian_point) VALUES (16, 'Los super-ricos deben pagar más impuestos porque está mal repartida la torta ', 5, 1, 10);
  INSERT INTO measures (id, description, title_id, ideology_id, totalitarian_point) VALUES (17, 'Estado debe rebajar impuestos a empresas cuando usan tecnología en beneficio del crecimiento o del medio ambiente', 5, 3, 3);
  INSERT INTO measures (id, description, title_id, ideology_id, totalitarian_point) VALUES (18, 'Estado exige contribuciones a sistema único de jubilación estatal', 6, 2, 10);
  INSERT INTO measures (id, description, title_id, ideology_id, totalitarian_point) VALUES (19, 'Estado exige contribuciones obligatorias para el sistema de AFP', 6, 3, 5);
  INSERT INTO measures (id, description, title_id, ideology_id, totalitarian_point) VALUES (20, 'Las pensiones son un asunto de ahorro y planificación individual. El Estado no debe exigir contribuciones obligatorias a un sistema público ni privado', 6, 4, 0);      
        '''
    );
    print('insert creado total.');
  }




// Define a function that inserts dogs into the database
  Future<void> insertMeasure(Measure measure) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'measures',
      measure.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

// A method that retrieves all the dogs from the measure table.
  Future<List<Measure>> measures() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('measures');

    // Convert the List<Map<String, dynamic> into a List<Measure>.
    return List.generate(maps.length, (i) {
      return Measure(
          id: maps[i]['id'],
          description: maps[i]['description'],
          ideologyId: maps[i]['ideology_id'],
          titleId: maps[i]['title_id'],
          totalitarianPoint: maps[i]['totalitarian_point']);
    });
  }

  // A method that retrieves all the dogs from the measure table.
  Future<List<Measure>> choicesByTitleId(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('measures', where: 'title_id = ?',
              whereArgs: [id]);

    // Convert the List<Map<String, dynamic> into a List<Measure>.
    return List.generate(maps.length, (i) {
      return Measure(
          id: maps[i]['id'],
          description: maps[i]['description'],
          ideologyId: maps[i]['ideology_id'],
          titleId: maps[i]['title_id'],
          totalitarianPoint: maps[i]['totalitarian_point']);
    });
  }

  Future<List<Map<String, dynamic>>> choicesMapByTitleId(int id) async {
    final db = await database;
    return await db.query('measures', where: 'title_id = ?', whereArgs: [id]);
  }

  Future<List<Poll>> allPolls() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('titles');

    // Convert the List<Map<String, dynamic> into a List<Measure>.
    return List.generate(maps.length, (i) {
      return Poll(
          id: maps[i]['id'],
          description: maps[i]['description']);
    });
  }

  List<Poll> polls() {
    List<Poll> list = [];
    list.add(Poll(id:1, description:'Globalización'));
    list.add(Poll(id:2, description:'Discriminación'));
    list.add(Poll(id:3, description:'Servicios sociales'));
    list.add(Poll(id:4, description:'Poder político'));
    list.add(Poll(id:5, description:'Impuestos'));
    list.add(Poll(id:6, description:'Jubilación'));

    return list;
  }

  List<Ideology> ideologies() {
    List<Ideology> list = [];
    list.add(Ideology(id:1, description:'Comunismo'));
    list.add(Ideology(id:2, description:'Socialismo'));
    list.add(Ideology(id:3, description:'Socialismo light'));
    list.add(Ideology(id:4, description:'Minarquismo'));
    list.add(Ideology(id:5, description:'Anarcocapitalismo'));

    return list;
  }


}

class Ideology {
  int id;
  String description;

  Ideology({required this.id, required this.description});

  @override
  String toString() {
    return 'Ideology{id: $id, description: $description}';
  }
}


class Poll {
  int id;
  String description;

  Poll({required this.id, required this.description});

  @override
  String toString() {
    return 'Poll{id: $id, description: $description}';
  }

}






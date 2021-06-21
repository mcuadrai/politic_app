

class PoliticDatabase {

  List<Poll> polls() {
    List<Poll> list = [];
    list.add(Poll(id:1, description:'Mercado'));
    list.add(Poll(id:2, description:'Influencia por igualdad de género'));
    list.add(Poll(id:3, description:'Educación y Salud'));
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






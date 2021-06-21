class Measure {
  final int id;
  final String description;
  final int titleId;
  final int ideologyId;
  final int totalitarianPoint;

  Measure(
      {required this.id,
      required this.description,
      required this.titleId,
      required this.ideologyId,
      required this.totalitarianPoint});

  // Converting into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'title_id': titleId,
      'ideology_id': ideologyId,
      'totalitarian_point': totalitarianPoint,
    };
  }

  // Implement toString to make it easier to see information
  @override
  String toString() {
    return 'Measure{id: $id, description: $description, titleId: $titleId, ideologyId: $ideologyId, totalitarianPoint: $totalitarianPoint}';
  }
}

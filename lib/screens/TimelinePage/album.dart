class Album {
  int id;
  String name;
  String count_people;
 // String find;
  String cost;
  String description;
  String execute_period;

  Album({this.id, this.name, this.count_people,  this.cost, this.description, this.execute_period});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'] as int,
      name: json['name'] as String,
      count_people: json['count_people'] as String,
     // find: json['find'] as String,
      cost: json['cost'] as String,
      description: json['description'] as String,
      execute_period: json['execute_period'] as String,
    );
  }
}

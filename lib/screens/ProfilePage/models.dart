class UserData {
  String email, first_name, last_name, phone, id;

  var tasks = [];
  UserData({this.email, this.id, this.first_name, this.last_name, this.tasks, this.phone});

  factory UserData.fromJson(Map<String, dynamic> parsedJson) {
    return UserData(
        id: parsedJson['id'],
        email: parsedJson['email'],
        first_name: parsedJson['first_name'],
        last_name: parsedJson['last_name'],
        tasks: parsedJson['tasks'].toString().split(','),
        phone: parsedJson['phone']);
  }
}

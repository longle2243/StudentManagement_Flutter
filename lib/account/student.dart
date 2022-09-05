class Student {
 // final int id;
  final String name,email,gender,teams;

  const Student({required this.name,required this.email,required this.gender,required this.teams,});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      //id: json['id'],
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      teams: json['team'],
    );
  }
}
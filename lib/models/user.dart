class User {
  final int? id;
  final String email;
  final String password;
  final String displayName;
  final int totalScore;

  User({
    this.id,
    required this.email,
    required this.password,
    required this.displayName,
    this.totalScore = 0,
  });

  // Converter de Map (ex: vindo da BD) para User
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      password: map['password'],
      displayName: map['display_name'],
      totalScore: map['total_score'],
    );
  }

  // Converter de User para Map (para guardar na BD)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'display_name': displayName,
      'total_score': totalScore,
    };
  }
}

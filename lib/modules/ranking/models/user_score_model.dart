class UserScore {
  final String displayName;
  final String email;
  final int score;

  UserScore({
    required this.displayName,
    required this.email,
    required this.score,
  });

  factory UserScore.fromMap(Map<String, dynamic> m) {
    return UserScore(
      displayName: m['display_name'] as String,
      email: m['email'] as String,
      score: m['score'] as int,
    );
  }
}

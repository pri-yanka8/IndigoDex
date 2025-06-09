class PokemonUser {
  final String email;
  final String username;
  final String starter;
  final String starterImage;

  PokemonUser({
    required this.email,
    required this.username,
    required this.starter,
    required this.starterImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'starter': starter,
      'starterImage': starterImage,
    };
  }

  factory PokemonUser.fromMap(Map<String, dynamic> map) {
    return PokemonUser(
      email: map['email'],
      username: map['username'],
      starter: map['starter'],
      starterImage: map['starterImage'],
    );
  }
}

class MarvelCharacter {
  final String name;
  final String realName;
  final String team;
  final String imageUrl;

  MarvelCharacter({
    required this.name,
    required this.realName,
    required this.team,
    required this.imageUrl,
  });

  factory MarvelCharacter.fromJson(Map<String, dynamic> json) {
    return MarvelCharacter(
      name: json['name'],
      realName: json['realname'],
      team: json['team'],
      imageUrl: json['imageurl'],
    );
  }
}

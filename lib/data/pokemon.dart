class Pokemon {
  final String name;
  final String id;
  final String image;
  final String description;
  final String type1;
  final String? type2;
  final double weight;
  final double height;
  final String ability;
  final int genderRate;
  final int? evolvelLvl;

  const Pokemon({
    required this.evolvelLvl,
    required this.type2,
    required this.image,
    required this.id,
    required this.weight,
    required this.height,
    required this.ability,
    required this.genderRate,
    required this.name,
    required this.description,
    required this.type1,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
        evolvelLvl: json['evolveLvl'] as int?,        
        id: json['id'].toString(),
        weight: (json['weight'] as int).toDouble() / 10,
        height: (json['height'] as int).toDouble() / 10,
        ability: (json['abilities'] as List).isNotEmpty
            ? json['abilities'][0]['ability']['name'] as String
            : 'Unknown',
        genderRate: json['genderRate'] as int,
        name: json['name'] as String,
        description: json['description'] as String,
        type1: json['types'][0]['type']['name'] as String,
        type2: (json['types'] as List).length > 1 ? json['types'][1]['type']['name']  as String : null,
        image: (json['sprites']['other']['dream_world']['front_default'] ??
            json['sprites']['front_default']));
  }
}

const kTypeIcons = [
  'assets\\bug.svg',
  'assets\\dark.svg',
  'assets\\dragon.svg',
  'assets\\electric.svg',
  'assets\\fairy.svg',
  'assets\\fighting.svg',
  'assets\\fire.svg',
  'assets\\flying.svg',
  'assets\\ghost.svg',
  'assets\\grass.svg',
  'assets\\ground.svg',
  'assets\\ice.svg',
  'assets\\normal.svg',
  'assets\\poison.svg',
  'assets\\psychic.svg',
  'assets\\rock.svg',
  'assets\\steel.svg',
  'assets\\water.svg',
];

String capitalizeFirstLetter(String word) {
  if (word.isEmpty) {
    return word;
  }
  return word[0].toUpperCase() + word.substring(1);
}

const Map<String, Map<String, dynamic>> pokemonTypeColors = {
  "fire": {
    "color1": 0xFFFF9800,
    "color2": 0xFFFFEB3B,
  },
  "water": {
    "color1": 0xFF2196F3,
    "color2": 0xFF81D4FA,
  },
  "grass": {
    "color1": 0xFF4CAF50,
    "color2": 0xFF8BC34A,
  },
  "electric": {
    "color1": 0xFFFFEB3B,
    "color2": 0xFFFFC107,
  },
  "ice": {
    "color1": 0xFF00BCD4,
    "color2": 0xFF81D4FA,
  },
  "fighting": {
    "color1": 0xFFD32F2F,
    "color2": 0xFFEF9A9A,
  },
  "poison": {
    "color1": 0xFF9C27B0,
    "color2": 0xFFCE93D8,
  },
  "ground": {
    "color1": 0xFF795548,
    "color2": 0xD2B48C,
  },
  "flying": {
    "color1": 0xFF64B5F6,
    "color2": 0xFFBBDEFB,
  },
  "psychic": {
    "color1": 0xFFE91E63,
    "color2": 0xFFF48FB1,
  },
  "bug": {
    "color1": 0xFF8BC34A,
    "color2": 0xFFCDDC39,
  },
  "rock": {
    "color1": 0xFF795548,
    "color2": 0xA1887F,
  },
  "ghost": {
    "color1": 0xFF673AB7,
    "color2": 0xFF9575CD,
  },
  "dragon": {
    "color1": 0xFF3F51B5,
    "color2": 0xFF7986CB,
  },
  "steel": {
    "color1": 0xFF607D8B,
    "color2": 0xFF90A4AE,
  },
  "dark": {
    "color1": 0xFF212121,
    "color2": 0xFF424242,
  },
  "fairy": {
    "color1": 0xFFF06292,
    "color2": 0xFFF8BBD0,
  },
  "normal": {
    "color1": 0xFF9E9E9E,
    "color2": 0xFFE0E0E0,
  },
};
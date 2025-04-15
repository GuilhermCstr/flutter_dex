import 'package:flutter/material.dart';
import 'package:flutter_dex/data/poke_api.dart';
import 'package:flutter_dex/data/pokemon.dart';
import 'package:flutter_dex/utils.dart';
import 'package:flutter_dex/widgets/poke_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GridTilePokemon extends StatelessWidget {
  final String id;
  const GridTilePokemon({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    Future<Pokemon> pokemonFuture = PokeApi().fetchPokemon(id);    

    return FutureBuilder<Pokemon>(
      future: pokemonFuture,
      builder: (context, snapshot) {
        final double size = MediaQuery.of(context).size.width / 2;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: Color.fromRGBO(0, 0, 0, 0.7)),
          );
        } else if (snapshot.hasError) {
          return GridTile(
            child: Center(
              child: Text('Erro ao carregar: ${snapshot.error}'),
            ),
          );
        } else if (snapshot.hasData) {
          final Pokemon pokemon = snapshot.data!;
          final String type1 = pokemon.type1;

          return GridTile(
              child: Container(
            decoration: BoxDecoration(
              color: Color(pokemonTypeColors[type1]?['color1'] as int).withAlpha(100),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    height: size * .8,
                    width: size * .8,
                    child: Opacity(
                      opacity: 0.4,
                      child: SvgPicture.asset(
                        kTypeIcons.firstWhere(
                          (element) => element.contains(type1),
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      PokeImage(
                        pokeImage: pokemon.image,
                        width: size * .6,
                        height: size * .6,
                      ),
                      Column(
                        children: [
                          Text(
                            capitalizeFirstLetter(
                              pokemon.name,
                            ),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text('#${pokemon.id}')
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));
        } else {
          return const GridTile(
            child: Center(
              child: Text('Nenhum Pokémon encontrado.'),
            ),
          );
        }
      },
    );
  }
}

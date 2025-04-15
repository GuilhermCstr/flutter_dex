import 'package:flutter/material.dart';
import 'package:flutter_dex/data/poke_api.dart';
import 'package:flutter_dex/data/pokemon.dart';
import 'package:flutter_dex/navigation_provider.dart';
import 'package:flutter_dex/utils.dart';
import 'package:flutter_dex/widgets/gender_calculator.dart';
import 'package:flutter_dex/widgets/poke_image.dart';
import 'package:flutter_dex/widgets/semi_circle.dart';
import 'package:flutter_dex/widgets/type_chart.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Pokecard extends StatefulWidget {
  final String? id;

  const Pokecard({
    super.key,
    this.id,
  });

  @override
  State<Pokecard> createState() => _PokecardState();
}

class _PokecardState extends State<Pokecard> {
  late Future<Pokemon> pokemon;

  @override
  void initState() {
    super.initState();
    _fetchPokemon(widget.id ?? '1');
  }

  @override
  void didUpdateWidget(covariant Pokecard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.id != oldWidget.id) {
      _fetchPokemon(widget.id ?? '1');
    }
  }

  void _fetchPokemon(String pokemonId) {
    pokemon = PokeApi().fetchPokemon(pokemonId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Pokemon>(
        key: ValueKey<String?>(widget.id),
        future: pokemon,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          Widget child;
          if (snapshot.hasData) {
            final Pokemon currentPokemon = snapshot.data!;
            final String currentPokemonId = currentPokemon.id;
            final String type1 = currentPokemon.type1;
            final String? type2 = currentPokemon.type2;

            child = SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: -100,
                    child: SemiCircle(
                        color1: pokemonTypeColors[type1]?['color1'],
                        color2: pokemonTypeColors[type1]?['color2']),
                  ),
                  SafeArea(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Opacity(
                        opacity: 0.5,
                        child: SvgPicture.asset(
                          kTypeIcons.firstWhere(
                            (element) => element.contains(type1),
                          ),
                          fit: BoxFit.fill,
                          height: 220,
                          width: 220,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SafeArea(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () => {
                                      Provider.of<NavigationProvider>(context, listen: false)
                                          .goToPage(0)
                                    },
                                    child: Icon(
                                      Icons.chevron_left,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => {PokeApi().fetchPokemon('148')},
                                    child: SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: SvgPicture.asset(
                                        'assets/pokeball_colorized.svg',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () => {
                                      if (int.parse(currentPokemonId) > 1)
                                        {
                                          setState(() {
                                            pokemon = PokeApi().fetchPokemon(
                                                '${(int.parse(currentPokemonId)) - 1}');
                                          })
                                        }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: int.parse(currentPokemonId) <= 1
                                            ? Colors.grey
                                            : Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(alpha: 0.4),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: Offset(2, 3),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Icon(
                                          Icons.chevron_left,
                                          size: 26,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 280,
                                    height: 280,
                                    child: Center(
                                        child: PokeImage(
                                      pokeImage: currentPokemon
                                          .image, /*
                                      height: MediaQuery.of(context).size.width / 2,
                                      width: MediaQuery.of(context).size.width / 2,*/
                                    )),
                                  ),
                                  InkWell(
                                    onTap: () => {
                                      if (int.parse(currentPokemonId) <= 1025)
                                        {
                                          setState(() {
                                            pokemon = PokeApi().fetchPokemon(
                                                '${(int.parse(currentPokemonId)) + 1}');
                                          })
                                        }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(alpha: 0.4),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: Offset(2, 3),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Icon(
                                          Icons.chevron_right,
                                          size: 26,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        capitalizeFirstLetter((currentPokemon.name)),
                                        style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        '#${snapshot.data?.id}',
                                        style: TextStyle(),
                                      )
                                    ],
                                  ),
                                  //EvolveCard(),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  TypeChart(
                                    color: pokemonTypeColors[type1]?['color1'],
                                    type: type1,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  type2 != null
                                      ? TypeChart(
                                          color: pokemonTypeColors[type2]?['color2'],
                                          type: snapshot.data?.type2 != null
                                              ? snapshot.data?.type2 ?? ''
                                              : '')
                                      : SizedBox.shrink()
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                (currentPokemon.description).replaceAll('\n', ' '),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Divider(),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/Weight.svg',
                                            height: 16,
                                            width: 16,
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(top: 2, left: 4),
                                              child: Text('WEIGHT',
                                                  style: TextStyle(
                                                      fontSize: 14, fontWeight: FontWeight.w400))),
                                        ],
                                      ),
                                      Text(
                                        '${currentPokemon.weight} kg',
                                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/Height.svg',
                                            height: 16,
                                            width: 16,
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(top: 2, left: 4),
                                              child: Text('HEIGHT',
                                                  style: TextStyle(
                                                      fontSize: 14, fontWeight: FontWeight.w400))),
                                        ],
                                      ),
                                      Text(
                                        '${currentPokemon.height} m',
                                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/Ability.svg',
                                            height: 16,
                                            width: 16,
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(top: 2, left: 4),
                                              child: Text('ABILITY',
                                                  style: TextStyle(
                                                      fontSize: 14, fontWeight: FontWeight.w400))),
                                        ],
                                      ),
                                      Text(
                                        capitalizeFirstLetter(currentPokemon.ability),
                                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GenderCalculator(genderRate: currentPokemon.genderRate),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 100),
                    ],
                  ),
                ],
              ),
            );
          } else {
            child = Center(child: const CircularProgressIndicator());
          }

          return AnimatedSwitcher(
            duration: Duration(seconds: 1),
            child: child,
          );
        });
  }
}

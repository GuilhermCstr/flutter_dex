import 'package:flutter/material.dart';
import 'package:flutter_dex/data/poke_api.dart';
import 'package:flutter_dex/navigation_provider.dart';
import 'package:flutter_dex/widgets/grid_tile_pokemon.dart';
import 'package:flutter_dex/widgets/text_box_widget.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  Future<List<String>>? _filterFuture;
  
  @override
  void initState() {
    super.initState();
    _filterPokemonList('');
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _filterPokemonList(String filter) {
    setState(() {
      _filterFuture = PokeApi().fetchFilterPokemon(filter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(padding: EdgeInsets.only(left: 4), child: const Text('Pokedex')),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: TextBoxWidget(
            onFilterChanged: _filterPokemonList,
          ),
        ),
      ),
      body: FutureBuilder<List<String>>(
        future: _filterFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao filtrar: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final List<String> filteredNames = snapshot.data!;
            final int filterLength = filteredNames.length;

            return GridView.builder(
              controller: _scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14.0,
                mainAxisSpacing: 14.0,
                childAspectRatio: 0.75,
              ),
              itemCount: filterLength,
              padding: const EdgeInsets.all(20),
              itemBuilder: (BuildContext context, int index) {
                final pokemonName = filteredNames[index];
                return InkWell(
                  onTap: () => {
                    Provider.of<NavigationProvider>(context, listen: false)
                        .goToPage(1, pokemonId: pokemonName)
                  },
                  child: GridTilePokemon(id: pokemonName),
                );
              },
            );
          } else {
            return const Center(child: Text('Nenhum Pokémon encontrado com esse filtro.'));
          }
        },
      ),
    );
  }
}

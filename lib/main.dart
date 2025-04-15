import 'package:flutter/material.dart';
import 'package:flutter_dex/navigation_provider.dart';
import 'package:flutter_dex/screens/community.dart';
import 'package:flutter_dex/screens/home.dart';
import 'package:flutter_dex/screens/options.dart';
import 'package:flutter_dex/screens/pokecard.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
      child: const FlutterDex(),
    ),
  );
}

class FlutterDex extends StatelessWidget {
  const FlutterDex({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      home: Scaffold(
        body: PageView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: navigationProvider.pageController,
          children: [
            const Home(),
            Pokecard(id: navigationProvider.selectedPokemonId),
            const Community(),
            const Options(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: navigationProvider.currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/home.svg',
                    height: 25,
                    width: 25,
                    colorFilter: navigationProvider.currentIndex == 0
                        ? (ColorFilter.mode(Colors.blue, BlendMode.srcIn))
                        : ColorFilter.mode(Color.fromRGBO(0, 0, 0, 0.7), BlendMode.srcIn)),
                label: ''),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/pokeball_black.svg',
                    height: 25,
                    width: 25,
                    colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, 0.7), BlendMode.srcIn)),
                activeIcon: SvgPicture.asset('assets/pokeball_active.svg'),
                label: ''),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/community.svg',
                    height: 25,
                    width: 25,
                    colorFilter: navigationProvider.currentIndex == 2
                        ? (ColorFilter.mode(Colors.blue, BlendMode.srcIn))
                        : ColorFilter.mode(Color.fromRGBO(0, 0, 0, 0.7), BlendMode.srcIn)),
                label: ''),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/frames.svg',
                    height: 25,
                    width: 25,
                    colorFilter: navigationProvider.currentIndex == 3
                        ? (ColorFilter.mode(Colors.blue, BlendMode.srcIn))
                        : ColorFilter.mode(Color.fromRGBO(0, 0, 0, 0.7), BlendMode.srcIn)),
                label: ''),
          ],
          onTap: (int index) {
            Provider.of<NavigationProvider>(context, listen: false).goToPage(index);
          },
        ),
      ),
    );
  }
}

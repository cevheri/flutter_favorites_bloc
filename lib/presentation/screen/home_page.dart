import 'package:flutter/material.dart';

import 'favorite_generator_page.dart';
import 'favorite_history_page.dart';


/// The home page for the app <br>
///
/// This widget is the root of the app. <br>
/// It is stateful, meaning that it has a State object (defined below) <br>
/// that contains fields that affect how it looks. <br>
/// selectedIndex is used to keep track of the current page. <br>
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = const FavoriteGeneratorPage();
        break;
      case 1:
        page = const FavoriteHistoryPage();
        break;
      default:
        throw UnimplementedError('No page for index $selectedIndex');
    }

    // The container for the current page,
    // with its background color and
    // subtle switching animation
    var mainArea = ColoredBox(
        color: colorScheme.surfaceVariant,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: page,
        ));

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 450) {
            return _mobileNavigation(mainArea);
          } else {
            return _webNavigation(constraints, context, page);
          }
        },
      ),
    );
  }

  // Web or desktop navigation with a navigation rail
  Row _webNavigation(
      BoxConstraints constraints, BuildContext context, Widget page) {
    return Row(
      children: [
        SafeArea(
          child: NavigationRail(
            key: const Key('navRail'),
            selectedIndex: selectedIndex,
            extended: constraints.maxWidth > 600,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.favorite),
                label: Text('Favorites'),
              ),
            ],
            onDestinationSelected: (value) => {
              setState(() {
                selectedIndex = value;
              })
            },
          ),
        ),
        Expanded(
          child: Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: page,
          ),
        ),
      ],
    );
  }

  // Mobile navigation with a bottom navigation bar
  Column _mobileNavigation(ColoredBox mainArea) {
    return Column(
      children: [
        Expanded(
          child: mainArea,
        ),
        SafeArea(
          child: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
            ],
            currentIndex: selectedIndex,
            onTap: (value) => {
              setState(() {
                selectedIndex = value;
              })
            },
          ),
        ),
      ],
    );
  }
}

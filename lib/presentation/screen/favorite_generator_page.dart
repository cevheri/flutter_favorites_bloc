import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_favorites_bloc/presentation/widget/big_card_widget.dart';

import '../bloc/favorite/favorite.dart';
import '../widget/history_list_widget.dart';

class FavoriteGeneratorPage extends StatelessWidget {
  const FavoriteGeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.watch<FavoriteBloc>().state;
    Word? current;
    if (state is NextRandomPairState) {
      current = state.current;
      debugPrint("${"FavoriteGenerator.NextRandomPairState ".padRight(50, ".")} ${current.pair}");
    }
    if (state is ToggleFavoriteState) {
      current = state.current;
      debugPrint("${"FavoriteGenerator.ToggleFavoriteState ".padRight(50, ".")} ${current.pair}");
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(flex: 3, child: HistoryListWidget()),
          const SizedBox(height: 10.0),
          const BigCard(),
          const SizedBox(height: 10.0),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                key: const Key('favoriteButton'),
                onPressed: () {
                  current != null ? context.read<FavoriteBloc>().add(ToggleFavoriteEvent(current.pair)) : debugPrint("pair is null");
                },
                icon: Icon(current == null || !current.isFavorite ? Icons.favorite_border : Icons.favorite),
                label: const Text('Favorite'),
              ),
              const SizedBox(width: 10.0),
              ElevatedButton(
                key: const Key('nextButton'),
                onPressed: () {
                  context.read<FavoriteBloc>().add(NextRandomPairEvent());
                },
                child: const Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

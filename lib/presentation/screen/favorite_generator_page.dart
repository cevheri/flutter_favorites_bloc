import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_favorites_bloc/presentation/widget/big_card_widget.dart';

import '../bloc/favorite/favorite.dart';
import '../widget/history_list_widget.dart';

class FavoriteGeneratorPage extends StatelessWidget {
  const FavoriteGeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    /// AnimatedList needs a GlobalKey to animate the list items
    context.watch<FavoriteBloc>().state;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(flex: 3, child: HistoryListWidget()),
          const SizedBox(height: 10.0),
          const BigCard(),
          const SizedBox(height: 10.0),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<FavoriteBloc, FavoriteState>(builder: (context, state) {
                Word? current = getCurrent(state);
                return ElevatedButton.icon(
                  key: const Key('favoriteButton'),
                  onPressed: () {
                    current != null ? context.read<FavoriteBloc>().add(ToggleFavoriteEvent(current.pair)) : debugPrint("pair is null");
                  },
                  icon: Icon(current == null || !current.isFavorite ? Icons.favorite_border : Icons.favorite),
                  label: const Text('Favorite'),
                );
              }),
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
          const Spacer(flex: 2),
        ],
      ),
    );
  }

  Word? getCurrent(FavoriteState state) {
    Word? current;
    if (state is WordListLoadedState) {
      current = state.current;
      debugPrint("${"FavoriteGenerator.NextRandomPairState ".padRight(50, ".")} ${current.pair}");
    }
    return current;
  }
}

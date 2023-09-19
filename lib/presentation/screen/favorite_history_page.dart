import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_favorites_bloc/presentation/bloc/favorite/favorite.dart';

/// The page that displays the history of the all generated pairs. <br>
/// It is a stateless widget, meaning that it has no State object. <br>
/// It also like and dislike options for each pair. <br>
class FavoriteHistoryPage extends StatelessWidget {
  const FavoriteHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(builder: (context, state) {
      if (state is WordListLoadedState) {
        return ListView.builder(
          itemCount: state.wordList.length,
          itemBuilder: (context, index) {
            var current = state.wordList.elementAt(index);
            return ListTile(
              leading: const Icon(Icons.history),
              title: Text(current.pair.asPascalCase),
              trailing: IconButton(
                icon: current.isFavorite ? const Icon(Icons.favorite, size: 20) : const Icon(Icons.favorite_border, size: 17),
                onPressed: () {
                  context.read<FavoriteBloc>().add(ToggleFavoriteEvent(current.pair));
                },
              ),
            );
          },
        );
      }
      return const Center(child: Text('No history yet'));
    });
  }
}

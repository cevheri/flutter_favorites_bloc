import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_favorites_bloc/presentation/bloc/favorite/favorite.dart';

/// The [HistoryListWidget] displays the history of the words liked or disliked by the user. <br>
/// It uses the [FavoriteBloc] to get the list of words and display them in a [ListView]. <br>
/// The [HistoryListWidget] is used in the [FavoriteHistoryPage]. <br>
/// It is a [StatelessWidget] because it does not need to manage its own state. <br>
class HistoryListWidget extends StatelessWidget {
  HistoryListWidget({super.key});

  /// AnimatedList needs to be used with a GlobalKey
  final _key = GlobalKey();

  static const Gradient _maskingGradient = LinearGradient(
    colors: [Colors.transparent, Colors.black],
    stops: [0.0, 0.5],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(builder: (context, state) {
      if (state is WordListLoadedState) {
        return ShaderMask(
          shaderCallback: (bounds) => _maskingGradient.createShader(bounds),
          blendMode: BlendMode.dstIn,
          //child: buildListView(state),
          child: buildAnimatedList(state),
        );
      } else {
        return const Center(
          child: Text('No history yet'),
        );
      }
    });
  }

  /// AnimatedList needs to be used with a GlobalKey
  AnimatedList buildAnimatedList(WordListLoadedState state) {
    return AnimatedList(
      key: _key,
      reverse: true,
      padding: const EdgeInsets.only(top: 100),
      initialItemCount: state.wordList.length,
      itemBuilder: (context, index, animation) {
        final word = state.wordList.elementAt(index);
        return SizeTransition(
          sizeFactor: animation,
          child: Center(
            child: TextButton.icon(
              onPressed: () {
                context.read<FavoriteBloc>().add(ToggleFavoriteEvent(word.pair));
              },
              icon: word.isFavorite ? const Icon(Icons.favorite, size: 12) : const SizedBox(),
              label: Text(
                word.pair.asPascalCase,
                semanticsLabel: word.pair.asPascalCase,
              ),
            ),
          ),
        );
      },
    );
  }

  /// ListView does not need a GlobalKey and more simple to use
  ListView buildListView(WordListLoadedState state) {
    return ListView.builder(
      // key: _key,
      reverse: true,
      padding: const EdgeInsets.only(top: 100),
      itemCount: state.wordList.length,
      itemBuilder: (context, index) {
        final word = state.wordList.elementAt(index);
        return Center(
          child: TextButton.icon(
            onPressed: () {
              context.read<FavoriteBloc>().add(ToggleFavoriteEvent(word.pair));
            },
            icon: Icon(
              word.isFavorite ? Icons.favorite : Icons.favorite_border,
              size: 12,
            ),
            label: Text(
              word.pair.first,
              semanticsLabel: word.pair.first,
            ),
          ),
        );
      },
    );
  }
}

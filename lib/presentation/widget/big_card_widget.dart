import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/favorite/favorite.dart';

/// The [BigCard] widget is a [Card] that displays the generated random word pair <br>
/// The [BigCard] widget is a [StatelessWidget] because it does not need to change its state <br>
/// The [BigCard] widget is a [BlocBuilder] that listens to the [FavoriteBloc] and rebuilds the widget when the state changes <br>
class BigCard extends StatelessWidget {
  const BigCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: MergeSemantics(
            child: BlocBuilder<FavoriteBloc, FavoriteState>(builder: (context, state) {
              Word? current;
              if (state is WordListLoadedState) {
                current = state.current;
              }
              return buildWrapText(current, style);
            }),
          ),
        ),
      ),
    );
  }

  Wrap buildWrapText(Word? current, TextStyle style) {
    return Wrap(
      children: [
        Text(
          current != null ? current.pair.first : 'Loading...',
          style: style.copyWith(fontWeight: FontWeight.w200),
        ),
        Text(
          current != null ? current.pair.second : '',
          style: style.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

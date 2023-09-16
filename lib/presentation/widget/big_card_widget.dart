
import 'package:flutter/material.dart';

import '../bloc/favorite/favorite.dart';

class BigCard extends StatelessWidget {
  const BigCard({super.key, required this.favorite});
  final Favorite favorite;

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
            child: Wrap(children: [
              Text(
                favorite.first,
                style: style.copyWith(fontWeight: FontWeight.w200),
              ),
              Text(
                favorite.second,
                style: style.copyWith(fontWeight: FontWeight.bold),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

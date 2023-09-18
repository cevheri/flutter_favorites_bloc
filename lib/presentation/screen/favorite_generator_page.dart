import 'package:flutter/material.dart';
import 'package:flutter_favorites_bloc/presentation/widget/big_card_widget.dart';

import '../widget/history_list_widget.dart';

class FavoriteGeneratorPage extends StatelessWidget {
  const FavoriteGeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    // IconData icon = Icons.favorite_border;
    //context.read<FavoriteBloc>().add(NextRandomPairEvent());
    return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Expanded(flex: 3, child: HistoryListWidget()),
             SizedBox(height: 10.0),
             BigCard(),
          ],
        ),

    );
  }
}

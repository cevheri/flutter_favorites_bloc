import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/screen/home_page.dart';
import 'presentation/bloc/favorite/favorite.dart';

void main() {
  runApp(const FavoriteApp());
}

class FavoriteApp extends StatelessWidget {
  const FavoriteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
          BlocProvider<FavoriteBloc>(create: (_) => FavoriteBloc()),
      ],
      child: MaterialApp(
        title: 'Favorite App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        //debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}



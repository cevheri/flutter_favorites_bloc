part of 'favorite_bloc.dart';

abstract class FavoriteState {}

class FavoriteInitialState extends FavoriteState {}

class FavoriteLoadingState extends FavoriteState {}

class FavoriteLoadedState extends FavoriteState {
  final Set<Word> wordList;
  FavoriteLoadedState({required this.wordList});
}

class ToggleFavoriteState extends FavoriteState {
  final Set<Word> wordList;
  final Word current;
  ToggleFavoriteState({required this.wordList, required this.current});
}

class NextRandomPairState extends FavoriteState {
  final Word current;
  NextRandomPairState({required this.current});
}

class FavoriteErrorState extends FavoriteState {
  final String message;
  FavoriteErrorState({required this.message});
}
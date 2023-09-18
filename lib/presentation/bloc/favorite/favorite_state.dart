part of 'favorite_bloc.dart';

class FavoriteState {}

class FavoriteInitialState extends FavoriteState {}

class FavoriteLoadingState extends FavoriteState {}

class WordListLoadedState extends FavoriteState {
  final Set<Word> wordList;
  final Word current;

  WordListLoadedState({required this.current, required this.wordList});
}

class FavoriteHistoryPageLoadedState extends FavoriteState {
  final Set<Word> wordList;

  FavoriteHistoryPageLoadedState({required this.wordList});
}

class FavoriteErrorState extends FavoriteState {
  final String message;

  FavoriteErrorState({required this.message});
}

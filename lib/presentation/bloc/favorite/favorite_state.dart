part of 'favorite_bloc.dart';

class FavoriteState {}

class FavoriteInitialState extends FavoriteState {}

class FavoriteLoadingState extends FavoriteState {}

class WordListLoadedState extends FavoriteState {

  GlobalKey? historyListKey = GlobalKey();
  final Set<Word> wordList;
  final Word current;
  WordListLoadedState({required this.current, required this.wordList, this.historyListKey});
}

class FavoriteHistoryPageLoadedState extends FavoriteState {
  final Set<Word> wordList;
  FavoriteHistoryPageLoadedState({required this.wordList});
}


// class ToggleFavoriteState extends FavoriteState {
//   final Word current;
//
//   ToggleFavoriteState({required this.current});
// }
//
// class NextRandomPairState extends FavoriteState {
//   final Word current;
//
//   NextRandomPairState({required this.current});
// }

class FavoriteErrorState extends FavoriteState {
  final String message;

  FavoriteErrorState({required this.message});
}

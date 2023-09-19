part of 'favorite_bloc.dart';

/// States for the [FavoriteBloc]
///
/// FavoriteState is a sealed class because it is extended by other classes
///
/// [FavoriteInitialState] - Initial state <br>
/// [FavoriteLoadingState] - Loading state <br>
/// [WordListLoadedState] - Word list loaded state <br>
/// [FavoriteErrorState] - Error state
sealed class FavoriteState {}

/// Initial state of the [FavoriteBloc]
///
/// When the [FavoriteBloc] is initialized, the [FavoriteInitialState] is returned
///
/// [FavoriteInitialState] extends [FavoriteState]
class FavoriteInitialState extends FavoriteState {}

/// Loading state of the [FavoriteBloc]
///
/// When the [FavoriteBloc] is loading, the [FavoriteLoadingState] is returned
///
/// [FavoriteLoadingState] extends [FavoriteState]
class FavoriteLoadingState extends FavoriteState {}

/// Word list loaded state of the [FavoriteBloc]
///
/// When the word list is loaded, the current word and the word list are returned
/// [ToggleFavoriteState] and [NextRandomPairState] are using this state
///
/// [WordListLoadedState] extends [FavoriteState]
class WordListLoadedState extends FavoriteState {
  final Set<Word> wordList;
  final Word current;

  WordListLoadedState({required this.current, required this.wordList});
}

/// Error state of the [FavoriteBloc]
///
/// When the [FavoriteBloc] is in error, the [FavoriteErrorState] is returned
///
/// [FavoriteErrorState] extends [FavoriteState]
class FavoriteErrorState extends FavoriteState {
  final String message;

  FavoriteErrorState({required this.message});
}

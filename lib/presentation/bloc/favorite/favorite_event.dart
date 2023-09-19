part of 'favorite_bloc.dart';

/// Events for the [FavoriteBloc]
///
/// FavoriteEvent is a sealed class because it is extended by other classes
///
/// [NextRandomPairEvent] - Load next random pair <br>
/// [ToggleFavoriteEvent] - Toggle favorite for current pair
sealed class FavoriteEvent {}

/// Load next random pair
///
/// When the app is started or the next button is pressed, the [NextRandomPairEvent] is returned in the [FavoriteGeneratorPage] <br>
/// When the event triggers, the [FavoriteBloc] loads the next random pair and returns the [WordListLoadedState] in the [FavoriteGeneratorPage] <br>
///
/// [NextRandomPairEvent] extends [FavoriteEvent]
class NextRandomPairEvent extends FavoriteEvent {}

/// Toggle favorite for current pair
///
/// When the favorite button is pressed, the [ToggleFavoriteEvent] is returned in the [FavoriteGeneratorPage] <br>
/// When the event triggers, the [FavoriteBloc] toggles the favorite for the current pair and returns the [WordListLoadedState] in the [FavoriteGeneratorPage] and [FavoriteHistoryPage] <br>
class ToggleFavoriteEvent extends FavoriteEvent {
  final WordPair current;

  ToggleFavoriteEvent(this.current);
}

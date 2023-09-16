
part of 'favorite_bloc.dart';

abstract class FavoriteEvent{}

class NextRandomPairEvent extends FavoriteEvent{}

class ToggleFavoriteEvent extends FavoriteEvent{
  final Favorite current;
  ToggleFavoriteEvent(this.current);
}

class LoadAllFavoritesEvent extends FavoriteEvent{}
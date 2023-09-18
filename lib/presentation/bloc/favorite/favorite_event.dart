
part of 'favorite_bloc.dart';

abstract class FavoriteEvent{}

class NextRandomPairEvent extends FavoriteEvent{}

class ToggleFavoriteEvent extends FavoriteEvent{
  final WordPair current;
  ToggleFavoriteEvent(this.current);
}

class FavoriteLoadAllEvent extends FavoriteEvent{}
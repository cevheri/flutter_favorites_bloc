part of 'favorite_bloc.dart';

abstract class FavoriteState {}

class FavoriteInitialState extends FavoriteState {}

class FavoriteLoadingState extends FavoriteState {}

class FavoriteLoadedState extends FavoriteState {
  final Set<Favorite> favorites;
  final Favorite current;
  FavoriteLoadedState({required this.favorites, required this.current});
}

class FavoriteErrorState extends FavoriteState {
  final String message;
  FavoriteErrorState({required this.message});
}
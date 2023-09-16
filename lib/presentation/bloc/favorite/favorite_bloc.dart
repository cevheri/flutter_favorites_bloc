import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/error/data_source_exception.dart';
import '../../../data/model/favorite_model.dart';
import '../../../data/repository/favorite_repository.dart';

part 'favorite_event.dart';

part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitialState()) {
    on<ToggleFavoriteEvent>(_toggleFavorite);
    on<LoadAllFavoritesEvent>(_loadAllFavorites);
  }

  final FavoriteRepository _favoriteRepository = FavoriteRepository.instance;

  /// Load All favorites from repository
  ///
  /// return: Future [List<Favorite>] favorites <br>
  Future<Set<Favorite>> loadAllFavorites() async {
    return await _favoriteRepository.getAllFavorites();
  }

  FutureOr<Set<Favorite>> _loadAllFavorites(
    LoadAllFavoritesEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(FavoriteLoadingState());
    try {
      final Set<Favorite> favorites = await loadAllFavorites();
      emit(FavoriteLoadedState(favorites: favorites, current: Favorite.empty()));
    } catch (e) {
      emit(FavoriteErrorState(message: "Unhandled Load Error"));
      rethrow;
    }
    return Future.value(Set.identity());
  }

  /// Add favorite to repository
  ///
  /// param: [Favorite] favorite <br>
  /// return: Future [Favorite] favorite <br>
  Future<Favorite> addFavorite(Favorite favorite) async {
    return await _favoriteRepository.addFavorite(favorite);
  }

  /// Remove favorite from repository
  ///
  /// param: [Favorite] favorite <br>
  /// return: Future [Void] <br>
  Future<void> removeFavorite(Favorite favorite) async {
    await _favoriteRepository.removeFavorite(favorite);
  }

  /// Check if favorite is already in repository
  ///
  /// param: [Favorite] favorite <br>
  /// return: Future [Bool] <br>
  Future<bool> _isFavorite(Favorite favorite) async {
    return loadAllFavorites().then((value) => value.contains(favorite));
  }

  FutureOr<Favorite> _toggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(FavoriteLoadingState());
    Favorite favorite = event.current;
    try {
      if (await _isFavorite(favorite)) {
        await removeFavorite(favorite);
      } else {
        await addFavorite(favorite);
      }
      final favorites = await loadAllFavorites();
      emit(FavoriteLoadedState(favorites: favorites, current: favorite));
    } on DataSourceException catch (e) {
      emit(FavoriteErrorState(message: "Toggle Error: ${e.code}: ${e.message}"));
      rethrow;
    }
    return favorite;
  }
}

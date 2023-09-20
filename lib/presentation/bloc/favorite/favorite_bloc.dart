import 'dart:async';

import 'package:english_words/english_words.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_favorites_bloc/presentation/screen/favorite_history_page.dart';

import '../../../data/model/word_model.dart';
import '../../../data/repository/error/data_source_exception.dart';
import '../../../data/repository/favorite_repository.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

/// The bloc that manages the state of the favorites.
///
/// [FavoriteBloc] extends [Bloc] and uses [FavoriteEvent] and [FavoriteState]
class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitialState()) {
    on<ToggleFavoriteEvent>(_toggleFavorite);
    on<NextRandomPairEvent>(_nextRandomPair);
  }

  final FavoriteRepository _favoriteRepository = FavoriteRepository.instance;

  /// Load next random pair. <br>
  /// It is public and common for all blocs.
  ///
  /// return: Future [Word] next random pair <br>
  /// throw: [RepositoryException] if an error occurs <br>
  Future<Word> nextRandomPair() async {
    Word random = Word.random();
    return await _favoriteRepository.add(random);
  }

  /// Load All favorites from repository
  ///
  /// return: Future [List<Word>] favorites <br>
  /// throw: [RepositoryException] if an error occurs <br>
  Future<Set<Word>> getAllFavoriteWords() async {
    return await _favoriteRepository.getAllLiked();
  }

  /// Load All Word list for HistoryList
  ///
  /// return: Future [List<Word>] favorites <br>
  /// throw: [RepositoryException] if an error occurs <br>
  Future<Set<Word>> getAllWords() async {
    return await _favoriteRepository.list();
  }

  /// Add favorite
  ///
  /// param: [WordPair] pair <br>
  /// return: Future [Word] favorite <br>
  /// throw: [RepositoryException] if an error occurs <br>
  Future<Word> like(WordPair pair) async {
    return await _favoriteRepository.like(pair);
  }

  /// Remove favorite
  ///
  /// param: [WordPair] pair <br>
  /// return: Future [Void] <br>
  /// throw: [RepositoryException] if an error occurs <br>
  Future<Word> dislike(WordPair pair) async {
    return await _favoriteRepository.dislike(pair);
  }

  /// Remove all words
  ///
  /// return: Future [Void] <br>
  /// throw: [RepositoryException] if an error occurs <br>
  Future<void> clear() async {
    return await _favoriteRepository.clear();
  }


  /// Check if favorite is already in repository
  ///
  /// param: [Word] favorite <br>
  /// return: Future [Bool] <br>
  /// throw: [RepositoryException] if an error occurs <br>
  Future<bool> _isFavorite(WordPair pair) async {
    return getAllFavoriteWords().then((list) => list.any((element) => element.pair == pair));
  }

  /// Toggle favorite for current pair <br>
  /// If the current pair is already liked, it will be disliked and vice versa.
  ///
  /// param: [WordPair] current <br>
  /// return: Future [Word] favorite <br>
  /// throw: [RepositoryException] if an error occurs <br>
  Future<Word> toggleFavorite(WordPair current) async {
    if (await _isFavorite(current)) {
      return await dislike(current);
    } else {
      return await like(current);
    }
  }

  /// Toggle favorite method for the [ToggleFavoriteEvent]
  ///
  /// param: [ToggleFavoriteEvent] event <br>
  /// param: [Emitter<FavoriteState>] emit <br>
  /// return: Future [Void] <br>
  /// throw: [FavoriteErrorState] if an error occurs <br>
  FutureOr<void> _toggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(FavoriteLoadingState());
    try {
      Word favorite = await toggleFavorite(event.current);
      emit(WordListLoadedState(wordList: await getAllWords(), current: favorite));
    } on RepositoryException catch (e) {
      emit(FavoriteErrorState(message: "Toggle Error: ${e.code}: ${e.message}"));
    }
  }

  /// Load next random pair method for the [NextRandomPairEvent]
  ///
  /// param: [NextRandomPairEvent] event <br>
  /// param: [Emitter<FavoriteState>] emit <br>
  /// return: Future [Void] <br>
  /// throw: [FavoriteErrorState] if an error occurs <br>
  FutureOr<void> _nextRandomPair(NextRandomPairEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoadingState());
    try {
      final current = await nextRandomPair();
      emit(WordListLoadedState(wordList: await getAllWords(), current: current));
    } catch (e) {
      emit(FavoriteErrorState(message: "Unhandled Load Error"));
      rethrow;
    }
    return Future.value();
  }
}

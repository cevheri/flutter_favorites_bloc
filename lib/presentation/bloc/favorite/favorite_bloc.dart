import 'dart:async';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/error/data_source_exception.dart';
import '../../../data/model/word_model.dart';
import '../../../data/repository/favorite_repository.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitialState()) {
    on<ToggleFavoriteEvent>(_toggleFavorite);
    on<FavoriteLoadAllEvent>(_loadAll);
    on<NextRandomPairEvent>(_nextRandomPair);
  }
  GlobalKey? listKey = GlobalKey();
  final FavoriteRepository _favoriteRepository = FavoriteRepository.instance;

  Future<Word> nextRandomPair() async {
    Word random = Word.random();
    return await _favoriteRepository.add(random);
  }

  /// Load All favorites from repository
  ///
  /// return: Future [List<Word>] favorites <br>
  Future<Set<Word>> getAllFavoriteWords() async {
    return await _favoriteRepository.getAllLiked();
  }

  /// Load All Word list for HistoryList
  Future<Set<Word>> getAllWords() async {
    return await _favoriteRepository.list();
  }

  /// Add favorite
  ///
  /// param: [WordPair] pair <br>
  /// return: Future [Word] favorite <br>
  Future<Word> like(WordPair pair) async {
    return await _favoriteRepository.like(pair);
  }

  /// Remove favorite
  ///
  /// param: [WordPair] pair <br>
  /// return: Future [Void] <br>
  Future<Word> dislike(WordPair pair) async {
    return await _favoriteRepository.dislike(pair);
  }

  /// Check if favorite is already in repository
  ///
  /// param: [Word] favorite <br>
  /// return: Future [Bool] <br>
  Future<bool> _isFavorite(WordPair pair) async {
    return getAllFavoriteWords().then((list) => list.any((element) => element.pair == pair));
  }

  FutureOr<Set<Word>> _loadAll(
    FavoriteLoadAllEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(FavoriteLoadingState());
    try {
      final Set<Word> wordList = await getAllWords();
      emit(FavoriteHistoryPageLoadedState(wordList: wordList));
    } catch (e) {
      emit(FavoriteErrorState(message: "Unhandled Load Error"));
      rethrow;
    }
    return Future.value(Set.identity());
  }

  Future<Word> toggleFavorite(WordPair current) async {
    if (await _isFavorite(current)) {
      return await dislike(current);
    } else {
      return await like(current);
    }
  }

  FutureOr<void> _toggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(FavoriteLoadingState());
    try {
      Word favorite = await toggleFavorite(event.current);
     // emit(ToggleFavoriteState(current: favorite));
      emit(WordListLoadedState(wordList: await getAllWords(), current: favorite));
    } on DataSourceException catch (e) {
      emit(FavoriteErrorState(message: "Toggle Error: ${e.code}: ${e.message}"));
    }
  }

  FutureOr<void> _nextRandomPair(NextRandomPairEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoadingState());
    try {
      final current = await nextRandomPair();
      //emit(NextRandomPairState(current: current));
      var animatedList = listKey?.currentState as AnimatedListState?;
      animatedList?.insertItem(0, duration: const Duration(milliseconds: 1000));
      emit(WordListLoadedState(wordList: await getAllWords(), current: current));
    } catch (e) {
      emit(FavoriteErrorState(message: "Unhandled Load Error"));
      rethrow;
    }
    return Future.value();
  }
}

import 'dart:async';

import 'package:english_words/english_words.dart';

import '../error/data_source_exception.dart';
import '../model/word_model.dart';

/// The repository that manages the data of the favorites.
///
/// use Singleton pattern to create only one instance of this class
/// ```dart
/// FavoriteRepository.instance;
/// ```
class FavoriteRepository {
  final _FavoriteDataSource _dataSource;

  FavoriteRepository._() : _dataSource = _FavoriteDataSource.instance;

  /// The instance of the [FavoriteRepository] <br>
  static final FavoriteRepository instance = FavoriteRepository._();

  /// Get all favorites from the repository
  ///
  /// return: [Set<Favorite>] favorites <br>
  /// throw: [RepositoryException] if an error occurs <br>
  Future<Set<Word>> list() async {
    try {
      return await _dataSource.list();
    } catch (e) {
      throw RepositoryException(message: "An error occurred while getting favorites", code: "favorite_get_error");
    }
  }

  /// Get all liked Words from the repository
  ///
  /// return: [Set<Favorite>] favorites <br>
  /// throw: [RepositoryException] if an error occurs <br>
  Future<Set<Word>> getAllLiked() async {
    try {
      return await _dataSource.list().then((value) => value.where((element) => element.isFavorite).toSet());
    } catch (e) {
      throw RepositoryException(message: "An error occurred while getting favorites", code: "favorite_get_error");
    }
  }

  /// Get all disliked Words from the repository
  ///
  /// return: [Set<Favorite>] favorites  <br>
  /// throw: [RepositoryException] if an error occurs <br>
  Future<Set<Word>> getAllDisliked() async {
    try {
      return await _dataSource.list().then((value) => value.where((element) => !element.isFavorite).toSet());
    } catch (e) {
      throw RepositoryException(message: "An error occurred while getting favorites", code: "favorite_get_error");
    }
  }


  /// Add word to the favorite repository
  ///
  /// param: [WordPair] word model <br>
  /// return: [Word] word model <br>
  /// throw: [RepositoryException] if an error occurs
  Future<Word> add(Word word) async {
    try {
      return await _dataSource.add(word);
    } catch (e) {
      throw RepositoryException(message: "An error occurred while adding word", code: "favorite_add_error");
    }
  }

  /// Remove word from the favorite repository
  ///
  /// param: [Word] word model <br>
  /// return: [Void] <br>
  /// throw: [RepositoryException] if an error occurs <br>
  Future<void> remove(Word word) async {
    try {
      await _dataSource.remove(word);
    } catch (e) {
      throw RepositoryException(message: "An error occurred while removing word", code: "favorite_remove_error");
    }
  }

  /// Like the word from the favorite repository <br>
  ///
  /// param: [WordPair] favorite <br>
  /// return: [Word] favorite <br>
  /// throw: [RepositoryException] if an error occurs <br>
  Future<Word> like(WordPair favorite) async {
    try {
     return await _dataSource.like(favorite);
    } catch (e) {
      throw RepositoryException(message: "An error occurred while removing word", code: "favorite_remove_error");
    }
  }

  /// Dislike the word from the favorite repository
  ///
  /// param: [WordPair] favorite <br>
  /// return: [Word] favorite <br>
  /// throw: [RepositoryException] if an error occurs <br>
  Future<Word> dislike(WordPair pair) async {
    try {
      return await _dataSource.dislike(pair);
    } catch (e) {
      throw RepositoryException(message: "An error occurred while removing word", code: "favorite_remove_error");
    }
  }

}

/// The temporary data source for the favorites.
///
///
/// use Singleton pattern to create only one instance of this class
/// ```dart
/// _FavoriteDataSource.instance;
/// ```
///
@Deprecated("Mock API will be used instead of this class in the next version")
class _FavoriteDataSource {
  final Set<Word> _wordList = {};

  _FavoriteDataSource._();

  static final _FavoriteDataSource instance = _FavoriteDataSource._();

  Future<Set<Word>> list() async {
    return _wordList;
  }

  Future<Word> add(Word word) async {
    _wordList.add(word);
    return word;
  }

  Future<void> remove(Word word) async {
    _wordList.remove(word);
  }

  Future<Word> like(WordPair favorite) async {
    // debugPrint("like >> _wordList before : $_wordList");
    for (var element in _wordList) {
      if (element.pair == favorite) {
        _wordList.remove(element);
        var newElement = Word.from(pair: favorite, isFavorite: true);
        _wordList.add(newElement);
        // debugPrint("_wordList after like: $_wordList");
        return newElement;
      }
    }
    return add(Word.from(pair: favorite, isFavorite: true));
  }

  Future<Word> dislike(WordPair word) async {
    // debugPrint("_wordList before dislike: $_wordList");
    for (var element in _wordList) {
      if (element.pair == word) {
        _wordList.remove(element);
        var newElement = Word.from(pair: word, isFavorite: false);
        _wordList.add(newElement);
        // debugPrint("_wordList after dislike: $_wordList");
        return newElement;
      }
    }
    return add(Word.from(pair: word, isFavorite: false));
  }
}

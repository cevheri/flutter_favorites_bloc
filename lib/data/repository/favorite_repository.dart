
import '../error/data_source_exception.dart';
import '../model/favorite_model.dart';

/// The repository that manages the data of the favorites.
///
/// use Singleton pattern to create only one instance of this class
/// ```dart
/// FavoriteRepository.instance;
/// ```
class FavoriteRepository {
  final _FavoriteDataSource _dataSource;

  FavoriteRepository._() : _dataSource = _FavoriteDataSource.instance;
  static final FavoriteRepository instance = FavoriteRepository._();

  /// Get all favorites from the repository
  ///
  /// return: [List<Favorite>] favorites
  ///
  /// throw: [DataSourceException] if an error occurs
  Future<Set<Favorite>> getAllFavorites() async {
    try {
      return await _dataSource.getFavorites();
    } catch (e) {
      throw DataSourceException(message: "An error occurred while getting favorites", code: "favorite_get_error");
    }
  }

  /// Add favorite to the repository
  ///
  /// param: [Favorite] favorite model
  ///
  /// throw: [DataSourceException] if an error occurs
  Future<Favorite> addFavorite(Favorite favorite) async {
    try {
      return await _dataSource.addFavorite(favorite);
    } catch (e) {
      throw DataSourceException(message: "An error occurred while adding favorite", code: "favorite_add_error");
    }
  }

  /// Remove favorite from the repository
  ///
  /// param: [Favorite] favorite model
  ///
  /// throw: [DataSourceException] if an error occurs
  Future<void> removeFavorite(Favorite favorite) async {
    try {
      return await _dataSource.removeFavorite(favorite);
    } catch (e) {
      throw DataSourceException(message: "An error occurred while removing favorite", code: "favorite_remove_error");
    }
  }
}

class _FavoriteDataSource {
  final Set<Favorite> _favorites = {};

  _FavoriteDataSource._();

  static final _FavoriteDataSource instance = _FavoriteDataSource._();

  Future<Set<Favorite>> getFavorites() async {
    return _favorites;
  }

  Future<Favorite> addFavorite(Favorite favorite) async {
    _favorites.add(favorite);
    return favorite;
  }

  Future<void> removeFavorite(Favorite favorite) async {
    _favorites.remove(favorite);
  }
}


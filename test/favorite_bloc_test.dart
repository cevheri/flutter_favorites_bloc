
import 'package:flutter_favorites_bloc/presentation/bloc/favorite/favorite.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  /// test FavoriteBloc.nextRandomPair
  test("Random Pair test", () async {
     var word = await FavoriteBloc().nextRandomPair();
      expect(word, isNotNull);
      expect(word.isFavorite, false);
  });


  /// test Like
  test("Like test", () async {
    var bloc = FavoriteBloc();
    bloc.clear();

    var word = await bloc.nextRandomPair();

    var allWords = await bloc.getAllWords();
    expect(allWords.length, 1);

    var likedWord = await bloc.like(word.pair);
    expect(likedWord.isFavorite, true);

    var favorites = await bloc.getAllFavoriteWords();
    expect(favorites, isNotNull);
    expect(favorites.length, 1);
    expect(favorites.first, likedWord);

  });

  /// test Dislike
  test("Dislike test", () async {
    var bloc = FavoriteBloc();
    bloc.clear();

    var word = await bloc.nextRandomPair();

    var disliked = await bloc.dislike(word.pair);
    expect(disliked.isFavorite, false);
    expect(disliked.pair, word.pair);

    var allWords = await bloc.getAllWords();
    expect(allWords.length, 1);

    var favorites2 = await bloc.getAllFavoriteWords();
    expect(favorites2.length, 0);
  });


}
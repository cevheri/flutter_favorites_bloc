import 'package:english_words/english_words.dart';

/// A model class for a favorite word pair.
///
/// This class is used to store a word pair and its favorite status.
///
/// The [pair] property is the word pair itself.
///
/// The [isFavorite] property is the favorite status of the word pair.
///
/// The [Word] class has a factory constructor named [random] that returns
/// a random Word word pair.
///
/// The [Word] class has a factory constructor named [fromJson] that returns
/// a Word word pair from a JSON object.
///
/// The [Word] class has a factory constructor named [from] that returns
/// a Word word pair from a word pair and a Word status.
///
/// The [Word] class has a method named [toJson] that returns
/// a JSON object from a Word word pair.
class Word {
  WordPair pair;
  bool isFavorite;

  Word({required this.pair, this.isFavorite = false});

 factory Word.random() {
    return Word(
      pair: WordPair.random(),
      isFavorite: false,
    );
  }

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      pair: WordPair(json['first'], json['second']),
      isFavorite: json['isFavorite'],
    );
  }

  factory Word.from({required WordPair pair, bool? isFavorite}) {
    return Word(
      pair: pair,
      isFavorite: isFavorite ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first': pair.first,
      'second': pair.second,
      'isFavorite': isFavorite,
    };
  }

  @override
  String toString() {
    return 'Word{pair: $pair, isFavorite: $isFavorite}';
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is Word && runtimeType == other.runtimeType && pair == other.pair;

  @override
  int get hashCode => pair.hashCode;
}

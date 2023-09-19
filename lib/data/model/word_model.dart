import 'package:english_words/english_words.dart';

/// A model class for a favorite word pair. <br>
/// This class is used to store a word pair and its favorite status.  <br>
/// The [pair] property is the word pair itself. <br>
/// The [isFavorite] property is the favorite status of the word pair. <br>
/// The [Word] class has a factory constructor named [random] that returns a random Word word pair. <br>
/// The [Word] class has a factory constructor named [fromJson] that returns a Word word pair from a JSON object. <br>
/// The [Word] class has a factory constructor named [from] that returns a Word word pair from a word pair and a Word status. <br>
/// The [Word] class has a method named [toJson] that returns a JSON object from a Word word pair. <br>
class Word {
  /// The word pair itself. Using the [WordPair] class from the english_words package.
  WordPair pair;

  /// The favorite status of the word pair. <br>
  /// The default value is false.  <br>
  bool isFavorite;

  Word({required this.pair, this.isFavorite = false});

  /// Returns a random Word word pair.
 factory Word.random() {
    return Word(
      pair: WordPair.random(),
      isFavorite: false,
    );
  }

  /// Returns a Word word pair from a JSON object.
  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      pair: WordPair(json['first'], json['second']),
      isFavorite: json['isFavorite'],
    );
  }

  /// Returns a Word word pair from a word pair and a Word status.
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

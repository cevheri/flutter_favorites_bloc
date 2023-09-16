import 'package:english_words/english_words.dart';

class Favorite extends WordPair {
  Favorite({
    required String first,
    required String second,
  }) : super(first, second);

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      first: json['first'],
      second: json['first'],
    );
  }

  Map<String, dynamic> toJson() => {
        'first': first,
        'second': second,
      };

  @override
  String toString() => 'Favorite[first=$first, second=$second]';

  @override
  bool operator ==(Object other) => identical(this, other) || other is Favorite && other.first == first && other.second == second;

  @override
  int get hashCode => first.hashCode ^ second.hashCode;

  factory Favorite.empty() => Favorite(first: '', second: '');
}

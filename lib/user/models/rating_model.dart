class Rating {
  final String comment;
  final double rating;

  Rating({
    required this.comment,
    required this.rating,
  });

  factory Rating.fromJson(Map<dynamic, dynamic> json) {
    return Rating(
      comment: json['comment'] as String,
      rating: json['rating'] as double,
    );
  }
}

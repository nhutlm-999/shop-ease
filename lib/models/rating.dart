class Rating {
  final double rate;
  final int count;

  Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json['rate'] as num).toDouble(),
      count: json['count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      rate: (map['rate'] as num).toDouble(),
      count: map['count'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rate': rate,
      'count': count,
    };
  }

  @override
  String toString() {
    return 'rate: $rate, count: $count';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Rating &&
      other.rate == rate &&
      other.count == count;
  }

  @override
  int get hashCode {
    return rate.hashCode ^ count.hashCode;
  }
}
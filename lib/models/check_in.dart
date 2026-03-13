class CheckIn {
  CheckIn({
    required this.id,
    required this.classId,
    required this.timestamp,
    required this.lat,
    required this.lng,
    required this.prevTopic,
    required this.expectedTopic,
    required this.moodScore,
  });

  final String id;
  final String classId;
  final DateTime timestamp;
  final double lat;
  final double lng;
  final String prevTopic;
  final String expectedTopic;
  final int moodScore;

  Map<String, dynamic> toJson() => {
        'id': id,
        'classId': classId,
        'timestamp': timestamp.toIso8601String(),
        'lat': lat,
        'lng': lng,
        'prevTopic': prevTopic,
        'expectedTopic': expectedTopic,
        'moodScore': moodScore,
      };

  factory CheckIn.fromJson(Map<String, dynamic> json) => CheckIn(
        id: json['id'] as String,
        classId: json['classId'] as String,
        timestamp: DateTime.parse(json['timestamp'] as String),
        lat: (json['lat'] as num).toDouble(),
        lng: (json['lng'] as num).toDouble(),
        prevTopic: json['prevTopic'] as String,
        expectedTopic: json['expectedTopic'] as String,
        moodScore: json['moodScore'] as int,
      );
}

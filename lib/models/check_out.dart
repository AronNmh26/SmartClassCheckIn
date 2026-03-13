class CheckOut {
  CheckOut({
    required this.id,
    required this.classId,
    required this.timestamp,
    required this.lat,
    required this.lng,
    required this.learnedToday,
    required this.feedback,
  });

  final String id;
  final String classId;
  final DateTime timestamp;
  final double lat;
  final double lng;
  final String learnedToday;
  final String feedback;

  Map<String, dynamic> toJson() => {
        'id': id,
        'classId': classId,
        'timestamp': timestamp.toIso8601String(),
        'lat': lat,
        'lng': lng,
        'learnedToday': learnedToday,
        'feedback': feedback,
      };

  factory CheckOut.fromJson(Map<String, dynamic> json) => CheckOut(
        id: json['id'] as String,
        classId: json['classId'] as String,
        timestamp: DateTime.parse(json['timestamp'] as String),
        lat: (json['lat'] as num).toDouble(),
        lng: (json['lng'] as num).toDouble(),
        learnedToday: json['learnedToday'] as String,
        feedback: json['feedback'] as String,
      );
}

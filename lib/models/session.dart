class Session {
  late int id;
  late DateTime startedAt;
  late Duration duration;
  late bool successStatus;

  Session({
    required this.id,
    required this.startedAt,
    required this.duration,
    required this.successStatus,
  });

  static fromJson(sessionData) {
    return Session(
        id: sessionData['id'],
        startedAt: sessionData['startedAt'],
        duration: sessionData['duration'],
        successStatus: sessionData['successStatus']);
  }

//  factory Sticker.fromJson(Map<String, dynamic> jsonData) {
//     return Sticker(
//       id: jsonData['id'],
//       path: jsonData['path'],
//       ownedAmount: jsonData['ownedAmount'],
//       usedAmount: jsonData['usedAmount'],
//       usable: jsonData['usable'],
//     );
//   }
}

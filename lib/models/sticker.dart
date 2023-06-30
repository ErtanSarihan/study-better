class Sticker {
  final String id;
  final String path;
  late int ownedAmount;
  late int usedAmount;
  late bool usable;
  // list of tile indexes

  Sticker(
      {required this.id,
      required this.path,
      required this.ownedAmount,
      required this.usedAmount,
      required this.usable});

  static Map<String, dynamic> toJson(Sticker sticker) {
    return {
      "id": sticker.id,
      "path": sticker.path,
      "ownedAmount": sticker.ownedAmount,
      "usedAmount": sticker.usedAmount,
      "usable": sticker.usable
    };
  }

  factory Sticker.fromJson(Map<String, dynamic> jsonData) {
    return Sticker(
      id: jsonData['id'],
      path: jsonData['path'],
      ownedAmount: jsonData['ownedAmount'],
      usedAmount: jsonData['usedAmount'],
      usable: jsonData['usable'],
    );
  }

  Sticker copyWithOwnedAmount(int newOwnedAmount){
    return Sticker(id: id, path: path, ownedAmount: newOwnedAmount, usedAmount: usedAmount, usable: usable);
  }

  Sticker copyWithUsedAmount(int newUsedAmount){
    return Sticker(id: id, path: path, ownedAmount: ownedAmount, usedAmount: newUsedAmount, usable: usable);
  }

  //copyWith newUsedAmount

  @override
  String toString() {
    return 'Sticker{id: $id, path: $path, ownedAmount: $ownedAmount, usedAmount: $usedAmount, usable: $usable}';
  }

}

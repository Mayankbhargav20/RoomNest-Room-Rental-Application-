class Room {
  final int id;
  final String title;
  final double rent;
  final double deposit;
  final String city;
  final String area;
  final String address;
  final String roomType;
  final String gender;
  final String description;
  final bool available;

  Room({
    required this.id,
    required this.title,
    required this.rent,
    required this.deposit,
    required this.city,
    required this.area,
    required this.address,
    required this.roomType,
    required this.gender,
    required this.description,
    required this.available,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json["id"],
      title: json["title"] ?? "",
      rent: (json["rent"] as num).toDouble(),
      deposit: (json["deposit"] as num).toDouble(),
      city: json["city"] ?? "",
      area: json["area"] ?? "",
      address: json["address"] ?? "",
      roomType: json["roomType"] ?? "",
      gender: json["gender"] ?? "",
      description: json["description"] ?? "",
      available: json["available"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "rent": rent,
      "deposit": deposit,
      "city": city,
      "area": area,
      "address": address,
      "roomType": roomType,
      "gender": gender,
      "description": description,
      "available": available,
    };
  }
}

class RoomRequest {
  final String title;
  final double rent;
  final double deposit;
  final String city;
  final String area;
  final String address;
  final String roomType;
  final String gender;
  final String description;

  RoomRequest({
    required this.title,
    required this.rent,
    required this.deposit,
    required this.city,
    required this.area,
    required this.address,
    required this.roomType,
    required this.gender,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "rent": rent,
      "deposit": deposit,
      "city": city,
      "area": area,
      "address": address,
      "roomType": roomType,
      "gender": gender,
      "description": description,
    };
  }

  factory RoomRequest.fromJson(Map<String, dynamic> json) {
    return RoomRequest(
      title: json["title"] ?? "",
      rent: (json["rent"] as num).toDouble(),
      deposit: (json["deposit"] as num).toDouble(),
      city: json["city"] ?? "",
      area: json["area"] ?? "",
      address: json["address"] ?? "",
      roomType: json["roomType"] ?? "",
      gender: json["gender"] ?? "",
      description: json["description"] ?? "",
    );
  }
}

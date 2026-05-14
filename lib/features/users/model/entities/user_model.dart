class UserModel {
  final String name;
  final String? imageURL;
  final int level;
  final String? bio;
  final int plans;
  final int sites;
  final int nights;
  const UserModel({
    required this.name,
    this.imageURL,
    required this.level,
    required this.bio,
    required this.plans,
    required this.sites,
    required this.nights,
  });

  factory UserModel.fromjson(json) {
    return UserModel(
      name: json['username'],
      imageURL: json['userImage'],
      level: int.tryParse(json['adventureLevel'].toString()) ?? 0,
      bio: json['bio'],
      nights: json['nightsBooked'],
      plans: json['plansMade'],
      sites: json['sitesVisited']
    );
  }
}

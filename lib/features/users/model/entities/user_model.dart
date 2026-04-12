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
    this.level = 3,
    this.bio,
    this.plans = 0,
    this.sites = 0,
    this.nights = 0,
  });

  factory UserModel.fromjson(json) {
    return UserModel(
      name: json['username'],
      // imageURL: json['image'],
      // level: json['level'],
      // bio: json['bio'],
      // nights: json['nights'],
      // plans: json['plans'],
      // sites: json['sites']
    );
  }
}

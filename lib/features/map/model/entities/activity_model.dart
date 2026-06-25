class ActivityModel {
  final int cost;
  final String time;
  final String landmarkName;
  final String description;
  final String? image;
  final double lat;
  final double lng;

  ActivityModel({
    required this.cost,
    required this.time,
    required this.landmarkName,
    required this.description,
    required this.image,
    required this.lat,
    required this.lng,
  });

  factory ActivityModel.fromjson(json) {
    return ActivityModel(
      cost: json['cost_usd'],
      time: json['time']??'9:00 PM',
      landmarkName: json['title'],
      description: json['description'],
      image: json['image_url'] ,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }
  Map<String,dynamic> toJson(){
    return
{'cost_usd' : cost ,
'time' : time,
'description' : description,
'image_url' : image,
'lat' : lat,
'lng' : lng,
'title' : landmarkName,};
  }
}

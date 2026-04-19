import 'package:explore_egypt/features/map/model/entities/day_model.dart';

class TripModel {
  final String days;
  final List<DayModel> dayModel;
  TripModel({required this.days, required this.dayModel});

  factory TripModel.fromJson(json) {
    return TripModel(
      days: json['total_days'],
      dayModel: (json['days'] as List)
          .map((e) => DayModel.fromjson(e))
          .toList(),
    );
  }
}

class fakeData {
  static final Map<String, dynamic> fakeTrip = {
    "total_days": '1',
    "days": [
      {
        "total_cost": '70',
        "activities": [
          {
            "time": "09:00 AM",
            "title": "Giza Plateau",
            "description":
                "Explore the Great Pyramids and the Sphinx in a guided morning tour.",
            "cost": '10',
            "image_url": 'assets/images/pyramid.png',
            "category": "attraction",
          },
          {
            "time": "12:30 PM",
            "title": "Local Egyptian Lunch",
            "description":
                "Enjoy traditional Koshary and freshly baked baladi bread.",
            "cost": '15',
            "image_url": 'assets/images/pyramid.png',
            "category": "food",
          },
          {
            "time": "03:00 PM",
            "title": "Saqqara Step Pyramid",
            "description":
                "Visit the oldest stone pyramid in Egypt with historical insights.",
            "cost": '20',
            "image_url": 'assets/images/pyramid.png',
            "category": "attraction",
          },
          {
            "time": "07:00 PM",
            "title": "Nile Sunset Cruise",
            "description":
                "Relax on a boat ride along the Nile with sunset views and dinner.",
            "cost": '15',
            "image_url": 'assets/images/pyramid.png',
            "category": "experience",
          },
        ],
      },
    ],
  };
}

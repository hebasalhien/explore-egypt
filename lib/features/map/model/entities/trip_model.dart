import 'package:explore_egypt/features/map/model/entities/day_model.dart';

class TripModel {
  final String days;
  final String totalCost;
  final List<DayModel> dayModel;
  TripModel({
    required this.days,
    required this.totalCost,
    required this.dayModel,
  });

  factory TripModel.fromJson(json) {
    return TripModel(
      days: json['total_days'],
      totalCost: json['total_cost'],
      dayModel: (json['days'] as List)
          .map((e) => DayModel.fromjson(e))
          .toList(),
    );
  }
}

class fakeData{
   static final Map<String, dynamic> fakeTrip = {
   "total_days" :'1',
   "total_cost":"360 \$",
  "days": [
    {
      "id": "D1",
      "label": "D1",
      "day_number": 1,
      "date": "2026-04-15",
      "total_cost": '60',
      "itinerary": [
        {
          "id": "item_001",
          "time": "09:00 AM",
          "title": "Giza Plateau",
          "description": "Explore the Great Pyramids and the Sphinx in a guided morning tour.",
          "cost": '10',
          "image_url": "https://images.unsplash.com/photo-1609947017136-9daf32a5eb16",
          "category": "attraction"
        },
        {
          "id": "item_002",
          "time": "12:30 PM",
          "title": "Local Egyptian Lunch",
          "description": "Enjoy traditional Koshary and freshly baked baladi bread.",
          "cost": '15',
          "image_url": "https://images.unsplash.com/photo-1604908177522-040a5f4d5c9c",
          "category": "food"
        },
        {
          "id": "item_003",
          "time": "03:00 PM",
          "title": "Saqqara Step Pyramid",
          "description": "Visit the oldest stone pyramid in Egypt with historical insights.",
          "cost": '20',
          "image_url": "https://images.unsplash.com/photo-1591608971362-f08b2a75731a",
          "category": "attraction"
        },
        {
          "id": "item_004",
          "time": "07:00 PM",
          "title": "Nile Sunset Cruise",
          "description": "Relax on a boat ride along the Nile with sunset views and dinner.",
          "cost": '15',
          "image_url": "https://images.unsplash.com/photo-1548013146-72479768bada",
          "category": "experience"
        }
      ]
    }
  ]
};
}
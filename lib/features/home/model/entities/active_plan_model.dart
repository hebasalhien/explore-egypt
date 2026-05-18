class ActivePlanModel {
  final String planName;
  final int theCurrentDay;
  final int planDays;
  final String nextDestination;

  ActivePlanModel({required this.planName, required this.theCurrentDay, required this.planDays, required this.nextDestination});

 factory ActivePlanModel.fromMap(Map<String, dynamic> json) {
    return ActivePlanModel(
      planName: json['active_plan']['planName'],
      theCurrentDay: json['active_plan']['theCurrentDay'],
      planDays: json['active_plan']['planDays'],
      nextDestination: json['active_plan']['nextDestination'],
    );
 }

  
}

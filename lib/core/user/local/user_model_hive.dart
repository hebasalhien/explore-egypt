import 'package:hive/hive.dart';

part 'user_model_hive.g.dart';

@HiveType(typeId: 0)
class UserModelHive extends HiveObject {
  @HiveField(0)
  late String username;

  @HiveField(1)
  late String imageUrl;
}
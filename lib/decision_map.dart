import 'package:hive/hive.dart';

part 'decision_map.g.dart';

@HiveType(typeId: 0)
class DecisionMap{

  @HiveField(0)
  late int currentID;

  @HiveField(1)
  late int option1ID;

  @HiveField(2)
  late int option2ID;

  @HiveField(3)
  late String description;

  @HiveField(4)
  late String option1Text;

  @HiveField(5)
  late String option2Text;


}
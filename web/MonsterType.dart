library MONSTERTYPE;

import 'Enum.dart';

class MonsterType<String> extends Enum<String>
{
  const MonsterType(String val) : super(val);
  
  static const MonsterType GOBLIN = const MonsterType("GOBLIN");
  static const MonsterType LIZARD = const MonsterType("LIZARD");
}
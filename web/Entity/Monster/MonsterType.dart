library MONSTERTYPE;

import '../../Items/Enum.dart';

class MonsterType<String> extends Enum<String, String>
{
  const MonsterType(String val, String name) : super(val, name);
  
  static const MonsterType GOBLIN = const MonsterType("G", "goblin");
  static const MonsterType LIZARD = const MonsterType("L", "lizard");
  static const MonsterType KEYHOLDER = const MonsterType("G", "keyholder");
}
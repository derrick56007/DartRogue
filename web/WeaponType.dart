library WEAPONTYPE;

import 'Enum.dart';

class WeaponType<String> extends Enum<String, String>
{
  final int atk;
  const WeaponType(String val, String name, this.atk) : super(val, name);
  
  static const WeaponType NONE = const WeaponType("W", "no weapon", 0);
  static const WeaponType IRONDAGGER = const WeaponType("W", "iron dagger", 1);
}
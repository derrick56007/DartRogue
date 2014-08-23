library PLAYERTYPE;

import 'Enum.dart';

class PlayerType<String> extends Enum<String, String>
{
  const PlayerType(String val, String name) : super(val, name);
  
  static const PlayerType GENERIC = const PlayerType("P", "generic player");
}
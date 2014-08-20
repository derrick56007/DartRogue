library PLAYERTYPE;

import 'Enum.dart';

class PlayerType<String> extends Enum<String>
{
  const PlayerType(String val) : super(val);
  
  static const PlayerType GENERIC = const PlayerType("GENERIC");
}
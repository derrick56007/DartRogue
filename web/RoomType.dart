library ROOMTYPE;

import 'Enum.dart';

final List roomChance = [[40, RoomType.NORMAL], [25, RoomType.SPIKEROOM], [25, RoomType.MONSTERROOM], [10, RoomType.TREASUREROOM]];

class RoomType<String> extends Enum<String>
{
  const RoomType(String val) : super(val);
  
  static const RoomType STARTROOM = const RoomType("STARTROOM");
  static const RoomType NORMAL = const RoomType("NORMAL");
  static const RoomType SPIKEROOM = const RoomType("SPIKEROOM");
  static const RoomType MONSTERROOM = const RoomType("MONSTORROOM");
  static const RoomType TREASUREROOM = const RoomType("TREASUREROOM");
}
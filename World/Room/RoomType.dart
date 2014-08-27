library ROOMTYPE;

import '../../Items/Enum.dart';

class RoomType<String> extends Enum<String, String>
{
  const RoomType(String val, String name) : super(val, name);
  
  static const RoomType STARTROOM = const RoomType("STARTROOM", "start room");
  static const RoomType NORMAL = const RoomType("NORMAL", "normal room");
  static const RoomType SPIKEROOM = const RoomType("SPIKEROOM", "spike room");
  static const RoomType MONSTERROOM = const RoomType("MONSTORROOM", "monster room");
  static const RoomType TREASUREROOM = const RoomType("TREASUREROOM", " treasure room");
}
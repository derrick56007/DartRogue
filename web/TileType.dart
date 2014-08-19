library TILETYPE;

import 'Enum.dart';

class TileType<String> extends Enum<String>
{
  const TileType(String val) : super(val);
  
  static const TileType GROUND = const TileType("GROUND");
  static const TileType WALL = const TileType("WALL");
  static const TileType STONE = const TileType("STONE");
}
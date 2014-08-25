library TILETYPE;

import '../../Items/Enum.dart';

class TileType<String> extends Enum<String, String>
{
  const TileType(String val, String name) : super(val, name);
  
  static const TileType GROUND = const TileType(".", "ground");
  static const TileType WALL = const TileType("□", "wall");
  static const TileType STONE = const TileType("8", "stone");
  static const TileType SPIKE = const TileType("^", "spike");
  static const TileType BONES = const TileType("%", "bones");
}
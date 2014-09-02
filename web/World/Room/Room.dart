library ROOM;

import 'RoomType.dart';
import '../TileObject/TileType.dart';
import '../../Game/Game.dart';
import '../../Entity/Monster/MonsterType.dart';
import '../../Entity/Player/PlayerType.dart';
import '../../Items/Enum.dart';
import '../../Items/Item/ItemType.dart';
import '../../ChooseRandom/ChooseRandom.dart';

class Room
{
  RoomType roomType;
  int width;
  int height;
  int minX;
  int minY;
  int maxX;
  int maxY;
  int midX;
  int midY;
  List<List<Enum>> contents = [];
  toString() => "$roomType";
  
  Room(this.minX, this.minY, int width, int height, RoomType roomType)
  {
    this.maxX = this.minX + width - 1;
    this.maxY = this.minY + height - 1;
    this.width = this.maxX - this.minX + 1;
    this.height = this.maxY - this.minY + 1;
    this.midX = this.minX + this.width ~/ 2;
    this.midY = this.minY + this.height ~/ 2;
    this.roomType = roomType;
    
    this.clearRoom();
    this.addContents();
  }
  
  bool intersects(Room room)
  {
    return this.maxX+1 >= room.minX && this.minX-1 <= room.maxX && this.maxY+1 >= room.minY && this.minY-1 <= room.maxY;   
  }
  
  void clearRoom()
  {
    var row = [];
       
    for(int y = 0, height = this.height; y < height; y++)
    {
      row = [];
      for(int x = 0, width = this.width; x < width; x++)
      {
        row.add(TileType.GROUND);
      }      
      this.contents.add(row);
    }
  }
  
  void addContents()
  {
    switch(roomType)
    {
      case RoomType.STARTROOM:
        int x = RNG.nextInt(this.width);
        int y = RNG.nextInt(this.height);
        contents[y][x] = PlayerType.GENERIC;
        break;
      case RoomType.MONSTERROOM:
        for(int i = 0; i < RNG.nextInt(3) + this.width ~/ 3; i++)
        {
          int x = RNG.nextInt(this.width);
          int y = RNG.nextInt(this.height);
          contents[y][x] = monsterList.pick();
        }
        break;
      case RoomType.TREASUREROOM:
        int x = RNG.nextInt(this.width);
        int y = RNG.nextInt(this.height);
        contents[y][x] = ItemType.TREASURECHEST;
        break;
      case RoomType.SPIKEROOM:
        for(int i = 0; i < RNG.nextInt(3) + this.width ~/ 3; i++)
        {
          int x = RNG.nextInt(this.width);
          int y = RNG.nextInt(this.height);
          contents[y][x] = TileType.SPIKE;
        }
        break;
      default:
        break;
    }
  }
}

final ChooseRandom monsterList = new ChooseRandom(loopList : [[80, MonsterType.GOBLIN], [20, MonsterType.LIZARD]]);
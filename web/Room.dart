library ROOM;

import 'RoomType.dart';
import 'TileType.dart';
import 'Game.dart';
import 'MonsterType.dart';
import 'PlayerType.dart';
import 'Enum.dart';
import 'ItemType.dart';

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
  
  bool Intersects(Room room)
  {
    return this.maxX >= room.minX && this.minX <= room.maxX && this.maxY >= room.minY && this.minY <= room.maxY;   
  }
  
  void clearRoom()
  {
    var row = [];
       
    for(int y = 0, height = this.height; y < height - 2; y++)
    {
      row = [];
      for(int x = 0, width = this.width; x < width - 2; x++)
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
        int x = RNG.nextInt(this.width - 2);
        int y = RNG.nextInt(this.height - 2);
        contents[y][x] = PlayerType.GENERIC;
        break;
      case RoomType.MONSTERROOM:
        for(int i = 0; i < RNG.nextInt(3) + this.width ~/ 3; i++)
        {
          int x = RNG.nextInt(this.width - 2);
          int y = RNG.nextInt(this.height - 2);
          contents[y][x] = MonsterType.GOBLIN;
        }
        break;
      case RoomType.TREASUREROOM:
        int x = RNG.nextInt(this.width - 2);
        int y = RNG.nextInt(this.height - 2);
        contents[y][x] = ItemType.TREASURECHEST;
        break;
      case RoomType.SPIKEROOM:
        for(int i = 0; i < RNG.nextInt(3) + this.width ~/ 3; i++)
        {
          int x = RNG.nextInt(this.width - 2);
          int y = RNG.nextInt(this.height - 2);
          contents[y][x] = TileType.SPIKE;
        }
        break;
      default:
        break;
    }
  }
}
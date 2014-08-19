library ROOM;

import 'RoomType.dart';
import 'TileObject.dart';
import 'TileType.dart';

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
  List<List<TileObject>> contents = [];
  
  Room(this.minX, this.minY, int width, int height, RoomType roomType)
  {
    this.maxX = this.minX + width - 1;
    this.maxY = this.minY + height - 1;
    this.width = this.maxX - this.minX + 1;
    this.height = this.maxY - this.minY + 1;
    this.midX = this.minX + this.width ~/ 2;
    this.midY = this.minY + this.height ~/ 2;
    
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
        row.add(new TileObject(x, y, TileType.GROUND));
      }      
      this.contents.add(row);
    }
  }
  
  void addContents()
  {
    /*switch(roomType)
    {
      case SPIKEY:
        for(int i = 0; i < RNG.nextInt(this.width); i++)
        {
          int x = RNG.nextInt(this.width - 2);
          int y = RNG.nextInt(this.height - 2);
          contents[y][x] = new Tile(this.minX + 1 + x, this.maxY - 1 - y, SPIKES);
        }
        break;
      case MONSTERROOM:
        for(int i = 0; i < RNG.nextInt(3) + this.width ~/ 3; i++)
        {
          int x = RNG.nextInt(this.width - 2);
          int y = RNG.nextInt(this.height - 2);
          contents[y][x] = new Monster(this.minX + 1 + x, this.maxY - 1 - y, 1, 0, 5);
        }
        break;
      case TREASUREROOM:
        int x = RNG.nextInt(this.width - 2);
        int y = RNG.nextInt(this.height - 2);
        contents[y][x] = new Item(x, y);
        break;
      default:
        break;
    }*/
  }
}
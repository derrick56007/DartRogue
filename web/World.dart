library WORLD;

import 'TileObject.dart';
import 'TileType.dart';
import 'RoomType.dart';
import 'Room.dart';
import 'Player.dart';
import 'Game.dart';

class World
{
  List<List<TileObject>> grid = [];
  int width;
  int height;
  List<Room> rooms = [];
  Player player;
  
  World(this.width, this.height)
  {
    clearGrid();
    generateContent();
  }
  
  void generateContent()
  {
    int roomWidth = getPosOrNeg(10, 4);
    int roomHeight = getPosOrNeg(10 , 4);
    print(roomWidth);
    int x = this.width - roomWidth - RNG.nextInt(width - roomWidth);
    int y = this.height - roomHeight  - RNG.nextInt(height - roomHeight);
    
    //Room room = new Room(x, y, roomWidth, roomHeight, RoomType.STARTROOM);
    //rooms.add(room);
    
    generateRooms(getPosOrNeg(16, 5));
    setRooms();
    //digCorridors();
    //setRoomContents();
    //placePlayer();
    //refreshPlayerStats(player);
    //if (!allVisible) checkTileVisibility();
  }
  
  void movePlayer(e) //TODO movePlayer()
  {
    
  }
  
  void clearGrid() //TODO clearGrid()
  {
    var row = [];
       
    for(int y = 0, height = this.height; y < height; y++)
    {
      row = [];
      for(int x = 0, width = this.width; x < width; x++)
      {
        if(allVisible)
        {
          row.add(new TileObject(x, y, TileType.STONE));
        }
        else
        {
          row.add(new TileObject(x, y, TileType.WALL));
        }
      }      
      grid.add(row);
    }
  }
  
  void generateRooms(int numOfRooms) //TODO generateRooms()
  {
    for(int i = 0; i < numOfRooms; i++)
    {
      String roomSize = getRandomWeighted([[80, "small"], [20, "large"]]);
      int roomWidth;
      int roomHeight;
      if(roomSize == "small")
      {
        roomWidth = getPosOrNeg(10, 4);
        roomHeight = getPosOrNeg(10 , 4);
      }
      else
      {
        roomWidth = RNG.nextInt(10) + 14;
        roomHeight = RNG.nextInt(10) + 14;
      }
      
      int x = this.width - roomWidth - RNG.nextInt(width - roomWidth);
      int y = this.height - roomHeight  - RNG.nextInt(height - roomHeight);
      Room room = new Room(x, y, roomWidth, roomHeight, getRandomWeighted(roomChance)); //TODO
      bool intersects = false;
      for(int j = 0, length = rooms.length; j < length; j++)
      {
        if(room.Intersects(rooms[j]))
        {
          intersects = true;
          break;
        }
      }
      if(!intersects)
      {
        this.rooms.add(room);
      }
      else
      {
        i--;
      }
    }
  }
  
  void setRooms() //TODO setRooms()
  {
    for(int i = 0; i < rooms.length; i++) //number of rooms to iterate through
    {
      Room room = rooms[i];
      for(int j = 0; j < room.height; j++) // height of the room
      {
        if(j == 0) // do for top wall
        {
          for(int k = 0; k < room.width; k++)
          {
            setAtCoordinate(room.minX + k, room.minY, TileType.WALL);
            //grid[room.minY][room.minX + k] = new TileObject(room.minX + k, room.minY, TileType.WALL);//TOPLEFTCORNER);
          }
        }
        else if(j == room.height - 1) // do for bottom wall
        {
          for(int k = 0; k < room.width; k++)
          {
            setAtCoordinate(room.minX + k, room.maxY, TileType.WALL);
            //grid[room.maxY][room.minX + k] = new TileObject(room.minX + k, room.maxY, TileType.WALL);//BOTLEFTCORNER);
          }
        }
        else //do for side walls
        {
          for(int k = 0; k < room.width; k++)
          {
            if(k == 0)
            {
              setAtCoordinate(room.minX, room.minY + j, TileType.WALL);
              //grid[room.minY + j][room.minX] = new TileObject(room.minX, room.minY + j, TileType.WALL);//LEFTVERWALL);
            }
            else if(k == room.width - 1)
            {
              setAtCoordinate(room.maxX, room.minY + j, TileType.WALL);
              //grid[room.minY + j][room.maxX] = new TileObject(room.maxX, room.minY + j, TileType.WALL);//RIGHTVERWALL);
            }
            else
            {
              setAtCoordinate(room.minX + k, room.minY + j, TileType.WALL);
              //grid[room.minY + j][room.minX + k] = new TileObject(room.minX + k, room.minY + j, TileType.GROUND);
            }
          }
        }
      }
    }
  }
  
  void setAtCoordinate(int x, int y, TileType tileType)
  {
    grid[y][x] = new TileObject(x, y, tileType);
  }
}
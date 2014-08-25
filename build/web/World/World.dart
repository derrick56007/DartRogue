library WORLD;

import 'TileObject/TileObject.dart';
import 'TileObject/TileType.dart';
import 'Room/RoomType.dart';
import 'Room/Room.dart';
import '../Entity/Player/Player.dart';
import '../Game.dart';
import '../Entity/Monster/MonsterType.dart';
import '../Entity/Monster/Monster.dart';
import 'dart:math';
import '../Items/Enum.dart';
import '../Entity/Player/PlayerType.dart';
import '../Entity/Pathfinding/grid.dart';
import '../Entity/Pathfinding/astar.dart';
import '../Items/Item/ItemType.dart';
import '../Items/Weapon/WeaponType.dart';
import '../Items/Armor/ArmorType.dart';
import '../Items/Item/Item.dart';
import '../Items/Item/Chest.dart';
import '../Items/Armor/Armor.dart';
import '../Items/Weapon/Weapon.dart';

class World
{
  Grid grid;
  int width;
  int height;
  List<Room> rooms = [];
  List<Monster> monsters = [];
  Player player;
  
  World(this.width, this.height)
  {
    this.grid = new Grid(this.width, this.height);
    clearGrid();
    generateContent();
  }
  
  void generateContent()
  {
    generateRooms(getPosOrNeg(16, 5));
    setRooms();
    loopDigCorridors();
    setRoomContents();
    refreshStats(player);
    loopTiles();
  }
  
  void timeStep()
  {
    timeStepMonsters();
    loopTiles();
    refreshStats(player);
  }
  
  void timeStepMonsters()
  {
    //
    var astar = new AStarFinder();
    for(int i = 0, length = monsters.length; i < length; i++)
    {
      var monster = monsters[i];
      if(monster.followingCountdown > 0)
      { 
        monster.pathToPlayer = astar.findPath(monster.x, monster.y, this.player.x, this.player.y, grid.clone());
      }
    }
    
    monsters.sort((a,b) => a.pathToPlayer.length.compareTo(b.pathToPlayer.length));
    for(int i = 0; i < monsters.length; i++)
    {
      monsters[i].timeStep();
    }
  }
  
  void loopTiles()
  {
    if(!allVisible)
    {
      for(int i = 0; i < this.height; i++)
      {
        for(int j = 0; j < this.width; j++)
        {
          grid.nodes[i][j].isVisible = false;
        }
      }
    }
    
    for(int i = 0; i < this.height; i++)
    {
      for(int j = 0; j < this.width; j++)
      {
        lineOfSight(player.tileObject.x, player.tileObject.y, j, i);
      }
    }
  }
  
  void lineOfSight(int x,int y,int x2, int y2)
  {
      int w = x2 - x ;
      int h = y2 - y ;
      int dx1 = 0, dy1 = 0, dx2 = 0, dy2 = 0 ;
      
      if (w<0) dx1 = -1 ; else if (w>0) dx1 = 1 ;
      if (h<0) dy1 = -1 ; else if (h>0) dy1 = 1 ;
      if (w<0) dx2 = -1 ; else if (w>0) dx2 = 1 ;
      int longest = w.abs();
      int shortest = h.abs();
      if (!(longest > shortest))
      {
          longest = h.abs() ;
          shortest = w.abs() ;
          if (h<0) dy2 = -1 ; else if (h>0) dy2 = 1 ;
          dx2 = 0 ;            
      }
      
      int numerator = longest >> 1 ;
      for (int i=0;i<=longest;i++) 
      {
        var tileObject = grid.nodes[y][x];
        tileObject.isVisible = true;
        
        if(tileObject is Monster)
        {
          Monster monster = tileObject;
          if(monster.followingCountdown < monster.COUNTMAX)
          {
            monster.followCountSetMax();
          }
        }
        
        if (!grid.nodes[y][x].isOpaque) break;
        
        numerator += shortest ;
        if (!(numerator < longest)) 
        {
            numerator -= longest ;
            x += dx1;
            y += dy1;
        }
        else 
        {
            x += dx2;
            y += dy2;
        }
      }
  }
  
  void clearGrid()
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
      grid.nodes.add(row);
    }
  }
  
  void generateRooms(int numOfRooms)
  {
    List<RoomType> defaultRooms = [RoomType.STARTROOM, RoomType.TREASUREROOM]; 
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
      Room room;
      if(i < defaultRooms.length)
      {
        room = new Room(x, y, roomWidth, roomHeight, defaultRooms[i]);
      }
      else
      {
        room = new Room(x, y, roomWidth, roomHeight, getRandomWeighted(roomChance));
      }
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
  
  void setRooms()
  {
    for(int i = 0, length = rooms.length; i < length; i++) //number of rooms to iterate through
    {
      Room room = rooms[i];
      int height = room.height;
      int width = room.width;
      for(int j = 0; j < height; j++) // height of the room
      {
        if(j == 0) // do for top wall
        {
          for(int k = 0; k < width; k++)
          {
            setAtCoordinate(room.minX + k, room.minY, TileType.WALL);
          }
        }
        else if(j == height - 1) // do for bottom wall
        {
          for(int k = 0; k < width; k++)
          {
            setAtCoordinate(room.minX + k, room.maxY, TileType.WALL);
          }
        }
        else //do for side walls
        {
          for(int k = 0; k < width; k++)
          {
            if(k == 0)
            {
              setAtCoordinate(room.minX, room.minY + j, TileType.WALL);
            }
            else if(k == width - 1)
            {
              setAtCoordinate(room.maxX, room.minY + j, TileType.WALL);
            }
          }
        }
      }
    }
  }
  
  void setRoomContents()
  {
    for(int i = 0, length = rooms.length; i < length; i++) //number of rooms to iterate through
    {
      Room room = rooms[i];
      for(int j = 0, height = room.contents.length; j < height; j++) // height of the room
      {
        for(int k = 0, width = room.contents[0].length; k < width; k++)
        {
          Enum object = room.contents[j][k];
          setAtCoordinate( room.minX + 1 + k, room.minY + 1 + j, object);
        }
      }
    }
  }
  
  void loopDigCorridors()
  {
    for(int i = 1, length = rooms.length; i < length; i++)
    {
      Room oldRoom = rooms[i - 1];
      Room newRoom = rooms[i];

      digCorridor(oldRoom.midX, newRoom.midX, oldRoom.midY, 1); //hor
      digCorridor(oldRoom.midY, newRoom.midY, newRoom.midX, 0 ); //ver
    }
  }
  
  void digCorridor(int pos1, int pos2, int constantPos, int dir)
  {
    for(int i = min(pos1, pos2), maxPos = max(pos1, pos2); i < maxPos + 1 + dir; i++)
    {
      if(dir == 1)
      {
        setAtCoordinate(i, constantPos + 1, TileType.GROUND);
        setAtCoordinate(i, constantPos, TileType.GROUND);
      }
      else
      {
        setAtCoordinate(constantPos + 1, i, TileType.GROUND);
        setAtCoordinate(constantPos, i, TileType.GROUND);
      }
    }
  }
  
  void setAtCoordinate(int x, int y, Enum type)
  {
    if(type is TileType)
    {
      grid.nodes[y][x] = new TileObject(x, y, type);
    }
    else if(type is MonsterType)
    {
      grid.nodes[y][x] = new Monster(x, y, type);
      monsters.add(grid.nodes[y][x]);
    }
    else if(type is PlayerType)
    {
      grid.nodes[y][x] = new Player(x, y, type);
      player = grid.nodes[y][x];
    }
    else if(type == ItemType.TREASURECHEST)
    {
      grid.nodes[y][x] = new Chest(x, y);
    }
    else if(type is WeaponType)
    {
      grid.nodes[y][x] = new Weapon(x, y, type);
    }
    else if(type is ArmorType)
    {
      grid.nodes[y][x] = new Armor(x, y, type);
    }
    else if(type is ItemType)
    {
      grid.nodes[y][x] = new Item(x, y, type);
    }
  }
}
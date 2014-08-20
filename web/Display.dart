library DISPLAY;

import 'dart:html';
import 'Game.dart';
import 'TileObject.dart';

class Display
{
  final Map charSet = getCharSet();
  final Element display = querySelector("#display");
  
  void displayWorld()
  {
    display.children.clear();
    for(int i = 0, length = world.grid.length; i < length; i++)
    {
      String lineText = "";
      for(int j = 0, length2 = world.grid[i].length; j < length2; j++)
      {
        lineText = lineText + getChar(world.grid[i][j]);
      }
      Element line = new Element.div();
      line.text = lineText;
      line.className = "worldLine";
      display.children.add(line);
    }
  }
  
  String getChar(TileObject tile)
  {
    if(!tile.isVisible)
    {
      return charSet['SHADOW'];
    }
    else
    {
      return charSet[tile.toString()];
    }
  }
  
  static Map getCharSet()
  {
    return 
    {
      'SHADOW' : "●",
      'WALL' : "□",
      'STONE' : "8",
      'GROUND' : ".",
      'GENERIC' : "@",
      'UNKNOWN' : "X",
      'SPIKES' : "^",
      'BONES' : "%",
    };
  }
}
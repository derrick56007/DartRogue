library INPUT;

import 'dart:html';
import 'Game.dart';

class Input
{
  Input()
  {
    window.onKeyDown.listen((KeyboardEvent e){ keyPressed(e.keyCode);});
  }

  void keyPressed (int e)
  {
    //print(new DateTime.now());
    if(e == KeyCode.SEVEN || e == KeyCode.EIGHT || e == KeyCode.NINE || e == KeyCode.SIX || e == KeyCode.THREE || e == KeyCode.TWO || e == KeyCode.ONE || e == KeyCode.FOUR || e == KeyCode.Q || e == KeyCode.W || e == KeyCode.E || e == KeyCode.D || e == KeyCode.C || e == KeyCode.X || e == KeyCode.Z || e == KeyCode.A || e == KeyCode.S)
    {
      int moveY = 0;
      int moveX = 0;
      switch (e)
      {
        case KeyCode.EIGHT: //UP
          moveY = -1;
          break;
        case KeyCode.W:
          moveY = -1;
          break;
          
        case KeyCode.TWO: //DOWN
          moveY = 1;
          break;
        case KeyCode.X:
          moveY = 1;
          break;
          
        case KeyCode.FOUR: //LEFT
          moveX = -1;
          break;
        case KeyCode.A:
          moveX = -1;
          break;
          
        case KeyCode.SIX: //RIGHT
          moveX = 1;
          break;
        case KeyCode.D:
          moveX = 1;
          break;
          
        ////////////////////////
          
        case KeyCode.SEVEN: //UP LEFT
          moveY = -1;
          moveX = -1;
          break;
        case KeyCode.Q:
          moveY = -1;
          moveX = -1;
          break;
          
        case KeyCode.NINE: //UP RIGHT
          moveY = -1;
          moveX = 1;
          break;
        case KeyCode.E:
          moveY = -1;
          moveX = 1;
          break;
          
        case KeyCode.THREE: //DOWN RIGHT
          moveY = 1;
          moveX = 1;
          break;
        case KeyCode.C:
          moveY = 1;
          moveX = 1;
          break;
          
        case KeyCode.ONE: //DOWN LEFT
          moveY = 1;
          moveX = -1;
          break;
        case KeyCode.Z:
          moveY = 1;
          moveX = -1;
          break;
          
        default:
          break;
      }
      world.player.movePlayer(moveX, moveY);
      display.displayWorld();
      //print(new DateTime.now());
    }
  }
}
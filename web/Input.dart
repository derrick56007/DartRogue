library INPUT;

import 'dart:html';
import 'Game.dart';
import 'dart:async';

class Input
{
  List<int> keys = [];
  Timer timer;
  
  Input()
  {
    window.onKeyDown.listen((KeyboardEvent e)
    { 
      if(validKey(e.keyCode))
      {
        keyDownHandler(e.keyCode);
      }
    });
    window.onKeyUp.listen((KeyboardEvent e)
    { 
      if(validKey(e.keyCode))
      {
        keyUpHandler(e.keyCode);
      }
    });
    window.onMouseDown.listen((MouseEvent e)
    { 
      keys.clear();
      if(timer != null) timer.cancel();
    });
  }
  
  bool validKey(int e)
  {
    if(e == KeyCode.NUM_SEVEN || e == KeyCode.NUM_EIGHT || e == KeyCode.NUM_NINE || e == KeyCode.NUM_SIX || e == KeyCode.NUM_THREE || e == KeyCode.NUM_TWO || e == KeyCode.NUM_ONE || e == KeyCode.NUM_FOUR || e == KeyCode.NUM_FIVE|| e == KeyCode.Q || e == KeyCode.W || e == KeyCode.E || e == KeyCode.D || e == KeyCode.C || e == KeyCode.X || e == KeyCode.Z || e == KeyCode.A || e == KeyCode.S)
    {
      return true;
    }
    return false;
  }
  
  void keyUpHandler(int e)
  {
    if(keys.contains(e))
    {
      keys.remove(e);
      if(timer != null) timer.cancel();
      if(keys.length > 0) timer = new Timer.periodic(const Duration(milliseconds: 100), (d){keyPressed(keys.last);});
    }
  }
  
  void keyDownHandler(int e)
  {
    if(!keys.contains(e))
    {
      keyPressed(e);
      keys.add(e);
      if(timer != null) timer.cancel();
      timer = new Timer.periodic(const Duration(milliseconds: 100), (d){keyPressed(e);});
    }
  }

  void keyPressed (int e)
  {
    //print(new DateTime.now());

    int moveY = 0;
    int moveX = 0;
    switch (e)
    {
      case KeyCode.NUM_EIGHT: //UP
        moveY = -1;
        break;
      case KeyCode.W:
        moveY = -1;
        break;
        
      case KeyCode.NUM_TWO: //DOWN
        moveY = 1;
        break;
      case KeyCode.X:
        moveY = 1;
        break;
        
      case KeyCode.NUM_FOUR: //LEFT
        moveX = -1;
        break;
      case KeyCode.A:
        moveX = -1;
        break;
        
      case KeyCode.NUM_SIX: //RIGHT
        moveX = 1;
        break;
      case KeyCode.D:
        moveX = 1;
        break;
        
      ////////////////////////
        
      case KeyCode.NUM_SEVEN: //UP LEFT
        moveY = -1;
        moveX = -1;
        break;
      case KeyCode.Q:
        moveY = -1;
        moveX = -1;
        break;
        
      case KeyCode.NUM_NINE: //UP RIGHT
        moveY = -1;
        moveX = 1;
        break;
      case KeyCode.E:
        moveY = -1;
        moveX = 1;
        break;
        
      case KeyCode.NUM_THREE: //DOWN RIGHT
        moveY = 1;
        moveX = 1;
        break;
      case KeyCode.C:
        moveY = 1;
        moveX = 1;
        break;
        
      case KeyCode.NUM_ONE: //DOWN LEFT
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
    world.player.movePlayer(new Point(moveX, moveY));
    display.displayWorld();
    //print(new DateTime.now());
  }
  
  /*void delay()
  {
    var future = new Future.delayed(const Duration(milliseconds: 1000));
    var subscription = future.asStream().listen((e){print("derp");});
// ...
    //subscription.cancel();
  }*/
}
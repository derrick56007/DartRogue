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
    if(e == KeyCode.UP || e == KeyCode.DOWN || e == KeyCode.LEFT || e == KeyCode.RIGHT)
    {
      world.movePlayer(e);
      display.displayWorld();
    }
  }
}
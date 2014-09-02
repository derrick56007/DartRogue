library INPUT;

import 'dart:html';
import '../Game.dart';
import 'dart:async';

/*
 * Handles keyboard input
 */

class Input
{
  // The keys that are currently held down
  List<int> keys = [];

  // The frequency at which keyPressed() is called
  static const int GAMESTEP_FREQUENCY = 100;

  // Calls the keyPressed() at
  Timer timer;

  // Specifies if keys are usable right now
  bool enabled = true;

  /*
   * Specifies to listen to events:
   *
   * onKeyDown
   * onKeyUp
   * onMouseDown
   *
   */
  Input()
  {
    /*
     * Adds the keycode from onKeyDown event to front of the queue
     */
    window.onKeyDown.listen((KeyboardEvent e)
    {
      if(validKey(e.keyCode))
      {
        keyDownHandler(e.keyCode);
      }
    });

    /*
     * Removes the keycode from the onKeyUp event from queue
     */
    window.onKeyUp.listen((KeyboardEvent e)
    {
      if(validKey(e.keyCode))
      {
        keyUpHandler(e.keyCode);
      }
    });

    /*
     * Removes all keycodes from queue on a onMouseDown event
     *
     * prevents hanging of the current key
     */
    window.onMouseDown.listen((MouseEvent e)
    {
      keys.clear();
      if(timer != null) timer.cancel();
    });
  }

  /*
   * Determines whether or not it is a valid keycode in the game
   *
   * @param int e : keycode to check
   *
   * return: true if the game requires this key
   *
   */
  bool validKey(int e)
  {
    if(e == KeyCode.NUM_SEVEN || e == KeyCode.NUM_EIGHT || e == KeyCode.NUM_NINE || e == KeyCode.NUM_SIX || e == KeyCode.NUM_THREE || e == KeyCode.NUM_TWO || e == KeyCode.NUM_ONE || e == KeyCode.NUM_FOUR || e == KeyCode.NUM_FIVE|| e == KeyCode.Q || e == KeyCode.W || e == KeyCode.E || e == KeyCode.D || e == KeyCode.C || e == KeyCode.X || e == KeyCode.Z || e == KeyCode.A || e == KeyCode.S)
    {
      return true;
    }
    return false;
  }

  /*
   * Removes the keycode from the onKeyUp event from the queue if it exists
   *
   * Cancels the timer to stop the calling of the current key
   *
   * Initializes a new timer to call the key at the top of the queue
   *
   * @param int e : keycode to handle
   */
  void keyUpHandler(int e)
  {
    if(keys.contains(e))
    {
      keys.remove(e);
      if(timer != null) timer.cancel();
      if(keys.length > 0) timer = new Timer.periodic(const Duration(milliseconds: GAMESTEP_FREQUENCY), (d)
      {
        keyPressed(keys.last);
      });
    }
  }

  /*
   * Adds the keycode from the onKeyDown event to the top of the queue if not already in queue
   *
   * Calls keyPressed( keycode) to simulate onKeyDown event
   *
   * Cancels the timer to stop the calling of the current key
   *
   * Initializes a new timer with the new keycode
   *
   *
   * @param int e : keycode to handle
   */
  void keyDownHandler(int e)
  {
    if(!keys.contains(e))
    {
      keyPressed(e);
      keys.add(e);
      if(timer != null) timer.cancel();
      timer = new Timer.periodic(const Duration(milliseconds: 100), (d)
      {
        keyPressed(e);
      });
    }
  }

  /*
   * Determines the direction of the keys
   *
   * Uses
   *      QWE
   *      ASD
   *      ZXC
   *
   * and
   *      789
   *      456
   *      123
   *
   * Calls the movePlayer() with moveX and moveY as parameters
   *
   * Displays to the screen
   *
   * @param int e : key to check direction
   */
  void keyPressed (int e)
  {
    if(!this.enabled)
      return;

    int moveY = 0;
    int moveX = 0;

    switch (e)
    {
      case KeyCode.NUM_EIGHT:    // UP
        moveY = -1;
        break;

      case KeyCode.W:            // UP
        moveY = -1;
        break;

      case KeyCode.NUM_TWO:      // DOWN
        moveY = 1;
        break;

      case KeyCode.X:            // DOWN
        moveY = 1;
        break;

      case KeyCode.NUM_FOUR:     // LEFT
        moveX = -1;
        break;

      case KeyCode.A:            // LEFT
        moveX = -1;
        break;

      case KeyCode.NUM_SIX:      // RIGHT
        moveX = 1;
        break;

      case KeyCode.D:            // RIGHT
        moveX = 1;
        break;

      case KeyCode.NUM_SEVEN:    // UP LEFT
        moveY = -1;
        moveX = -1;
        break;

      case KeyCode.Q:            // UP LEFT
        moveY = -1;
        moveX = -1;
        break;

      case KeyCode.NUM_NINE:     // UP RIGHT
        moveY = -1;
        moveX = 1;
        break;

      case KeyCode.E:            // UP RIGHT
        moveY = -1;
        moveX = 1;
        break;

      case KeyCode.NUM_THREE:    // DOWN RIGHT
        moveY = 1;
        moveX = 1;
        break;

      case KeyCode.C:            // DOWN RIGHT
        moveY = 1;
        moveX = 1;
        break;

      case KeyCode.NUM_ONE:      // DOWN LEFT
        moveY = 1;
        moveX = -1;
        break;

      case KeyCode.Z:            // DOWN LEFT
        moveY = 1;
        moveX = -1;
        break;

      default:
        break;
    }

    world.player.movePlayer(new Point(moveX, moveY));
    display.displayWorld();
  }
}
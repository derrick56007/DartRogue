library GAME;

import '../World/World.dart';
import 'Visual/Display.dart';
import 'Input/Input.dart';
import 'dart:math';
import 'dart:html' hide Player;

World world;
Display display;
Input input;
bool shadowsOn = true;
Random RNG;
int difficulty = 0;

/*
 * Sets the random number generator
 *
 */
class Game
{
  int seed;
  int randMax = pow(2, 32);

  Game()
  {
    if (window.location.href.contains("?"))
    {
      try
      {
        seed = int.parse(window.location.href.split("?")[1]);
      }
      on FormatException
      {
        seed = new Random().nextInt(randMax);
      }
    }
    else
    {
      seed = new Random().nextInt(randMax);
    }

    print("Seed: " + "$seed");
    RNG = new Random(seed);
    input = new Input();
    display = new Display();
    world = new World(100, 50);
  }
}

int getPosOrNeg(int number, int range)
{
  return number + (RNG.nextBool() ? -RNG.nextInt(range) : RNG.nextInt(range));
}
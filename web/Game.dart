library GAME;

import 'World.dart';
import 'Display.dart';
import 'Input.dart';
import 'dart:math';
import 'dart:html';

World world;
Display display;
Input input;
bool allVisible = true;
Random RNG;

class Game 
{
  int seed;
  int randMax = 1 << 32;
  
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
    world = new World(100, 50);
    display = new Display();
    input = new Input();
  }
}

dynamic getRandomWeighted(List chanceList)
{
  int rndNum = RNG.nextInt(100) + 1;
  
  int chanceAdd = 0;
  for(int i = 0; i < chanceList.length; i++)
  {
    chanceAdd = chanceAdd + chanceList[i][0];
    
    if(rndNum <= chanceAdd)
    {
      return chanceList[i][1];
    }
  }
  
  return -69;
}

int getPosOrNeg(int number, int range)
{
  return number + (RNG.nextBool() ? -RNG.nextInt(range) : RNG.nextInt(range));
}
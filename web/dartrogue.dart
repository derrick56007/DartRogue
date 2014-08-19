import 'Game.dart';
import 'TileObject.dart';
import 'Entity.dart';
import 'TileType.dart';
import 'MonsterType.dart';
import 'Display.dart';

Game game;

void main() 
{
  startGame();
}

startGame()
{
  game = new Game();
  display.displayWorld();
}
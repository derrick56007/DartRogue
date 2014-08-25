import 'Game.dart';

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
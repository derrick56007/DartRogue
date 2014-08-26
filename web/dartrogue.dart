import 'Game.dart';
import 'dart:html';

Game game;
Element holderElement;
Element displayElement;
Element narrationHolderElement;
Element narrationElement;

void main() 
{
  startGame();
}

startGame()
{
  game = new Game();
  display.displayWorld();
  
  holderElement = querySelector("#holder");
  displayElement = querySelector("#display");
  narrationHolderElement = querySelector("#narrationHolder");
  narrationElement = querySelector("#narration");
  
  holderElement.style.width = "${displayElement.clientWidth + querySelector("#HUD").clientWidth + 20}px";
  narrationHolderElement.style.width = "${holderElement.clientWidth}px";
  narrationElement.style.width = "${displayElement.clientWidth}px";
}
import 'Game/Game.dart';
import 'dart:html';

// Global Game variable
Game game;

// Elements to resize
Element holderElement;
Element displayElement;
Element narrationHolderElement;
Element narrationElement = querySelector("#narration");

void main()
{
  startGame();
}

/*
 * Starts the game variable
 *
 * Resizes the elements to fit eachother
 */
void startGame()
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
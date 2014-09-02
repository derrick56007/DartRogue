library DIALOGBOX;

import 'dart:html';
import '../Game.dart';
import 'dart:async';

class DialogBox
{
  Timer timer;
  Element dialogDiv = new Element.div();
  String currentText = '';
  bool doneReading = true;
  List<String> texts = [];
  static const int READING_FREQUENCY = 35;
  String backgroundColorOriginal;

  DialogBox(this.texts)
  {
    dialogDiv.className = "dialogBox";
    this.backgroundColorOriginal = document.body.style.backgroundColor;
    document.body.style.backgroundColor = "#7c7c7c";
    document.onKeyDown.listen((e)
    {
      if(isValidKey(e.keyCode))
      {
        displayNextLine();
      }
    });

    input.enabled = false;
    document.body.children.add(this.dialogDiv);
    displayNextLine();
  }

  bool isValidKey(int e)
  {
    if(e == KeyCode.ENTER || e == KeyCode.SPACE)
    {
      return true;
    }
    return false;
  }

  void displayNextLine()
  {
    if(this.doneReading)
    {
      if(this.texts.length > 0)
      {
        this.doneReading = false;
        this.currentText = this.texts.first;
        this.texts.removeAt(0);
        startReading();
      }
      else
      {
        removeFromDisplay();
      }
    }
    else
    {
      this.doneReading = true;
      skipReading();
    }
  }

  void startReading()
  {
    this.dialogDiv.text = '';
    timer = new Timer.periodic(const Duration(milliseconds: READING_FREQUENCY), (d)
    {
      if(this.dialogDiv.text.length != this.currentText.length)
      {
        this.dialogDiv.text = this.currentText.substring(0, this.dialogDiv.text.length + 1);
      }
      else
      {
        this.doneReading = true;
        stopTimer();
      }
    });
  }

  void skipReading()
  {
    stopTimer();
    this.dialogDiv.text = currentText;
  }

  void removeFromDisplay()
  {
    stopTimer();
    document.body.children.remove(this.dialogDiv);
    input.enabled = true;
    document.body.style.backgroundColor = this.backgroundColorOriginal;
  }

  void stopTimer()
  {
    if(this.timer != null)
    {
      this.timer.cancel();
    }
  }
}
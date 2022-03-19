
//(H.Foley created a widget class using week 6 widget code, 9:30am 26//03/21)
class Widget {
  int x, y, width, height;
  String label; 
  int event;
  color widgetColor, labelColor;
  PFont widgetFont;
  color strokeColor;
  boolean tick;
  PImage widgetImage;
  boolean changeButtonColour;
  boolean hoveringOver;
  boolean chartClicked;
  //(C.MacMahon and H.Foley added the following variables to account for the help and exit button. 12/4/21 5pm)
  int widthExit=0;
  int widthHeightExit=0;
  Widget exitWidget;

  Widget(int x, int y, int width, int height, String label, color widgetColor, PFont widgetFont, int event) {
    this.x = x; 
    this.y = y; 
    this.width = width; 
    this.height = height;
    this.label=label; 
    this.event=event;
    this.widgetColor=widgetColor; 
    this.widgetFont=widgetFont;
    labelColor = color(0);
    strokeColor = color(0, 0, 0);
  }

  //(O.Idowu created new widget constructor that takes in an image instead of a label, 5pm, 01/04/2021)
  Widget(int x, int y, int width, int height, PImage widgetImage, int event) {
    this.x = x; 
    this.y = y; 
    this.width = width; 
    this.height = height;
    this.label=null; 
    this.event=event;
    this.widgetColor= 0; 
    this.widgetFont=null;
    labelColor = color(0);
    strokeColor = color(0, 0, 0);
    this.widgetImage = widgetImage;
  }
  //(C.MacMahon and H.Foley created a new constructor that takes in the width and height of the exit button that is displayed when the helpButton is pressed. 12/4/21 5pm)
  Widget(int x, int y, int width, int height, String label, color widgetColor, PFont widgetFont, int event, int widthExit, int widthHeightExit)
  {
    this.x = x; 
    this.y = y; 
    this.width = width; 
    this.height = height;
    this.label=label; 
    this.event=event;
    this.widgetColor=widgetColor; 
    this.widgetFont=widgetFont;
    labelColor = color(0);
    strokeColor = color(0, 0, 0);
    exitWidget = new Widget(x+width-widthExit, y, widthExit, widthHeightExit, "X", widgetColor, widgetFont, ESCAPE);
  }

  void draw() {
    if (label != null)
    {
      if (changeButtonColour)
      {
        widgetColor=color(251, 255, 54);
      }
      fill(widgetColor);
      stroke(strokeColor);
      rect(x, y, width, height);
      fill(labelColor);
      textFont(widgetFont);
      text(label, x+10, y+height-10);
      //(D.Madaghjian, checked if event is stateWidget in which I then create box which directs to drop down menu, 10:30am 01/04/2021)
      if (event==STATE_BUTTON_EVENT || event == CHART_BUTTON_EVENT)
      {
        fill(255);
        square(x+(width-20), y+height-30, 20);
        fill(0);
        triangle(x+(width-17), y+(height-27), x+(width-10), y+(height-13), x+(width-3), y+(height-27));
      }
      //(D.Madaghjian, checked if checkbox is ticked in which a tick is then drawn, 10:30am 01/04/2021)
      if (tick)
      {
        stroke(0);
        line(x+(width-17), y+(height-15), x+(width-12), y+(height-5));
        line( x+(width-12), y+(height-5), x+(width-5), y+(height-25));
      }
    } else {
      image( widgetImage, x, y, height, width);
    }
    //(C.MacMahon and H.Foley, if the helpbutton is clicked and the exitbutton is not null then the exitWidget is drawn. 12/4/21 5pm)
    if(exitWidget!=null && drawHelpButton==true)
    {
      exitWidget.draw();
    }
    
  }

  //(H.Foley created getEvent method which will return the final int associated with the event of each button, 9:35am, 26/3/21)
  int getEvent(int mX, int mY) {
    if (mX>x && mX < x+width && mY >y && mY <y+height) {
      return event;
    }
    return EVENT_NULL;
  }
  //(O.Idowu, added setColor & setLabel to set the color and the label of the widget, 10pm 26/03/2021)
  void setColor(color widgetColor)
  {
    this.widgetColor = widgetColor;
  }
  void setLabel(String label)
  {
    this.label=label;
  }
  String getLabel()
  {
    return label;
  }
  //(O.Idowu, added setImage to set the Image of the widget 5pm 01/04/2021)
  void setImage(PImage widgetImage)
  {
    this.widgetImage = widgetImage;
  }
  //O.Idowu, added get methods for the widgets x and y positions 3pm 02/04/2021)
  int getXpos()
  {
    return x;
  }
  int getYpos()
  {
    return y;
  }
  //(H.Foley created hovering method which will change the stroke colour of any button that is hovered over with mouse, 9:35am, 26/3/21)
  void hovering(boolean hovering)
  {
    if (hovering)
    {
      if (event==SEARCH_BUTTON_EVENT)
      {
        strokeColor = color(255, 0, 0);
      } else
      {
        strokeColor = color(255);
      }
    } else 
    {
      strokeColor = color(0);
    }
  }
  //(O.Idowu created set & get Method for boolean HoveringOver to set & get boolean if mouse is hovering over the widget 3pm 02/04/21)
  void setHoveringOver(boolean hoveringOver)
  {
    this.hoveringOver = hoveringOver;
  }
  boolean getHoveringOver()
  {
    return hoveringOver;
  }
  //(C.MacMahon created this method to see if the mouse is over any of the buttons then the button becomes highlighted 03/04/21 5pm)
  void countyHover(int x, int y) {
    if (mouseX>x && mouseX<x+width && mouseY>y&& mouseY<y+height)
    {
      tempHolderForState.widgetColor=color(251, 255, 54);
    } else tempHolderForState.widgetColor=color(255);
  }
  //(C.MacMahon created this method to see if any of the states button has been clicked, if it is clicked then the button remains highlighted 03/04/21 5pm)
  void countyClicked(int x, int y) {
    if (mouseX>x && mouseX<x+width && mouseY>y&& mouseY<y+height)
    {
      if (tempHolderForState.changeButtonColour==false)
      {
        if (tempHolderForState.label=="all states")
        {
          //(C.MacMahon, bug fix. If the user clicks all states and another state, then the all States option overrides the other chosen state and unselects it. 15/4/21 7pm)
          for (int p=0;p<countyButtons.size();p++)
          {
            Widget currentWidget= countyButtons.get(p);
            currentWidget.changeButtonColour=false;
          }
        }
        tempHolderForState.changeButtonColour=true;
      }
      //(C.MacMahon edited this code to allow for the user to unlclick a state and remove it from their chosen states. The state is no longer higlighted. 11/04/21 5pm)
      else {
        tempHolderForState.changeButtonColour=false;
      }
    }
  }
  
  //(D.Madaghjian, added method which is the same as Cianna's above, which checks whether the chart options in the chart drop down menu has been clicked, 11am 7/4/21)
  void chartHover(int x, int y) 
  {
    if (mouseX>x && mouseX<x+width && mouseY>y&& mouseY<y+height)
    {
      tempHolderForChart.widgetColor=color(251, 255, 54);
    } else tempHolderForChart.widgetColor=color(255);
  }
  
  //(D.Madaghjian, added method which is the same as Cianna's above, which checks whether the chart options in the chart drop down menu has been hovered over, 11am 7/4/21)
  void chartClicked(int x, int y) 
  {
    if (mouseX>x && mouseX<x+width && mouseY>y&& mouseY<y+height)
    {
      tempHolderForChart.changeButtonColour=true;
      chartClicked = true;
    }
    else
    {
      tempHolderForChart.changeButtonColour=false;
      chartClicked = false;
    }
  } 
  
  //(D.Madaghjian, created method which resets the buttons clicked in the drop down men of state, setting the button color back to its original state, 5pm 9/4/21)
  void resetButtonsClicked()
  {
    for (int i=0; i<countyButtons.size(); i++)
    {
      tempHolderForState=countyButtons.get(i);
      tempHolderForState.changeButtonColour = false;
    }
  }
}

//(O. Idowu, Created class Title that draws a title "Covid App" 10pm 26/03/2021 )
class Title {
  PFont titleFont;
  color titleColor;
  int otherColors = 255;
  boolean lighter;
  Title()
  {
    titleFont = loadFont("HarlowSolid-100.vlw");
    titleColor = color(255);
    lighter = false;
  }
  void draw()
  {
    textFont(titleFont);
    fill(titleColor);
    //O.Idowu, added text with the title of the app, 10pm 26/03/2021)
    text("Covid", 300, 100);
    fill(255, otherColors, otherColors);
    text("App", 510, 100);
    //O.Idowu, added if statement that changes the red component of the "App" string title allowing it to have a flashing effect
    if (lighter)
    {
      otherColors+= 2;
      if (otherColors >= 255)
      {
        lighter = false;
      }
    } else
    {
      otherColors-= 2;
      if (otherColors <= 0)
      {
        lighter = true;
      }
    }
  }
  void setColor(color newColor)
  {
    titleColor = newColor;
  }
}

//(O.Idowu, created PieChart class that takes in state/county variables and creates a pieChart based on them variables taken in, 6pm 09/04/2021)
class PieChart {
  String[] labelData;
  String title;
  ArrayList frequencyData;
  int x, y, diameter;
  boolean hovering;
  PFont factFont;
  PFont titleFont;
  PieChart(String[] labelData, ArrayList frequencyData, int x, int y, int diameter, String title)
  {
    this.labelData = labelData;
    this.frequencyData = frequencyData;
    this.x = x;
    this.y = y;
    this.diameter = diameter;
    this.title = title;
    factFont = loadFont("AgencyFB-Reg-20.vlw");
    titleFont = loadFont("AgencyFB-Reg-35.vlw");
  }
  //(O.Idowu, created draw method in PieChart class that draws a series of arcs with their size relative to frequency,6pm 09/04/2021)
  void draw() {
    float prevAngle = 0;
    float frequencyInDegrees;
    color sliceColor;
    float otherColor;
    float max = 0;
    for(int i = 0; i < labelData.length;i++)
    {
      max += (int)frequencyData.get(i);
    }
    for (int i = 0; i < labelData.length; i++)                                                        //Goes through array and makes an arc for each area with size and colour relative to the number of cases in the county
    {
    
      otherColor = map(i,0,labelData.length,0,255);
      frequencyInDegrees = map((int)frequencyData.get(i), 0, max, 0, 360);
      sliceColor = color(otherColor, 150, 255);
      fill(sliceColor);
      arc(x, y, diameter, diameter, prevAngle, prevAngle + radians(frequencyInDegrees), CENTER);
      prevAngle+=radians(frequencyInDegrees);
      if (sun)
      {
        fill(0);
      } else {
        fill(255);
      }
      textFont(titleFont);
      text(title, x-30, y - diameter/2 - 50);
      if (get(mouseX, mouseY) == sliceColor)
      {
        fill(255);
        stroke(0);
        rect(750, 700, 200, 75);
        fill(0);
        textFont(factFont);
        text("" + labelData[i], 755, 725);
        text("Cases:" + frequencyData.get(i), 755, 750);
      }
    }
  }
}

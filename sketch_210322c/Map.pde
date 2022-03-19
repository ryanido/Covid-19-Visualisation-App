//(O.Idowu, created class map that creates a HeatMap of the cases in the US, 6pm, 27/03/2021)
class Map {
  ArrayList allCounties;
  ArrayList allData;
  ArrayList countySquares;
  PFont stateFont;
  PFont factFont;
  PImage americaFlagImage;
  Map(ArrayList allData)
  {
    this.allData = allData;
    allCounties = new ArrayList();
    countySquares = new ArrayList();
    //(O.Idowu added all US Counties, 6pm 27/03/2021)
    stateFont = loadFont("AgencyFB-Reg-30.vlw");
    factFont = loadFont("AgencyFB-Reg-20.vlw");
    allCounties.add("Alabama");
    allCounties.add("Alaska");
    allCounties.add("Arizona");
    allCounties.add("Arkansas");
    allCounties.add("California");
    allCounties.add("Colorado");
    allCounties.add("Connecticut");
    allCounties.add("Delaware");
    allCounties.add("District of Columbia");
    allCounties.add("Florida");
    allCounties.add("Georgia");
    allCounties.add("Hawaii");
    allCounties.add("Idaho");
    allCounties.add("Illinois");
    allCounties.add("Indiana");
    allCounties.add("Iowa");
    allCounties.add("Kansas");
    allCounties.add("Kentucky");
    allCounties.add("Louisiana");
    allCounties.add("Maine");
    allCounties.add("Maryland");
    allCounties.add("Massachusetts");
    allCounties.add("Michigan");
    allCounties.add("Minnesota");
    allCounties.add("Mississippi");
    allCounties.add("Missouri");
    allCounties.add("Montana");
    allCounties.add("Nebraska");
    allCounties.add("Nevada");
    allCounties.add("New Hampshire");
    allCounties.add("New Jersey");
    allCounties.add("New Mexico");
    allCounties.add("New York");
    allCounties.add("North Carolina");
    allCounties.add("North Dakota");
    allCounties.add("Ohio");
    allCounties.add("Oklahoma");
    allCounties.add("Oregon");
    allCounties.add("Pennsylvania");
    allCounties.add("Rhode Island");
    allCounties.add("South Carolina");
    allCounties.add("South Dakota");
    allCounties.add("Tennessee");
    allCounties.add("Texas");
    allCounties.add("Utah");
    allCounties.add("Vermont");
    allCounties.add("Virginia");
    allCounties.add("Washington");
    allCounties.add("West Virginia");
    allCounties.add("Wisconsin");
    allCounties.add("Wyoming");

    int eventNumber = 1000;
    String county;
    String abbreviation;
    int frequency;
    float otherColors;
    color squareColor;
    int x;
    int y;
    Widget tempWidget;
    for (int i = 0; i < allCounties.size(); i++)
    {
      county = (String) allCounties.get(i);
      abbreviation = ToAbreviation(county);
      frequency = dataFinder.CountyCaseFrequency(county, allData);
      otherColors = map(frequency, 0, CASE_COLOR_LIMIT, 255, 0);
      //(O. Idowu, Color is more red relative to the amount of cases in the county)
      squareColor = color(255, otherColors, otherColors);
      x = mapPosX(county);
      y = mapPosY(county);
      tempWidget = new Widget(x, y, 50, 50, abbreviation, squareColor, stateFont, eventNumber++);
      countySquares.add(tempWidget);
    }
    americaFlagImage = loadImage("america flag.png");
  }
  void draw() 
  {
    //O.Idowu, created a loop that draws each square on the map, 6pm, 27/03/2021)
    Widget tempSquare;
    String county;
    int frequency;
    String areaWithMostCases;
    for (int i = 0; i < countySquares.size(); i++)
    {
      tempSquare = (Widget) countySquares.get(i);
      county = (String) allCounties.get(i);
      frequency = dataFinder.CountyCaseFrequency(county, allData);
      areaWithMostCases = dataFinder.getAreaWithLargestCasesInCounty(county);
      tempSquare.draw();
      //(O.Idowu, created if statement that shows facts about each county if the use is hovering above it, 3pm 02/04/2021)
      if(tempSquare.getHoveringOver())
      {
        fill(255);
        stroke(0);
        rect(750 ,700,200,125);
        fill(0);
        textFont(factFont);
        text("" + county,755,725);
        text("Cases:" + frequency, 755,750);
        text("Area with most cases:", 755,775);
        text("" + areaWithMostCases,755,800);
        
        
      }
    }
    image(americaFlagImage, 75, 290);                  //(D.Madaghjian, added American Flag to the map, 3/4/21)
  }
  //(O.Idowu created functions to get each counties X & Y positions on the map 6pm 27/03/2021)
  public int mapPosX(String county)
  {
    int startingXpos = MAP_X_STARTING_POSITION;
    int squareLength = MAP_SQUARE_LENGTH;
    int margin = SQUARE_MARGIN;
    int totalSpace = squareLength + margin;
    int xpos = 1000;
    switch(county)
    {
    case "Alaska":
    case "Washington":
    case "California":
    case "Hawaii":
    case "Oregon":
      xpos = startingXpos;
      break;
    case "Idaho":
    case "Nevada":
    case "Utah":
    case "Arizona":
      xpos = startingXpos + totalSpace;
      break;
    case "Montana":
    case "Wyoming":
    case "Colorado":
    case "New Mexico":
      xpos = startingXpos + (2 * totalSpace);
      break;
    case "North Dakota":
    case "South Dakota":
    case "Nebraska":
    case "Kansas":
    case "Oklahoma":
    case "Texas":
      xpos = startingXpos + (3 * totalSpace);
      break; 
    case "Minnesota":
    case "Iowa":
    case "Missouri": 
    case "Arkansas":
    case "Louisiana":
      xpos = startingXpos + (4 * totalSpace);
      break;
    case "Wisconsin":
    case "Illinois":
    case "Indiana":
    case "Kentucky":
    case "Tennessee": 
    case "Mississippi":
      xpos = startingXpos + (5 * totalSpace);
      break;
    case "Michigan":
    case "Ohio":
    case "West Virginia":
    case "North Carolina":
    case "Alabama":
      xpos = startingXpos + (6 * totalSpace);
      break; 
    case "Pennsylvania":
    case "Virginia":
    case "South Carolina":
    case "Georgia":
      xpos = startingXpos + (7 * totalSpace);
      break;
    case "New York":
    case "New Jersey":
    case "Maryland":
    case "District of Columbia":
    case "Florida":
      xpos = startingXpos + (8 * totalSpace);
      break;  
    case "Vermont":
    case "Massachusetts":
    case "Connecticut":
    case "Delaware":
      xpos = startingXpos + (9 * totalSpace);
      break;
    case "Maine":
    case "New Hampshire":
    case "Rhode Island":
      xpos = startingXpos + (10 * totalSpace);
      break;
    }
    return xpos;
  }
  public int mapPosY(String county)
  {
    int startingYpos = MAP_Y_STARTING_POSITION;
    int squareWidth = MAP_SQUARE_LENGTH;
    int margin = SQUARE_MARGIN;
    int totalSpace = squareWidth + margin;
    int ypos = 1000;
    switch(county)
    {
    case "Alaska":
    case "Maine":
      ypos = startingYpos;
      break;
    case "Wisconsin":
    case "Vermont":
    case "New Hampshire":
      ypos = startingYpos + totalSpace;
      break;
    case "Washington":
    case "Idaho":
    case "Montana":
    case "North Dakota":
    case "Minnesota":
    case "Illinois":
    case "Michigan":
    case "New York":
    case "Massachusetts":
      ypos = startingYpos + (2 * totalSpace);
      break;
    case "Oregon":
    case "Nevada": 
    case "Wyoming":
    case "South Dakota":
    case "Iowa":
    case "Indiana":
    case "Ohio":
    case "Pennsylvania":
    case "New Jersey":
    case "Connecticut":
    case "Rhode Island":
      ypos = startingYpos + (3 * totalSpace);
      break;
    case "California":
    case "Utah":
    case "Colorado":
    case "Nebraska":
    case "Missouri":  
    case "Kentucky":
    case "West Virginia":
    case "Virginia":
    case "Maryland": 
    case "Delaware":
      ypos = startingYpos + (4 * totalSpace);
      break; 
    case "Arizona":
    case "New Mexico":
    case "Kansas":  
    case "Arkansas": 
    case "Tennessee":  
    case "North Carolina":
    case "South Carolina":
    case "District of Columbia":
      ypos = startingYpos + (5 * totalSpace);
      break;
    case "Oklahoma":
    case "Louisiana":
    case "Mississippi":
    case "Alabama":
    case "Georgia":
      ypos = startingYpos + (6 * totalSpace);
      break;
    case "Hawaii":
    case "Texas":
    case "Florida":
      ypos = startingYpos + (7 * totalSpace);
      break;
    }
    return ypos;
  }
  //(O.Idowu created function to get each counties abbreviation 6pm 27/03/2021)
  public String ToAbreviation(String county)
  {
    String abreviation = "";
    switch(county)
    {
    case "Alabama":
      abreviation = "AL";
      break;
    case "Alaska":
      abreviation = "AK";
      break;
    case "Arkansas":
      abreviation = "AR";
      break;
    case "Arizona":
      abreviation = "AZ";
      break;
    case "California":
      abreviation = "CA";
      break;
    case "Colorado":
      abreviation = "CO";
      break;
    case "Connecticut":
      abreviation = "CT";
      break;
    case "Delaware":
      abreviation = "DE";
      break;
    case "District of Columbia":
      abreviation = "DC";
      break;
    case "Florida":
      abreviation = "FL";
      break;
    case "Georgia":
      abreviation = "GA";
      break;
    case "Hawaii":
      abreviation = "HI";
      break;
    case "Idaho":
      abreviation = "ID";
      break;
    case "Illinois":
      abreviation = "IL";
      break;
    case "Indiana":
      abreviation = "IN";
      break;
    case "Iowa":
      abreviation = "IA";
      break;
    case "Kansas":
      abreviation = "KS";
      break;
    case "Kentucky":
      abreviation = "KY";
      break;
    case "Louisiana":
      abreviation = "LA";
      break;
    case "Maine":
      abreviation = "ME";
      break;
    case "Maryland":
      abreviation = "MD";
      break;
    case "Massachusetts":
      abreviation = "MA";
      break;
    case "Michigan":
      abreviation = "MI";
      break;
    case "Minnesota":
      abreviation = "MN";
      break;
    case "Mississippi":
      abreviation = "MS";
      break;
    case "Missouri":
      abreviation = "MO";
      break;
    case "Montana":
      abreviation = "MT";
      break;
    case "Nebraska":
      abreviation = "NE";
      break;
    case "Nevada":
      abreviation = "NV";
      break;
    case "New Hampshire":
      abreviation = "NH";
      break;
    case "New Jersey":
      abreviation = "NJ";
      break;
    case "New Mexico":
      abreviation = "NM";
      break;
    case "New York":
      abreviation = "NY";
      break;
    case "North Carolina":
      abreviation = "NC";
      break;
    case "North Dakota":
      abreviation = "ND";
      break;
    case "Ohio":
      abreviation = "OH";
      break;
    case "Oklahoma":
      abreviation = "OK";
      break;
    case "Oregon":
      abreviation = "OR";
      break;
    case "Pennsylvania":
      abreviation = "PA";
      break;
    case "Rhode Island":
      abreviation = "RI";
      break;
    case "South Carolina":
      abreviation = "SC";
      break;
    case "South Dakota":
      abreviation = "SD";
      break;
    case "Tennessee":
      abreviation = "TN";
      break;
    case "Texas":
      abreviation = "TX";
      break;
    case "Utah":
      abreviation = "UT";
      break;
    case "Vermont":
      abreviation = "VT";
      break;
    case "Virginia":
      abreviation = "VA";
      break;
    case "Washington":
      abreviation = "WA";
      break;
    case "West Virginia":
      abreviation = "WV";
      break;
    case "Wisconsin":
      abreviation = "WI";
      break;
    case "Wyoming":
      abreviation = "WY";
      break;
    }
    return abreviation;
  }
  //(O.Idowu, created get method to get & set ArrayList with all the county WIdgets, 3pm 02/04/2021)
  ArrayList getCountySquares() {
    return countySquares;
  }
  void setCountySquares(ArrayList countySquares) {
    this.countySquares = countySquares;
  }
  //(O.Idowu, created get method for arrayList with all the counties in alphabetical order,11pm,08/04/2021)
    ArrayList getAllCounties() {
    return allCounties;
  }
  
}

//(D.Madaghjian, Created the class BottomOfScreen to display different information from the data file "cases", 3pm 27/03/2021)

class BottomOfScreen
{
  //(D.Madaghjian, Declared variables which are to be used within the class, 3pm 27/03/2021)
  DataFinder currentDataFinder;
  
  int totalCases;  
  String totalCasesText;
  
  int lastWeeksCases;
  String lastWeeksText;
  
  int lastMonthsCases;  
  String lastMonthsText; 
  
  String countyWithLargestCases;
  int casesInCountyWithLargestCases;   
  String countyWithLargestCasesText;
  
  String largestAreaWithinLargestState;
  String largestCounty;
  int highestCasesInLargestAreaWithinLargestCounty;  
  
  String countyWithLowestCases;
  int casesInCountyWithLowestCases;
  String countyWithLowestCasesText;
   
  float x1;
  float x2;
  float x3;
  float x4;
  float x5;
  float x6;
  
  boolean introductionFinished;
  PFont font;
  
  //(D.Madaghjian, Created constructor which takes in information to be displayed as parameters, and then initialises variables declared at beginning of class, 3pm 27/03/2021)
  BottomOfScreen(DataFinder dataFinder)
  {
    currentDataFinder = dataFinder;
    totalCases = currentDataFinder.getTotalCases();
        
    currentDataFinder.getDPsInLastMonth();
    lastMonthsCases = currentDataFinder.getLastMonthsCases();
    
    //(C.MacMahon added the following string to the loop of information at the bottom of the screen 03/04/21 5pm)
    largestCounty=dataFinder.getCountyOfLargestCases();
    areas=states.getAreas(largestCounty,areas);
    dataFinder.casesInAreasOfGivenState(areas, allData, largestCounty);
    highestCasesInLargestAreaWithinLargestCounty=dataFinder.highestCasesInGivenAreas(areaCases);
    String highestAreaInHighestCounty=dataFinder.areaOfCasesPassed(highestCasesInLargestAreaWithinLargestCounty);
    largestAreaWithinLargestState="<Area with the largest cases within "+largestCounty+" is: "+highestAreaInHighestCounty+" ("+highestCasesInLargestAreaWithinLargestCounty+") >";
  
    countyWithLargestCases = currentDataFinder.getCountyLargestCases();
    casesInCountyWithLargestCases = currentDataFinder.getCasesOfCounty(countyWithLargestCases);
    
    //(D.Madaghjian added extra information to display, 4:30pm 4/4/21)
    currentDataFinder.getDPsInLastWeek();
    lastWeeksCases = currentDataFinder.getLastWeeksCases();
    
    countyWithLowestCases = currentDataFinder.getCountyOfLowestCases();
    casesInCountyWithLowestCases = currentDataFinder.getCasesOfCounty(countyWithLowestCases);
        
    font = loadFont("ArialNarrow-BoldItalic-48.vlw");
    textFont(font);
    
    totalCasesText = "< Total Cases: " + totalCases + " > ";    
    lastMonthsText = "< Last Months Cases: " + lastMonthsCases + " > ";   
    countyWithLargestCasesText = "< County With Largest Cases: " + countyWithLargestCases + " (" + casesInCountyWithLargestCases + ") >";  
    
    lastWeeksText = "< Last Weeks Cases: " + lastWeeksCases + " > ";
    
    countyWithLowestCasesText = "< County With Lowest Cases: " + countyWithLowestCases + " (" + casesInCountyWithLowestCases + ") >";
       
    x1=0;
    x2=x1-(400);
    x3=x2-(500);   
    x4=x3-(500);
    x5=x4-(800);
    x6=x5-(1100);
  }
  
  //(D.Madaghjian, Created a draw method which draws bar at bottom of screen and draws text moving from left to right across the bar, 4pm 27/03/2021)
  void draw()
  {
    fill(255,0,0);
    rect(0, 945, 1000, 5);
    fill(204, 255, 153);
    rect(0, 950, 1000, BOTTOMOFSCREEN_HEIGHT);
    fill(0);
    if(!introductionFinished)                            //only drawn once at start of program
    {
      textAlign(LEFT);
      text("Welcome to the CovidApp!", x1+=3, 992);
      if(x1>= 1100)
      {
        introductionFinished = true;
        x1=0;
      }
    }
   
    else                  
    {
      textAlign(RIGHT);
      text(totalCasesText, x1, 992);
      text(lastWeeksText, x2, 992);
      text(lastMonthsText, x3, 992);
      text(countyWithLargestCasesText, x4, 992);
      text(largestAreaWithinLargestState,x5,992);
      text(countyWithLowestCasesText, x6, 992);
      if(x6 >= 1600)                                     //restarts movement of text
      {
        x1=0;
        x2=x1-(400);
        x3=x2-(500);   
        x4=x3-(500);
        x5=x4-(800);
        x6=x5-(1100);
      }
      x1+=4;     
      x2+=4;            
      x3+=4; 
      x4+=4;
      x5+=4;  
      x6+=4;
    }
    textAlign(LEFT);
  }    
}

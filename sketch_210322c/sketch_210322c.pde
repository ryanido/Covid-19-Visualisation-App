//(C.MacMahon, created the global variables to be used in the program, 12pm 23/03/2021) //<>//
Table data;
TableRow row;
DataPoint currentDP;
ArrayList allData;

//Fonts
PFont mainFont;
PFont themeFont;
PFont queryFont;
PFont barChartFont;

//(O.Idowu, Added global variables to be used in the program 12pm 29/03/2021)
Map heatMap;
Title title;
PImage sunImage;
PImage moonImage;
PImage themeImage;
String timeLabel = "day";

//Colours
color day = color(255, 255, 125);
color night = color(0, 0, 200);
color timeColor = day;
color bgColor = color(0, 0, 100);

//Booleans
boolean sun = false;
boolean drawStateMenu;
boolean drawChartMenu;
boolean drawPieChart;
boolean drawMap;
boolean drawHelpButton;
boolean searchPressed;
boolean statePicked;
boolean chartPicked;
boolean timePressed;
boolean totalPressed;
boolean barChartClicked;
boolean boxPlotClicked;

//Widgets
Widget theme;
Widget tempHolderForState;
Widget tempHolderForChart;
//(C.MacMahon and H.Foley added more global variables to the program. 12/4/21 5pm)
Widget helpButton;
//(D.Madaghjian, Declared global variables and objects to be used in program, 12pm 28/03/2021)
Widget resetButton;
Widget stateWidget;
Widget chartButton;
Widget searchButton;
Widget timeButton;
Widget totalButton;
Widget backButton;

//ArrayLists
//(C.MacMahon added global variables to be used in the program 11am 03/04/21)
ArrayList <String> areas, statesArray;
ArrayList <Integer>areaCases;
ArrayList<Widget>countyButtons=new ArrayList();
ArrayList <Widget> chartButtons = new ArrayList();
ArrayList <Integer>casesInStates= new ArrayList();
//(O.Idowu added global variables to be used in the program 6pm 08/04/21)
ArrayList countySquares;
ArrayList allCounties;
ArrayList <Widget> buttons = new ArrayList();

//Others
int event;
String [] allStatesAlphabetical;
State states;
barChart barChart;
PieChart countyPieChart;
//(D.Madaghjian, Declared global variables and objects to be used in program, 12pm 28/03/2021)
DataFinder dataFinder;
BottomOfScreen myBottomOfScreen;
BoxPlot boxPlot;
query query;

String instructions1="click a state on the heatmap to see a pie chart of its areas";
String or="OR";
String instructions2="filter the data by states using the filters below";


//(C.MacMahon made the screen size a constant variable)
void settings()
{
  size(SCREEN, SCREEN);
}
void setup() {
  //(C.MacMahon, loaded the fonts into the program 12pm 23/03/2021)
  drawStateMenu=false;
  drawMap = true;
  mainFont=loadFont("Avenir-LightOblique-5.vlw");
  barChartFont = loadFont("AgencyFB-Reg-20.vlw");
  textFont(mainFont);
  //(C.MacMahon, loaded the data into the program using a Table object 12pm 23/03/2021)
  data=loadTable("cases-10k.csv", "header");
  sunImage = loadImage("sun.png");
  moonImage = loadImage("moon.png");
  themeImage = sunImage;
  allData= new ArrayList();
  states=new State();
  statesArray=new ArrayList();

  title = new Title();
  for (int i=0; i<data.getRowCount(); i++)
  {
    //(C.MacMahon, created a function to loop through each row of the data set and 
    //extract each datapoint from every column of the current row, in order to create an instance of the 
    //class for each line in the data file 12:30pm 23/03/2021)
    row=data.getRow(i);
    String date= row.getString("date");
    String area= row.getString("area");
    String county=row.getString("county/state");
    String geoid = row.getString("geoid");
    String cases=row.getString("cases");
    String country=row.getString("country");
    //(C.MacMahon implemented error checking methods on the data that is being analysed: any data that does not match the intended variable 
    // type, is not add to the data set, if the data set has a blank cell, then "Unknown" is placed in that cell. However if the number of
    // cases is left blank then that data point is not added to the data set. 27/03/21 3pm)

    if (area.equals(""))
    {
      area="Unknown";
    } else if (county.equals(""))
    {
      county="Unknown";
    } else if (country.equals(""))
    {
      country="Unknown";
    } else if (cases.equals(""))
    {
      cases="Unknown";
    } else if (date.equals(""))
    {
      date="Unknown";
    } else if (geoid.equals(""))
    {
      geoid="Unknown";
    }
    if (((Character.isLetter(area.charAt(0))==true)||area=="Unknown")&&((Character.isLetter(county.charAt(0))==true)||county=="Unknown")&&
      ((Character.isLetter(country.charAt(0))==true)||country=="Unknown")&&((Character.isLetter(cases.charAt(0))!=true)&&cases!="Unknown")
      &&((Character.isLetter(geoid.charAt(0))!=true)||geoid=="Unknown")&& ((Character.isLetter(date.charAt(0))!=true)&&date!="Unknown"))
    {
      currentDP= new DataPoint(date, area, county, int(geoid), int(cases), country, mainFont);
      //(C.MacMahon, added each instance of the class to the array list 12:30pm 23/03/2021)
      allData.add(currentDP);
      states.allStates(county);
    }
  }
  states.allStatesAlphabetical();
  query = new query();
  dataFinder = new DataFinder(allData);
  heatMap = new Map(allData);
  barChart = new barChart(query);
  areas=new ArrayList();

  theme = new Widget(40, 50, 50, 50, themeImage, 1);
  //(D.Madaghjian, initialized objects to be used within the program, 10:30am 01/04/2021)
  myBottomOfScreen = new BottomOfScreen(dataFinder);
  queryFont = loadFont("ArialNarrow-40.vlw");
  resetButton = new Widget(30,200,125,50,"Reset",color(255,165,0),queryFont, 5);
  stateWidget = new Widget(200, 200, 150, 50, "State", color(50, 205, 50), queryFont, 2);
  chartButton = new Widget(475, 200, 150, 50, "Chart", color(50, 205, 50), queryFont, 3);
  searchButton = new Widget(750, 200, 150, 50, "Search", color(255, 244, 79), queryFont, 4);
  backButton = new Widget(30,800, 100,50, "Back", color(255,165,0), queryFont, 8);
  //(C.MacMahon added this method to create the widgetList for the states in the data set 03/04/21 5pm)
  states.widgetListForStates();
  //(C.MacMahon and H.Foley added a help button to the program. 12/4/21 5pm)
  helpButton=new Widget(800, 50, 125, 50, "Help", color(255, 165, 0), queryFont, 10, 45,50);
  dataFinder.widgetListForCharts();
  //(H.Foley created time button and total button to switch between bar charts, 7th April 21)
  timeButton = new Widget(750, 270, 150, 50, "Time", SWITCH2, queryFont, TIME_EVENT);
  totalButton = new Widget(600, 270, 150, 50, "Total", SWITCH1, queryFont, TOTAL_EVENT);
  buttons.add(theme); buttons.add(resetButton); buttons.add(stateWidget); buttons.add(chartButton); buttons.add(searchButton); buttons.add(backButton); buttons.add(helpButton); buttons.add(timeButton); buttons.add(totalButton);
}

void draw() {  
  background(bgColor); 
  title.draw();
  
  if (!searchPressed)
  {  
    if (drawMap)
    {
      heatMap.draw();  //default image on screen
    }
    //(C.MacMahon, if the drawMenu is true then a drop down menu of widget buttons for all the states will be drawn. 03/04/21 11am)
    //(D.Madaghjian, if search is not pressed we check wether the state drop down menu is true or whether the chart drop down menu is true, 11am 7/4/21)
    if (drawStateMenu)
    {
      for (int i=0; i<countyButtons.size(); i++)    //draws state widgets in drop down menu
      {
        tempHolderForState=countyButtons.get(i);
        tempHolderForState.draw();
      }
    } else if (drawChartMenu)
    {
      for (int i=0; i<chartButtons.size(); i++)    //draws chart widgets in drop down menu
      {
        tempHolderForChart=chartButtons.get(i);
        tempHolderForChart.draw();
      }
    }
    //(O.Idowu added pieChart draw method 6pm,08/04/21)
    else if (drawPieChart)
    {
      countyPieChart.draw();  //draws PieChart
      backButton.draw();      //draws backButton
    }
    
  } 
  //(D.Madaghjian, checks if barChart option or boxplot option is clicked and draws the chart, 11am 7/4/21)
  else
  { 
    if (barChartClicked)
    {
      barChart= new barChart(query);
      barChart.draw();
      timeButton.draw();
      totalButton.draw();
    } else if (boxPlotClicked)
    {
      boxPlot = new BoxPlot(query);
      boxPlot.draw();
    }
  }
   //(C.MacMahon and H.Foley. When the help button is clicked, the help button attributes will be drawn to the screen. 12/4/21 5pm)
  if (drawHelpButton)
    {
      fill(255);
      rect(600, 100, 500, 100);
      textFont(barChartFont);
      fill(0);
      text(instructions1, 650, 130);
      text(instructions2,650,180);
      textFont(barChartFont);
      fill(240,34,34);
      text(or,800,155);
    }
  //Buttons and elements that are always present on the screen
  resetButton.draw();
  stateWidget.draw();
  chartButton.draw();
  searchButton.draw();
  helpButton.draw();
  theme.draw();
  myBottomOfScreen.draw();
}

void mousePressed() {
  //(D.Madaghjian, created switch statement which checks the arraylist of buttons and makes appropiate changes if the buttons are pressed, 4pm 16/04/21)
  int event;
  for(int i = 0; i < buttons.size(); i++)
  {
    Widget buttonWidget = (Widget) buttons.get(i);
    event = buttonWidget.getEvent(mouseX, mouseY);
    switch(event) 
    {
      //(O.Idowu, created switch statement for theme change,10pm, 26/03/2021)
        case THEME_BUTTON_EVENT:
            if (sun)
            {
              timeColor = day;
              themeImage = sunImage;
              title.setColor(color(255));
              bgColor = color(0, 0, 100);
              sun = false;
            } else 
            {
              timeColor = night;
              themeImage = moonImage;
              title.setColor(color(0));
              bgColor = color(255);
              sun = true;
            }
            theme.setImage(themeImage);
            break;
       //(D.Madaghjian, created switch statements to check if mouse is pressed for the state query and search button, 10:30am 01/04/2021     
       case STATE_BUTTON_EVENT:
            statePicked=true;
            stateWidget.hovering(true);
            query.addToLists(stateWidget);
            //C.MacMahon added in the drawMenu boolean. It turs true once the widget for stateWidget has been pressed. 03/04/21 11am)
            drawStateMenu=true;
            break;
       //(D.madaghjian, created switch statements to check if mouse is pressed for the chart query, 11am 7/4/21)    
       case CHART_BUTTON_EVENT:
            chartPicked=true;
            chartButton.hovering(true);
            drawStateMenu = false;
            drawChartMenu=true;
            break;
       //(D.Madaghjian, modified a bug in the search button which only is pressed if the user picks an option in the state query and the chart query, 3pm 16/04/21)     
       case SEARCH_BUTTON_EVENT:
            if(query.buttonsPressedNumber!=null)
            {  
                states.checkClicked();
                if(query.buttonsPressedNumber.size() > 1 && (barChartClicked || boxPlotClicked))    //option was picked in the two queries
                {
                  searchPressed = true;
                  drawStateMenu=false;      
                }
                searchButton.hovering(true);
            }
            break;
       //(D.Madaghjian, checked if the reset button is pressed and made the appropiate changes to the program ensuring all the queries are refreshed and the heatMap returns to the screnn, 5pm 9/4/21)     
       case RESET_BUTTON_EVENT:
            statePicked = false;
            chartPicked = false;
            drawStateMenu = false;
            drawChartMenu = false;
            barChartClicked = false;
            boxPlotClicked = false;
            timePressed = false;
            searchPressed = false;
            drawMap = true;
            drawPieChart = false;
            query.clearButtonsClicked();
            resetButton.resetButtonsClicked();
            break;
      //(H.Foley made a switch between the time and total buttons to see different bar charts, lab 4;50pm     
      case TIME_EVENT:
            if (searchPressed) 
            {
              //(C.MacMahon fixed a bug in the code that added the timePressed button to the list of buttons pressed when user was picking their states to filter.13/4/21 6pm)
                  if (!timePressed) 
                  {
                    timePressed=true;
                    if (timeButton.widgetColor == SWITCH1) {
                      timeButton.widgetColor = SWITCH2;
                      totalButton.widgetColor = SWITCH1;
                    } else
                    {
                      timeButton.widgetColor = SWITCH1;
                      totalButton.widgetColor = SWITCH2;
                    }
                    totalPressed = false;
                  } 
                  else if (timePressed && !totalPressed) 
                  {
                      timePressed = false;
                      totalPressed = true;
                      totalButton.widgetColor = SWITCH1;
                      timeButton.widgetColor = SWITCH2;
                  }      
              query.addToLists(timeButton);
            }
            break;
            
      case TOTAL_EVENT:
      //(C.MacMahon fixed a bug in the code that added the timePressed button to the list of buttons pressed when user was picking their states to filter.13/4/21 6pm)
            if (searchPressed) 
            {
                  if (!totalPressed) 
                  {
                      totalPressed=true;
                      timePressed = false;
                      if (totalButton.widgetColor == SWITCH1) {
                        totalButton.widgetColor = SWITCH2;
                        timeButton.widgetColor = SWITCH1;
                      } 
                      else
                      {
                        totalButton.widgetColor = SWITCH1;
                        timeButton.widgetColor = SWITCH2;
                      }
                  } 
                  else if (totalPressed && !timePressed) 
                  {
                      totalPressed = false;
                      timePressed = true;
                      totalButton.widgetColor = SWITCH2;
                      timeButton.widgetColor = SWITCH1;
                  }
                  query.addToLists(totalButton);
            }
            break;
       //(D.Madaghjian, checked if the back button is pressed in which we then return back to the heat Map and the pie chart dissapears, 5pm 9/4/21)    
      case BACK_BUTTON_EVENT:
              drawPieChart = false;
              drawMap = true;
              break;
      //C.MacMahon and H.Foley check if the helpButton or the exit button within the help button has been pressed. 12/4/21 5pm)     
      case HELP_BUTTON:
              drawHelpButton=true;
              break;
    }                       
  }
  
  event=helpButton.exitWidget.getEvent(mouseX,mouseY);
  switch(event)
  {
     case 11:
     drawHelpButton=false;
  }

  // (C.MacMahon created this loop to check if the mouse has clicked any of the widget buttons for the states 03/04/21 5pm)
  for (int i=0; i<countyButtons.size()&& drawStateMenu; i++)
  {
    tempHolderForState=countyButtons.get(i);
    int x=tempHolderForState.x;
    int y=tempHolderForState.y;
    tempHolderForState.countyClicked(x, y);
  }

  //(D.Madaghian, took the same approach as Cianna in checking whether any of the chart options have been clicked, 11am 7/4/21)
  for (int i =0; i < chartButtons.size(); i++)
  {
    tempHolderForChart = chartButtons.get(i);    
    tempHolderForChart.chartClicked(tempHolderForChart.x, tempHolderForChart.y);
    if (tempHolderForChart.chartClicked && chartPicked)
    {
      if (tempHolderForChart.label.equals("barChart"))
      {
        barChartClicked = true;
      } else
      {
        boxPlotClicked = true;
      }
    }
  }
   
  //(O.Idowu, created a loop in MousePressed to get a piechart of a state if the county square is clicked,6pm,08/04/2021)
  countySquares = heatMap.getCountySquares();
  allCounties = heatMap.getAllCounties();
  for (int i = 0; i < countySquares.size(); i++)
  {
    Widget county = (Widget)countySquares.get(i);
    String countyString = (String)allCounties.get(i);
    ArrayList areaList = new ArrayList();
    states.getAreas(countyString, areaList);
    String[] allAreas=new String[areaList.size()];
    for (int o=0; o<allAreas.length; o++)
    {
      allAreas[o]=(String)areaList.get(o);
    }
    allAreas=sort(allAreas);
    ArrayList areaFrequencies = dataFinder.casesInAreasOfGivenState(areaList, allData, countyString);
    int xpos = county.getXpos();
    int ypos = county.getYpos();
    if (mouseX <= xpos + MAP_SQUARE_LENGTH && mouseX >= xpos
      && mouseY <= ypos + MAP_SQUARE_LENGTH && mouseY >= ypos)
    {
      drawPieChart = true;
      countyPieChart = new PieChart(allAreas, areaFrequencies, SCREEN/2, SCREEN/2 + 100, 500, countyString);
      drawMap = false;
    }
    else
    {
      if(drawStateMenu || drawChartMenu)
      {
        drawMap = true;
      }
    }
  } 
}

//(D.Madaghjian, created mouseMoved method checking whether the mouse is hovering over the different widgets, and then made appropiate changes if it did so, 10:30am 01/04/2021)
void mouseMoved()
{
  //(D.Madaghjian, checks if the mouse is hovered over the reset button, 5pm 9/4/21)
  event = resetButton.getEvent(mouseX,mouseY);
  switch(event)
  {
    case 5:
        resetButton.hovering(true);
        break;
    default:
        resetButton.hovering(false);
  }
    
  event = stateWidget.getEvent(mouseX, mouseY);
  switch(event)
  {
  case 2:
    stateWidget.hovering(true);
    break;
  default:
    if (!statePicked)
    {        
      stateWidget.hovering(false);
    }
  }  
  // (C.MacMahon created this loop to check if the mouse is hovering over any of the widget buttons for the states 03/04/21 5pm)
  for (int i=0; i<countyButtons.size(); i++)
  {
    tempHolderForState=countyButtons.get(i);
    int x=tempHolderForState.x;
    int y=tempHolderForState.y;
    tempHolderForState.countyHover(x, y);
  }

  event = chartButton.getEvent(mouseX, mouseY);
  switch(event)
  {
  case 3:
    chartButton.hovering(true);
    break;
  default:
    if (!chartPicked)
    {        
      chartButton.hovering(false);
    }
  }

  //(D.Madaghian, took the same approach as Cianna in checking whether the mouse has hovered over any of the chart options, 11am 7/4/21)
  for (int i =0; i < chartButtons.size(); i++)
  {
    tempHolderForChart = chartButtons.get(i);    
    tempHolderForChart.chartHover(tempHolderForChart.x, tempHolderForChart.y);
  }

  event = timeButton.getEvent(mouseX, mouseY);
  switch(event)
  {
  case 6:
    timeButton.hovering(true);
    break;
  default:
    if (!timePressed)
    {        
      timeButton.hovering(false);
    }
  }
  event = totalButton.getEvent(mouseX, mouseY);
  switch(event)
  {
  case 7:
    totalButton.hovering(true);
    break;
  default:
    if (!totalPressed)
    {        
      totalButton.hovering(false);
    }
  }
  event = searchButton.getEvent(mouseX, mouseY);
  switch(event)
  {
  case 4:
    searchButton.hovering(true);
    break;
  default:
    if (!searchPressed)
    {
      searchButton.hovering(false);
    }
  }
  //(C.MacMahon and H.Foley checked to see if the mouse is hovering over the help or exit button. 12/4/21 5pm)
  event= helpButton.getEvent(mouseX,mouseY);
  switch(event)
  {
    case 10:
    helpButton.hovering(true);
    break;
    default:
    helpButton.hovering(false);
  }
  event= helpButton.exitWidget.getEvent(mouseX,mouseY);
  switch(event)
  {
    case 11:
    helpButton.exitWidget.hovering(true);
    break;
    default:
    helpButton.exitWidget.hovering(false);
    
  }
  ArrayList countySquares = heatMap.getCountySquares();
  for (int i = 0; i < countySquares.size(); i++)
  {
    Widget county = (Widget)countySquares.get(i);
    int xpos = county.getXpos();
    int ypos = county.getYpos();
    if (mouseX <= xpos + MAP_SQUARE_LENGTH && mouseX >= xpos
      && mouseY <= ypos + MAP_SQUARE_LENGTH && mouseY >= ypos)
    {
      county.hovering(true);
      county.setHoveringOver(true);
    } else {
      county.hovering(false);
      county.setHoveringOver(false);
    }
    heatMap.setCountySquares(countySquares);
  }
  
   //(D.Madaghjian, checks if the mouse is hovered over the reset button, 5pm 9/4/21)
  event = backButton.getEvent(mouseX,mouseY);
  switch(event)
  {
    case 8:
     backButton.hovering(true);
     break;
    default:
     backButton.hovering(false);
  }
}

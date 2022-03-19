//(D.Madaghjian, created the class BoxPlot which creates boxplot and draws to screen, 12pm 5/4/21)
class BoxPlot
{
  ArrayList buttonsPressedString;
  ArrayList buttonsPressedNumber;
  
  String[]allStates;
  ArrayList <String> sortedStates;
  ArrayList <String>statesChosen=new ArrayList();
  int [] dataArray;
  int [] sortedDataArray;
   
  String categoryX;
  String title;
  float multiplier;
  
  int min;
  float q1;
  float median;
  float q3;
  int max;
  
  String minText;
  String q1Text;
  String medianText;
  String q3Text;
  String maxText;
  color boxPlotColor;
  PFont boxPlotFont;
  
  float minXPosition;
  float q1XPosition;
  float q1Width;
  float medianXPosition;
  float q3Width;
  float q3XPosition;
  float maxXPosition;
  float yPositionOfLine;
  
  //(D.Madaghjian, created constructor which initialises values to be used in program, and takes in query as the parameter which will indicate the queries the user entered and allow us to create the boxplot based on this, 12pm 5/4/21)
  BoxPlot(query Query)
  {
    ArrayList <String> buttonsPressedString = query.getButtonsPressedString();
    ArrayList <Integer> buttonsPressedNumber = query.getButtonsPressedNumber();
    
    boxPlotFont = loadFont("AgencyFB-Reg-18.vlw");        
    categoryX = "Cases";                                
    title = "Total Cases by State";
   
    if (buttonsPressedNumber != null)
    {
      //If allStates option is chosen in state query
      if (buttonsPressedNumber.get(1)==CHOSE_ALL_STATES)
      {
          allStates=new String[statesArray.size()];
          for (int i=0; i<allStates.length; i++)
          {
              String exist=statesArray.get(i);
              allStates[i]=exist;
          }         
          statesChosen=statesArray;                    //creates array of all the states          
          dataArray = new int [casesInStates.size()-1];
          for (int i = 0; i < dataArray.length; i++)
          {
               dataArray[i] = (int) casesInStates.get(i);
          }
          sortedDataArray = dataArray.clone();         
          sortedDataArray = sort(sortedDataArray);    //the cases of all the states in ascending order                                       
      }
      //if specific states are chosen in state query
      else if (buttonsPressedNumber.get(1)==CHOSE_A_STATE )
      {                             
            for(int i=1;i<buttonsPressedNumber.size()&&buttonsPressedNumber.get(i)==4 ;i++)
            {
              // the states chosen are obtained from the buttonPressedString that was passed into the barChart class
              statesChosen.add(buttonsPressedString.get(i));
            }            
            dataArray=new int[statesChosen.size()];
            for(int i=0;i<statesChosen.size();i++)
            {
              String stateInChosen=statesChosen.get(i);
              int casesInState=dataFinder.getCasesOfCounty(stateInChosen);
              dataArray[i]=casesInState;        
            }          
            sortedDataArray = dataArray.clone();                                               
            sortedDataArray = sort(sortedDataArray);                  //the cases of all the states chosen in ascending order      
      }
      //initialises measurement labels
      min = sortedDataArray[0];
      max = sortedDataArray[sortedDataArray.length - 1];
      median = getMedian(sortedDataArray);
      q1 = getQ1(sortedDataArray);
      q3 = getQ3(sortedDataArray);
      
      //used to scale the boxplot    
      multiplier = 800/(float)max;
      
      //initialise the position and width of the measurements min,q1,median,q3,max
      minXPosition = MARGIN + (multiplier*min);
      q1XPosition = MARGIN + ((multiplier)*(q1));
      q1Width = multiplier*(median-q1);
      medianXPosition = MARGIN + ((multiplier) * (median));
      q3Width = multiplier*(q3-median);
      q3XPosition = MARGIN + ((multiplier) * (q3));
      maxXPosition = MARGIN + (multiplier*max);    
      //initialise the middle line of boxplot which allows us to determine y values for the boxpot by basing it off this line
      yPositionOfLine = (SCREEN/5 * 3)+40;
      //initiaise the labels which correspond to min,q1,median,q3,max by stating the state and the number of cases in that respective state    
      minText = getMinState(statesChosen, min) + " (" + min + ")";             
      q1Text = getQ1State(statesChosen, q1) + " (" + q1 + ")";                
      medianText = getMedianState(statesChosen, median) + " (" + median + ")";               
      q3Text = getQ3State(statesChosen, q3) + " (" + q3 + ")";             
      maxText = getMaxState(statesChosen, max) + " (" + max + ")"; 
    }
  }
  
  //(D.Madaghjian, created the draw method, which draws the boxplot to the screen, 2pm 5/4/21)
  void draw()
  {
    //determine boxPlotColor with regards to the theme
    if (!sun)
    {
      boxPlotColor = color(255);
    }
    else
    {
      boxPlotColor= color(0);
    }
        
    textFont(barChartFont);
    fill(boxPlotColor);
    stroke(boxPlotColor);    
    text(categoryX, MARGIN, (SCREEN/5)*4+MARGIN/2);
    text(title, SCREEN/2 -100, (SCREEN/5)*2); 
    
    //draw axis for cases
    line(MARGIN, (SCREEN/5)*4, MARGIN+800, (SCREEN/5)*4);          
    for(int x = 0; x <= 800; x+= 20)                                    //marks on x axis
    {     
      line(MARGIN+x, (SCREEN/5*4)+10, MARGIN+x, ((SCREEN/5)*4)-10);
    }
       
    //draw boxPlot   
    strokeWeight(3);
    textFont(boxPlotFont);
    line(minXPosition, yPositionOfLine - 30, minXPosition, yPositionOfLine + 30);        //min vertical line
    line(minXPosition, yPositionOfLine , q1XPosition, yPositionOfLine);                  //min-q1 l,horizontal ine
    fill(255,255,0);    
    rect(q1XPosition, yPositionOfLine -90,q1Width , 180);                                //q1-median rectangle   
    rect(medianXPosition, yPositionOfLine -90,q3Width, 180 );  //median-q3 rectangle   
    line(q3XPosition, yPositionOfLine, maxXPosition,yPositionOfLine);                    //q3-max horizontal line
    line(maxXPosition,yPositionOfLine - 30, maxXPosition, yPositionOfLine + 30);         //max vertical line
    
    //draws measurement lables
    fill(boxPlotColor);    
    text("Min", minXPosition-40, yPositionOfLine+55);
    text("Q1", q1XPosition-20, yPositionOfLine+ 110);
    text("Median", medianXPosition-15, yPositionOfLine + 130);
    text("Q3", q3XPosition+10, yPositionOfLine+110);
    text("Max", maxXPosition + 25, yPositionOfLine+55);
    
    //draws lables of the states that correspond to the measurements {min, q1, median, q3, max]
    fill(255,0,0);
    text(minText, minXPosition-90, yPositionOfLine-55);
    text(q1Text, q1XPosition-75, yPositionOfLine-110);
    text(medianText, medianXPosition-35, yPositionOfLine-170);
    text(q3Text, q3XPosition, yPositionOfLine-140);
    text(maxText, maxXPosition, yPositionOfLine-55);
    strokeWeight(1);
  }
  
  //(D.Madaghjian created function which sorts the list of States in the same order in which the cases arrayList is in , which is in ascending order, 3pm 5/4/21)
  //this allows us to find the corresponding state for each time we find min,q1,median,q3 and max  
  
  //(D.Madaghjina, created method which finds the state which corresponds to the minimum value in the arraylist statesChosen, 5:30pm 12/4/21)
  String getMinState(ArrayList <String> statesChosen, float minimum)
  {
    String state = "";
    if(!statesChosen.isEmpty())
    {     
        for(int i = 0; i < statesChosen.size(); i++)
        {
          if((float)dataFinder.getCasesOfCounty(statesChosen.get(i)) == minimum)
          {
            state = statesChosen.get(i);
          }
        }
    }
    return state;
  }
  
  //(D.Madaghjina, created method which finds the state which corresponds to the maximum value in the arraylist statesChosen, 5:30pm 12/4/21)
  String getMaxState(ArrayList <String> statesChosen, float maximum)
  {
    String state = "";
    if(!statesChosen.isEmpty())
    {
        for(int i = 0; i < statesChosen.size(); i++)
        {
          if((float)dataFinder.getCasesOfCounty(statesChosen.get(i)) == maximum)
          {
            state = statesChosen.get(i);
          }
        }
    }
    return state;
  }       
  
  //(D.Madaghjian, created method which gets the median of the data array, 3pm 4/4/21)
  float getMedian(int[] dataArray)
  {  
    if(dataArray!= null)
    {
      return (float)(dataArray[(dataArray.length - 1)/2]);    
    }
    return 0;
  }
  
  //(D.Madaghjina, created method which finds the state which corresponds to the median value in the arraylist statesChosen, 5:30pm 12/4/21)
  String getMedianState(ArrayList <String> statesChosen, float median)
  {
    String state = "";
    if(!statesChosen.isEmpty())
    {
        for(int i = 0; i < statesChosen.size(); i++)
        {
          if((float)dataFinder.getCasesOfCounty(statesChosen.get(i)) == median)
          {
            state = statesChosen.get(i);
          }
        }
    }
    return state;
  }
  
  //(D.Madaghjian, created method which gets q1 of the data array, 3pm 4/4/21)
  float getQ1(int[] dataArray)
  {   
    if(dataArray != null)
    {
      return (float)dataArray[Math.round((1*dataArray.length)/4)];  
    }
    return 0;
  }
  
  //(D.Madaghjina, created method which finds the state which corresponds to the q1 value in the arraylist statesChosen, 5:30pm 12/4/21)
  String getQ1State(ArrayList <String> statesChosen, float q1)
  {
    String state = "";
    if(!statesChosen.isEmpty())
    {
        for(int i = 0; i < statesChosen.size(); i++)
        {
          if((float)dataFinder.getCasesOfCounty(statesChosen.get(i)) == q1)
          {
            state = statesChosen.get(i);
          }
        }
    }
    return state;
  }
  
  //(D.Madaghjian, created method which gets q3 of the data array, 3pm 4/4/21)
  float getQ3(int[] dataArray)
  {     
    if(dataArray!= null)
    {      
      return (float) dataArray[Math.round((3*dataArray.length)/4)];
    }
    return 0;
  }
  
  //(D.Madaghjina, created method which finds the state which corresponds to the q3 value in the arraylist statesChosen, 5:30pm 12/4/21)
  String getQ3State(ArrayList <String> statesChosen, float q3)
  {
    String state = "";
    if(!statesChosen.isEmpty())
    {
        for(int i = 0; i < statesChosen.size(); i++)
        {
          if((float)dataFinder.getCasesOfCounty(statesChosen.get(i)) == q3)
          {
            state = statesChosen.get(i);
          }
        }
    }
    return state;
  }   
}

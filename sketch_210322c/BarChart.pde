//(H.Foley created barChart class and it's attributes, also researched how bar chart could be implemented 9:50am, 26/3/21) //<>// //<>// //<>// //<>//

class barChart {
  ArrayList buttonsPressedString;
  ArrayList buttonsPressedNumber;
  int barWidth;
  int xaxislength;
  int yaxislength;
  String categoryX;
  String categoryY;
  int [] dataArray;
  String []chartData;
  int minY; 
  int maxY;
  String[] allAreaData;
  ArrayList<Integer> casesInChosen=new ArrayList();
  String title;
  float multiplier;
  ArrayList <String> barTitleArray = new ArrayList <String> (); 

  //(H.Foley created constructor for barChart class, 28/03/21 12pm)
  //(H.Foley updated barChart class to take queries, 12:30pm, 2/4/21)
  barChart(query query) {
    ArrayList <String> buttonsPressedString = query.getButtonsPressedString();
    ArrayList <Integer> buttonsPressedNumber = query.getButtonsPressedNumber();
    if (buttonsPressedNumber != null) {
      //(C.MacMahon edited the code so that the barChart created is based off the options clicked in the drop down menu. 11/4/21 5pm)
      if (buttonsPressedNumber.get(1)==CHOSE_ALL_STATES)
      {
        //(H.Foley created a for loop which puts the data needed for the bar chart into a new array, instead of an arrayList 
        // so we can use the integer array to find max and min lengths needed to draw y axis this is used for bar length, 31/03/21 2pm)
        dataArray = new int [casesInStates.size()-1];
        for (int i = 0; i < dataArray.length; i++)
        {
          dataArray[i] = (int) casesInStates.get(i);
        }
        categoryX = "States";
        categoryY = "Cases";
        title = "Total cases per state";
        //(H.foley set current mutiplier to 0.5 in order to fit all bars on the screen with scaling, 2pm 31/3/21)
        multiplier = 0.5;
        
        //(H.Foley made for loop to create titles for the bottom of the bars, 1pm, 3/4/21)
        for (int i = 0; i < dataArray.length; i++)
        {
          String state=findstateforthisposition(i-1);
          String outputText=heatMap.ToAbreviation(state);
          barTitleArray.add(i, outputText);
        }
      } 
      // if the user chose to filter the states
      else if (buttonsPressedNumber.get(1)==CHOSE_A_STATE || totalPressed)
      {
        //C.MacMahon created an arraylist of strings to store all the states that the user wanted to filter 5/04/21 10am)
        // the arrayList was turned into an array in order to arrange the list in alphabetical order
        ArrayList <String>statesChosen=new ArrayList();
        // each state has the same event outcome- CHOSE_A_STATE==4
        for(int i=1;i<buttonsPressedNumber.size()&&buttonsPressedNumber.get(i)==4 ;i++)
        {
          // the states chosen are obtained from the buttonPressedString that was passed into the barChart class
          statesChosen.add(buttonsPressedString.get(i));
        }
        chartData=new String[statesChosen.size()];
        for(int i=0;i<chartData.length;i++)
        {
          chartData[i]=statesChosen.get(i);
        }
        // chartData stores the names of all the columns in the barChart- ie. the states chosen. these names are copied into the barTitleArray
        chartData=sort(chartData);
        // (C.MacMahon.the dataArray that stores the values to use in the bar chart was intialised and the total number of cases in each state chosen was
        // added to the data array. 05/05/21 11am)
        dataArray=new int[statesChosen.size()];
       for(int i=0;i<chartData.length;i++)
       {
         String stateInChosen=chartData[i];
         int casesInState=dataFinder.getCasesOfCounty( stateInChosen);
         dataArray[i]=casesInState;
         if (heatMap.ToAbreviation(stateInChosen)!="")
          {
            stateInChosen=heatMap.ToAbreviation(stateInChosen);
          }
         barTitleArray.add(i,stateInChosen);
       }
       multiplier=0.5;
       categoryX="States";
       title="Total cases in chosen states";
    }
      
      //else if the user selected particular state and area 
        if (timePressed){
          //(H.Foley created a for loop which puts the data needed for the bar chart into a new array, instead of an arrayList 
          // so we can use the integer array to find max and min lengths needed to draw y axis this is used for bar length, 31/03/21 2pm)
          dataArray = new int [12];
          dataArray = dataFinder.stateCaseFrequencyPerMonth(query.buttonsPressedString);
          categoryX = "Months";
          title = "Total cases per month ";
          multiplier = 0.25;
          //convert months of the year array into ArrayList for barTitleArray
          for (int i = 0; i < MONTHS_OF_THE_YEAR.length; i++)
          {
              barTitleArray.add(i, MONTHS_OF_THE_YEAR[i]);
          }
        }   
      
      //These variables are common no matter what data is entered into bar chart
      categoryY = "Cases";
      yaxislength = 900;
      xaxislength = 800;
      //(H.foley & C.MacMahon worked on barWidth variable which changes depending on th amount of bars which will be drawn on the screen. The x-axis always remains
      // the same size so the width of the bars will increase as less bars are needed
      if(dataArray.length<5)
      {
        barWidth=80;
      }
      else{
      barWidth =(xaxislength- (dataArray.length*SPACE_BETWEEN_BARS))/dataArray.length;
      }
    }
  }


  //H.Foley & C.MacMahon created draw 11am30/03/21 
  void draw() {
    if (!sun)
    {
      stroke(192, 192, 192);
      fill(255);
    } else
    {
      stroke(0);
      fill(0);
    }

    //draw and label the x axis 
    line(MARGIN, (SCREEN/5)*4, MARGIN+xaxislength, (SCREEN/5)*4);
    textFont(barChartFont);
    text(categoryX, MARGIN, (SCREEN/5)*4+MARGIN);

    //draw and label the y axis  
    line(MARGIN, 275, MARGIN,(SCREEN/5)*4);
    text(categoryY, MARGIN/3, (SCREEN/5)*4-(MARGIN*2));

    //draw title of barChart
    text(title, SCREEN/3, 275);
    //depending on the size of spaces in between etc
    int maxY = max(dataArray);
    for (int i = 0; i < dataArray.length; i++) 
    {
      //(if the numbers are too small, we are going to need to multiply them all by a constant value so 
      //that they dont just take up a few pixels on the screen, same goes for bigger numbers and making them smaller)
      //(H.Foley added map using function which allows the data to be mapped to the size of the bar chart and not be too big, 13/04/21)
      float ypos = (SCREEN/5)*4 - map(dataArray[i], 0, maxY, 0, 450);
      int xpos = MARGIN + (barWidth*i) + SPACE_BETWEEN_BARS*i;
      float height = (SCREEN/5)*4 - ypos;
      //drawing bars
      stroke(0);
      fill(barFillColor);
      rect(xpos, ypos, barWidth, height);
      //Bar colours change depending on the day/night theme chosen
      if (!sun)
      {
        fill(255);
      } else
      {
        fill(0);
      }
      //on top of bars, draw their numbers
      text(dataArray[i], xpos+(barWidth/5), ypos-10);
      //beneath bars, draw their names
      text(barTitleArray.get(i), xpos, 4*(SCREEN/5)+25);
    }
  }
  
  
  //(H.foley made findStateForThisPosition method 7pm 29/03/21)
  //to find the state name for a particular indedx in the state array
  String findstateforthisposition(int i)
  {
    if (i != -1){
    String state=allStatesAlphabetical[i];
    return state;
    }
    else return "";
  }

  //(H.foley made findStateForThisPosition method 7pm 29/03/21)
  //to get the sum of cases in that state
  //creates an array of all the states within the data set, avoidinf duplicating states 
  int getCasesForThisState(int i) {
    if (i != -1)
    {
      return (int) casesInStates.get(i);
    } else return i;
  }
}  

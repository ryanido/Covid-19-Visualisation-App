//(D.Madaghjian, Created the class DataFinder which allows you to find specific data relating to the dataSet file we added, 12pm 28/03/2021) //<>// //<>// //<>// //<>// //<>// //<>//

class DataFinder
{
  //(D.Madaghjian, Declared variables to be used within the class, 12pm 28/03/2021)
  ArrayList allData;
  int totalCases;
  int dPsInLastWeek;
  int lastWeeksCases;
  int lastMonthsCases;
  int dPsInLastMonth;
  String areaWithLargestCases;
  String countyWithLargestCases;
  String countyWithLargestArea;
  int casesOfLargestArea;

  String[] allareas;

  DataFinder(ArrayList dataSet)
  {
    allData = dataSet;
    getCasesPerState(allData);
  }
  //(H.foley made getCasesPerState method 7pm 29/03/21) - NOW IN DATAFINDER CLASS
  //each data point is accessed and then depending on the state name, the total sum of the cases for that state are added
  //to the cases array. Each index in the cases array corresponds to one of the 50 US states in alphabetical order
  //(C.MacMahon modified getCasesPerState method as the array previously got sorted into alphabetical order 10am, 30/03/21)
  // the function creates an arrayList of case numbers per state
  // It runs through the arrayList of states and when the current state in the states array matches the state in the current dataPoint, the number 
  // of cases is added to the exisitng cases of the current index in the cases arrayList
  //(C.MacMahon moved this function from the barChart class to this class and made the arrayList, casesInState a global variable. This code is now no longer repeated in barChart and boxPlot. 17/4/21 6pm)
  ArrayList getCasesPerState(ArrayList data) {
    for (int i = 0; i < allStatesAlphabetical.length; i++)
    {
      String stateForCases=allStatesAlphabetical[i];
      for (int index=0; index<data.size(); index++)
      {

        DataPoint currentDataPoint = (DataPoint) data.get(index);
        String state = currentDataPoint.getCounty();
        if (state.contains(stateForCases))
        {
          int casesInState=currentDataPoint.cases;
          if (casesInStates.size()==0)
          {
            casesInStates.add(i, casesInState);
          } else {
            int existingCases=casesInStates.get(i);
            existingCases=existingCases+casesInState;
            casesInStates.set(i, existingCases);
          }
        }
      }
      casesInStates.add(0);
    }
    return casesInStates;
  }

  //(D.Madaghjian, created method which finds the total Cases looping through the ArrayList dataSet, 1pm 28/03/2021)
  int getTotalCases()
  {
    if(allData != null)
    {
        for (int i=0; i<allData.size(); i++)                          
        {
          DataPoint currentDP = (DataPoint) allData.get(i);
          totalCases += currentDP.cases;
        }
    }
    return totalCases;
  }
  
  //(D.Madaghjian, created method which finds the number of dataPoints in the file cases(10k) in the final week, 5pm 4/4/21)
  void getDPsInLastWeek()
  {
    if(allData!= null)
    {
        DataPoint lastDP = (DataPoint) allData.get(allData.size() - 1);
        for(int i=0; i<allData.size(); i++)
        {     
          DataPoint currentDP = (DataPoint) allData.get(i);
          if(currentDP.convertDateToMonth() == lastDP.convertDateToMonth() && (currentDP.convertDateToDay() <= lastDP.convertDateToDay() && currentDP.convertDateToDay() > lastDP.convertDateToDay() - 7))
          {
            dPsInLastWeek++;
          }
        }
    }
  }
  
  //(D.Madaghjian, created method which calculates the total number of cases in the last week in the file cases(10k), 5pm 4/4/21)  
  int getLastWeeksCases()
  {
    if(allData!=null)
    {
        for(int i=1; i<dPsInLastWeek+1; i++) 
        {
          DataPoint currentDP = (DataPoint) allData.get(allData.size() - i);
          lastWeeksCases += currentDP.cases;
        }
    }
    return lastWeeksCases;
  }

  //(D.Madaghjian, created method which finds the number of datapoints present in the last month of the dataset, 1pm 28/03/2021)
  void getDPsInLastMonth()                     
  {
    if(allData!= null)
    {
        DataPoint lastDP = (DataPoint) allData.get(allData.size() - 1);
        for (int i=0; i<allData.size(); i++)
        {
          DataPoint currentDP = (DataPoint) allData.get(i);
          if (currentDP.convertDateToMonth() == lastDP.convertDateToMonth())
          {
            dPsInLastMonth++;
          }
        }
    }
  }

  //(D.Madaghjian, created method which finds the total number of cases in the last month of the dataset, 1pm 28/03/2021)
  int getLastMonthsCases()
  {   
    if(allData!=null)
    {
        for (int i=1; i<dPsInLastMonth+1; i++)                               
        {
          DataPoint currentDP = (DataPoint) allData.get(allData.size() - i);
          lastMonthsCases += currentDP.cases;
        } 
    }
    return lastMonthsCases;
  }
  //(C.MacMahon created this function that finds the county with the largest number of cases. 02/02/21 7pm)
  String getCountyLargestCases()
  {
    //this function gets the state with the largest numbers ussing the arrayList of cases from the barChart class
    String county="";
    int largest=0;
    for (int i=0; i<casesInStates.size(); i++)
    {
      int temp=casesInStates.get(i);
      if (temp>largest)
      {
        largest=temp;
        //allStates is an array of all the states in our data set
        county=allStatesAlphabetical[i];
      }
    }
    return county;
  }
  
  int getCasesOfCounty(String county)
  {
    int cases = 0;
    if(allData!=null)
    {
        for(int i=0; i< allData.size(); i++)
        {
          DataPoint currentDP = (DataPoint) allData.get(i);
          if(currentDP.county.equals(county))
          {
            cases += currentDP.cases;
          }
        }
    }
    return cases;
  }
   
   //(D.Madaghjian, created method which finds the county with the lowest cases, 5pm 4/4/21)
   String getCountyOfLowestCases()
   {
     String county="";
     if(!casesInStates.isEmpty() && allStatesAlphabetical!=null)
     {
         int lowest = casesInStates.get(0);
         for(int i =0; i<allStatesAlphabetical.length; i++)
         {
           int temp = casesInStates.get(i);
           if(temp<= lowest)
           {
             lowest = temp;
             county = allStatesAlphabetical[i];
           }
         }
     }
     return county;
   }    
 
  //(O.Idowu, Created method that gets area with largest cases in a county)
  String getAreaWithLargestCasesInCounty(String county)            
  {
    String tempAreaWithLargestCases = "Unknown";
    ArrayList<String> AreaSet = new ArrayList<String>();
    for (int i = 0; i< allData.size(); i++)                        //creates ArrayList of all the areas in the dataset
    {
      DataPoint currentDP = (DataPoint) allData.get(i);
      String tempCounty = currentDP.getCounty();
      if (tempCounty.contains(county))
      {
        if (AreaSet.isEmpty())
        {
          AreaSet.add(currentDP.getArea());
        } else if (!AreaSet.contains(currentDP.getArea()))
        {
          AreaSet.add(currentDP.getArea());
        }
      }
    }
    int largestCases=0;

    for (int i = 0; i<AreaSet.size(); i++)                          //finds the number of cases in each area and determines which area has the highest number of cases
    {
      String currentArea = AreaSet.get(i);
      int tmpLargestCases=0;
      for (int j = 0; j < allData.size(); j++)
      {
        DataPoint currentDP = (DataPoint) allData.get(j);
        if (currentDP.getArea().equals(currentArea) && currentDP.getCounty().equals(county))
        {
          tmpLargestCases += currentDP.getCases();
          if (tmpLargestCases > largestCases)
          {
            largestCases = tmpLargestCases;
            tempAreaWithLargestCases = currentDP.getArea();
          }
        }
      }
    }
    return tempAreaWithLargestCases ;
  }
  
  //(D.Madaghjian, created method which creates the widget ArrayList for the options we are going to display for the chart query, 11am 7/4/21)
  void widgetListForCharts()
  {
    int x=475;
    int y=250;
    int width=150;
    int height=50;   
    Widget chart1=new Widget(x, y, width, height, "barChart", color(255), barChartFont, 1);
    y=y+height;
    Widget chart2=new Widget(x, y, width, height, "boxPlot", color(255), barChartFont, 1);
    chartButtons.add(chart1);
    chartButtons.add(chart2);   
  }
  
  public int CountyCaseFrequency(String county, ArrayList dataSet)
  {
    int frequency = 0;
    String tempCounty;
    for (int i = 0; i < dataSet.size(); i++)
    {
      DataPoint currentDP = (DataPoint) dataSet.get(i);
      tempCounty = currentDP.getCounty();
      if (tempCounty.equals(county))
      {
        frequency+= currentDP.getCases();
      }
    }
    return frequency;
  }

  //(H.Foley made AreaCaseFrequencyPerMonth which sums up the amount of cases in the area over the year and returns an arrayList with the sum of the cases 
  //per month in the same index that month of the year corresponds to 8am 2/3/21), modeled off Daniel's methods above ^
    int[] areaCaseFrequencyPerMonth(ArrayList statesPressedString){
    int[] areaCaseFrequencyPerMonthArray = new int [12];
    for (int j = 0; j < statesPressedString.size(); j++){
        String state = (String) statesPressedString.get(j);
        for (int i = 0; i < allData.size(); i++)
        {
          DataPoint currentDP = (DataPoint) allData.get(i);
          String tempState = currentDP.getCounty();
          if (tempState.equals(state))
          {
              int month = currentDP.convertDateToMonth();
              //subtracting one from month because Array starts at 0
              month--; 
              int currentMonthFrequency = areaCaseFrequencyPerMonthArray[month];
              currentMonthFrequency += currentDP.getCases();
              areaCaseFrequencyPerMonthArray[month] = currentMonthFrequency;
          }
        }
    }
    return areaCaseFrequencyPerMonthArray;
  }

   //(H.Foley made StateCaseFrequencyPerMonth 
    int[] stateCaseFrequencyPerMonth(ArrayList statesPressedString){
    int[] stateCaseFrequencyPerMonthArray = new int [12];
    for (int j = 0; j < statesPressedString.size(); j++){
        String state = (String) statesPressedString.get(j);
        for (int i = 0; i < allData.size(); i++)
        {
          DataPoint currentDP = (DataPoint) allData.get(i);
          String tempState = currentDP.getCounty();
          if (tempState.equals(state))
          {
              int month = currentDP.convertDateToMonth();
              //subtracting one from month because Array starts at 0
              month--; 
              int currentMonthFrequency = stateCaseFrequencyPerMonthArray[month];
              currentMonthFrequency += currentDP.getCases();
              stateCaseFrequencyPerMonthArray[month] = currentMonthFrequency;
          }
        }
    }
    return stateCaseFrequencyPerMonthArray;
  }
  
  //(C.MacMahon created this function that returns the county with the highest state 01/04/21 8pm)
  String getCountyOfLargestCases()
  {
    //this function gets the state with the largest numbers ussing the arrayList of cases from the barChart class
    String county="";
    int largest=0;
    for (int i=0; i<casesInStates.size(); i++)
    {
      int temp=casesInStates.get(i);
      if (temp>largest)
      {
        largest=temp;
        //allStates is an array of all the states in our data set
        county=allStatesAlphabetical[i];
      }
    }
    return county;
  }
  //(C.MacMahon created this function that returns an arrayList of all the number of cases in each area within a given county, arranged in alphabetical order 01/04/21 8pm)
  ArrayList casesInAreasOfGivenState(ArrayList areaList, ArrayList allData, String county)
  {
    // all areas is an arrayList from the state class- its a list of all the areas within the county thats passed as a parameter
    allareas=new String[areaList.size()];
    areaCases=new ArrayList();
    for (int i=0; i<allareas.length; i++)
    {
      allareas[i]=(String)areaList.get(i);
    }
    allareas=sort(allareas);
    for (int i = 0; i < allareas.length; i++)
    {
      //areaCases is an array list of the total number of cases in each area of the allAreas array, the case number is at the same position in the 
      // areaCase arrayList as the arrayList for all the areas
      String areaInList=allareas[i];
      for (int index=0; index<allData.size(); index++)
      {
        DataPoint currentDataPoint = (DataPoint) allData.get(index);
        String state = currentDataPoint.getCounty();
        if (state.contains(county))
        {
          if (areaInList.contains(currentDataPoint.area))
          {
            int casesinarea=currentDataPoint.cases;
            if (areaCases.size()==0)
            {
              areaCases.add(i, casesinarea);
            } else {
              int existingCases=areaCases.get(i);
              existingCases=existingCases+casesinarea;
              areaCases.set(i, existingCases);
            }
          }
        }
      }
      areaCases.add(0);
    }
    return areaCases;
  }

//(C.MacMahon created this function that loops through the arrayList of total cases and reutrns the highest cases in the array of areas 01/04/21 8pm)
  int highestCasesInGivenAreas(ArrayList<Integer> areaCases)
  {
    int highestNumber=0;
    for (int i=0; i<areaCases.size(); i++)
    {
      int current=areaCases.get(i);
      if (current>highestNumber)
      {
        highestNumber=current;
      }
    }
    return highestNumber;
  }
  
//(C.MacMahon created this function that returns the area that corresponds to the value of cases passed as a parameter 01/04/21 8pm)
  String areaOfCasesPassed(int highest)
  {
    String highestArea="";
    for (int i=0; i<areaCases.size(); i++)
    {
      if (highest==areaCases.get(i))
      {
        highestArea=allareas[i];
        return highestArea;
      }
    }
    return highestArea;
  }
} 

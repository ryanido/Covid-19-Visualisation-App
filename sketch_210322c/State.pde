class State {
  //(C.MacMahon created a class State that has two functions that creates an arrayList for all the states in the data set and an ArrayList for 
  // all the areas in a state, depending on the state parameter passed, 27/03/21 4pm)

  //(C.MacMahon created this function that returns an arrayList of all the states that appear in the data set 27/03/21 4pm)
  ArrayList allStates(String currentState)
  {
    boolean add=true;
    if (statesArray.size()==0 && statesArray!=null)
    {
      statesArray.add(currentState);
    } else
    {
      for (int i=0; i<statesArray.size(); i++)
      {
        String exisiting= (String) statesArray.get(i);
        if (exisiting.contains(currentState))
        {
          add=false;
        }
      }
      if  (add==true)
      {
        statesArray.add(currentState);
      }
      add=true;
    }
    return statesArray;
  }
  //(C.MacMahon created a function that makes an array of all the states in alphabetical order. 17/4/21 6pm)
  String [] allStatesAlphabetical()
  {
    allStatesAlphabetical=new String[statesArray.size()];
    // (C.MacMahon converted the arraylist of states created in the state class into an array,
    //that can then be sorted alphabetically, 29/03/21, 3pm)
    for (int i=0; i<allStatesAlphabetical.length; i++)
    {
      String exist=statesArray.get(i);
      allStatesAlphabetical[i]=exist;
    }
    allStatesAlphabetical=sort(allStatesAlphabetical);

    return allStatesAlphabetical;
  }

  // (C.MacMahon, this function that creates an arrayList of the areas within the state that is passed to this function, 27/03/21 4pm)
  ArrayList getAreas(String county, ArrayList <String>returnResult)
  {
    boolean add=true;
    for (int i=0; i<allData.size(); i++)
    {
      DataPoint tester= (DataPoint) allData.get(i);
      String currentCounty=tester.county;
      if (currentCounty.contains(county))
      {
        String takenArea=tester.area;
        if (returnResult.size()==0)
        {
          returnResult.add(takenArea);
        } else {
          for (int index=0; index<returnResult.size(); index++)
          {
            if (takenArea.contains(returnResult.get(index)))
            {
              add=false;
            }
          }
          if (add==true)
          {
            returnResult.add(takenArea);
          }
          add=true;
        }
      }
    }
    return returnResult;
  }
  //(C.MacMahon created this function that creates an arrayList of widgets for all the states in the data 03/03/21 11am)
  void widgetListForStates()
  {
    int x=0;
    int y=250;
    int width=150;
    int height=50;
    int event=CHOSE_A_STATE;
    for (int i=0; i<allStatesAlphabetical.length; i++)
    {
      String state=allStatesAlphabetical[i];
      Widget tempory=new Widget(x, y, width, height, state, 255, barChartFont, event);
      countyButtons.add(tempory);
      y=y+height;
      if (y>(SCREEN/3)*2)
      {
        y=250;
        x=x+width;
      }
    }
    //(C.MacMahon added the button in the drop down menu that allows the user to view a barChart for all the states. 11/04/21 5pm)
    Widget allStates=new Widget(x, y, width, height, "all states", 255, barChartFont, CHOSE_ALL_STATES);
    countyButtons.add(allStates);
  }
  //(C.MacMahon created this function that adds the query to the list of queries if a state has been picked. 03/04/21 11am)
  void checkClicked()
  {
    for (int i=0; i<countyButtons.size(); i++)
    {
      tempHolderForState=countyButtons.get(i);
      if (tempHolderForState.changeButtonColour==true)
      {
        //(C.MacMahon updated this method to include the allstates option 11/4/21 10pm)
        if (tempHolderForState.label=="all states")
        {
          query.addToLists(tempHolderForState);
          for (int index=0; index<countyButtons.size(); index++)
          {
            query.addToLists(countyButtons.get(index));
          }
        } else {
          query.addToLists(tempHolderForState);
        }
      }
    }
  }
}

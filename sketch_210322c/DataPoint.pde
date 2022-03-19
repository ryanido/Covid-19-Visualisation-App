//O.Idowu, created DataPoint class for datapoints initialised with the variables in the dataset(date, country etc.), 7pm, 23/03/2021
class DataPoint {
  String date;
  String area;
  String county;
  int geoid;
  int cases;
  String country;
  PFont font;
//O.Idowu, added constructor that takes in the variables as parameters and sets the datapoint object's variables to them, 7pm, 23/03/2021
  DataPoint( String date, String area, String county, int geoid, int cases, String country, PFont fontType)
  {
    this.date=date;
    this.area=area;
    this.county=county;
    this.geoid = geoid;
    this.cases=cases;
    this.country=country;
    this.font=fontType;
  }
 //O.Idowu, created method that returns all of the object's variables together as a string, 7pm, 23/03/2021  
  String getCounty() 
  {
    return county;
  }
  int getCases()
  {
    return cases;
  }
  
  //(H.foley created a method that returns area 8am, 3/4/21)
  String getArea()
  {
    return area;
  }
  
//O.Idowu, created method that returns all of the object's variables together as a string, 7pm, 23/03/2021  
  String toStringForm()
  {
     return date + area + county + geoid + cases + country;
  }
  
  //(D.Madaghjian, created method that returns month number (1-12) of current DataPoint which is used to find last weeks cases for bottomOfScreen, 4:30pm, 4/4/21)
  int convertDateToMonth()
  {
    String[] dateSplit = date.split("/");
    int month = Integer.parseInt(dateSplit[1]);
    return month;
  }   
  
   //(D.Madaghjian, created method that returns day number (1-31) of current DataPoint which is used to find last weeks cases for bottomOfScreen, 4:30pm, 4/4/21)
  int convertDateToDay()
  {
    String[] dateSplit = date.split("/");
    int day = Integer.parseInt(dateSplit[0]);
    return day;
  } 
}

//(H.Foley Created the query class which will take in an array list of the buttons pressed as both strings and integers to determine what
// data can be sent into the chart classes , 9:30am 26/03/21)

class query {
  ArrayList <String> buttonsPressedString;
  ArrayList <Integer> buttonsPressedNumber;
  
  query(){
    buttonsPressedString = null;
    buttonsPressedNumber = null;
  }
  
  query(ArrayList buttonsPressedString, ArrayList buttonsPressedNumber)
  {
     this.buttonsPressedString = buttonsPressedString;
     this.buttonsPressedNumber = buttonsPressedNumber;
  }
  
  //(H.Foley added addToLists method so that the lists can be made within the query class rather than sending pre made array lists in 31/03/21 4:30pm)s
  void addToLists(Widget buttonPressed){
    if (buttonsPressedNumber == null){
      buttonsPressedNumber = new ArrayList();
    }
    if (buttonsPressedString == null){
       buttonsPressedString = new ArrayList(); 
    }
    buttonsPressedNumber.add(buttonPressed.event);
    buttonsPressedString.add(buttonPressed.label);
  }
  
  //(H.Foley added functions which return the arrayLists
    ArrayList getButtonsPressedString(){
    return buttonsPressedString;
  }
  
  ArrayList getButtonsPressedNumber(){
      return buttonsPressedNumber;
  }
  
  //(D.Madaghjian, created method which clears the two arrayLists which contain the buttons pressed to be used for the graphs. This is called when the reset button is pressed on the screen. 5pm 9/4/21)
  
  void clearButtonsClicked()
  {
    if(buttonsPressedString != null && buttonsPressedNumber != null)
    {
      buttonsPressedString.clear();
      buttonsPressedNumber.clear();
    }
  }
}

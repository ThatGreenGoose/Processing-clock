//Glenn Houghton Weather Clock V1.10.2

//pre setup
PFont font;
PImage photo;
JSONObject json;
int seconds=second();

void setup() {
background(0,0,0);
noCursor();
fullScreen();
imageMode(CENTER);
textAlign(CENTER);
font=createFont("TrebuchetMS-Bold-48",48);
println(width);
println(height);
}//end of setup method
int time() {
int hour=hour();
int hourUS;
int minute=minute();
String[] timeOut = new String[4];
String outString="";
//hour format
  if (hour>11) {
    timeOut[3]="Pm";
    hourUS=hour-12;
    timeOut[0]=""+hourUS;
  if(hourUS==0){
    timeOut[0]=""+12;
      }}//end of PM if statement 
  else {
    timeOut[3]="Am";
  if(hour==0){
    hour=12;
    }//end of midnight fix if Statement
    timeOut[0]=""+hour;
     }//end of else
timeOut[1]=":";
  //minute format
  if (minute<10) {
    timeOut[2]="0"+minute;
  }//end of small minute formatting
  else {
    timeOut[2]=""+minute;
  }//end of else     
//printing
for (int i=0; i<timeOut.length; i++) {
  outString=outString+timeOut[i];
fill(255, 255, 255);
textFont(font, width/5);
    }//end of print
text(outString,width/2 ,height/2);  

return minute;
 }//end of method

void date() {  //date
fill(255,255,255);
String outString="";
String[]dateOut=new String[5];
dateOut[0]=""+month();
dateOut[1]="/";
dateOut[2]=""+day();
dateOut[3]="/";
dateOut[4]=""+year();
for(int i=0;i<dateOut.length;i++){
outString=outString+dateOut[i];
textFont(font,width/14);
  }//end of loop
text(outString,width/3,height/3+height/3.3);

}//end of method

void temperture(int temp){
  fill(255,255,255);
String outString=temp+"°F";
//display
textFont(font,width/14);
text(outString,width/3+width/2.5,height/3+height/3.3);
 }//end of method
 
void weatherDisplay(int id){
//thunder
  if(id==200||id==201||id==202||id==210||id==211||id==212
||id==221||id==230||id==231||id==232){
photo=loadImage("Thunder.png");
photo.resize(width/12,height/8);
image(photo,width/4+width/2.8,height/2.5+height/5);
}//end of if
//rain
  else if(id==300||id==301||id==302||id==310||id==311||id==312||id==313||id==314
||id==321||id==500||id==501||id==502||id==503||id==504||id==511||id==520
||id==521||id==522||id==531){
photo=loadImage("Rain.png");
photo.resize(width/12,height/8);
image(photo,width/4+width/2.8,height/2.5+height/5);
}//end of elseif
//snow
else if(id==600||id==601||id==602||id==611||id==612||id==613
||id==615||id==616||id==620||id==621||id==622){
photo=loadImage("Snow.png");
photo.resize(width/12,height/8);
image(photo,width/4+width/2.8,height/2.5+height/5);
}//end of elseif
//fog
else if(id==701||id==711||id==721||id==731||id==741||id==751
||id==761||id==762||id==771||id==781){
photo=loadImage("Fog.png");
photo.resize(width/12,height/8);
image(photo,width/4+width/2.8,height/2.5+height/5);
}//end of elseif
//partly cloudy
else if(id==801||id==802){
photo=loadImage("Partly_Cloudy.png");
photo.resize(width/12,height/10);
image(photo,width/4+width/2.8,height/2.5+height/5);
}//end of elseif
//Cloudy
else if(id==803||id==804){
photo=loadImage("Cloudy.png");
photo.resize(width/12,height/8);
image(photo,width/4+width/2.8,height/2.5+height/5);
}//end of elseif
else{
photo=loadImage("Sunny.png");
photo.resize(width/12,height/10);
image(photo,width/4+width/2.8,height/2.5+height/5);
}//end of else
}//end of method
   
int loadTemp(){
json = loadJSONObject("");//openweathermaps api key goes here
JSONObject main = json.getJSONObject("main");
int temp=main.getInt("temp");
return temp;
}
int loadID(){
  JSONArray IDCode=json.getJSONArray("weather");
 JSONObject weather = IDCode.getJSONObject(0); 
int id = weather.getInt("id");
return id;
}
String loadCondition(){
  //call conditions
  JSONArray IDCode=json.getJSONArray("weather");
 JSONObject weather = IDCode.getJSONObject(0); 
String description = weather.getString("description");
//format description
String output;
char first=description.charAt(0);
output=""+first;
output=output.toUpperCase();
output=output+description.substring(1);
return output;
}
void conditionDisplay(String output){   
    fill(255, 255, 255);
  textFont(font, width/25);
 text(output,width/2.8+width/3 ,height/3+height/2.73);  
}

void getData(int minute,int seconds){
  if(minute%5==0&&seconds%5==0){
refresh(1);
      temperture(loadTemp());//loadtemp
 weatherDisplay(loadID());
conditionDisplay(loadCondition());
 }
 else{time();
 }}
 void refresh(int type){
  rectMode(CORNERS);
  if(type==0){
  fill(0,0,0);
  rect(0,0,width,height/1.9);//time

  }
  else{
      fill(0,0,0);
  rect(width/2,height/1.9,width,height);
  }
 }
void draw() {
  seconds=second();

  try{
        refresh(0);
   getData(time(),seconds);//must be before display.contains a full refresh
  date();

} 
catch(NullPointerException e){
   refresh(0);
  date();
  time();
}

}

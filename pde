//Screen Size
int width = 500;
int height = 400;


//Colour Variables

//Background Colour
float backR = 0;
float backG = 204;
float backB = 204;
//Initial Colour of the Fish (Purple)
int fishR = 204;
int fishG = 153;
int fishB = 255;
//Initial Colour of the Tail (Light Purple)
int tailR = 229;
int tailG = 204;
int tailB = 255;


//Variables for the Fish Drawing X and Y coordinates

//Starting Point of Fish
int fishX = 0;
float fishY = height/2;
//Initial Fish Radius
float fishRadius = 68;
// X Value for Front of Fish
float fishFront = fishX + fishRadius/2;
//Angle Between Connecting Points (from centre)
final float angleOfChange = 0.2;


//Bubbles Variables

//Initial Point for Bubble from Mouth (fishY)
float bubblesUp = fishY;
// Randomises amount of bubbles between 1 (inclusive) and 5 (exclusive)
int numOfBubbles = (int) random(1,5);


//Barrier Gap Distance Variables

//Gap Length
int barrierSpace = 110;
//Barrier Width
int barrierX = width - width/8;
//Top Barriers Bottom Point
int topBarrier = height/2 - barrierSpace/2;
//Bottom Barriers Top Point
int bottomBarrier = height/2 + barrierSpace/2;

// Score Text and Initial Value
PFont scoreFont;
int score = 0;

void setup(){
  size(500, 400);
  background(backR,backG,backB);
}

void draw(){
  background(backR,backG,backB); 

   
  //Draws Spikes Around the Fishes Body
  
  //Radius for the Connecting Points
  //It is Smaller than the Fish Radius, so the Spikes Appear to be Touching the Fishes Body (smaller spikes)
  float fishSpikesRadius = fishRadius/2.2;
  
  //Radius for the Outside Points
  float imaginaryRadius = fishSpikesRadius*1.2;
  
  //Initial Starting Point of Spikes
  float initialPointX = fishX + fishSpikesRadius * cos(0);
  float initialPointY = fishY + fishSpikesRadius * sin(0);
  
  //Colour of Spikes
  stroke(0);
  
  //The following Loop Continues Drawing Spikes around the Fishes Body, Using Basic Notions of Trig
  //Increaseing the Angle Until it Completes a 360
  for(float angle=angleOfChange; angle<=2*PI; angle+=angleOfChange) {
    float nextPointX = fishX + fishSpikesRadius * cos(angle);
    float nextPointY = fishY + fishSpikesRadius * sin(angle);
    
    //Connecting Point is Half Way Between the Two Points (angle - angleOfChange/2)
    float connectingPointX = fishX + imaginaryRadius * cos(angle - angleOfChange/2);
    float connectingPointY = fishY + imaginaryRadius * sin(angle - angleOfChange/2);

    // Draws Spike (Connecting lines from Initial point and Next Point to the Connecting point)
    line(initialPointX, initialPointY, connectingPointX, connectingPointY);
    line(nextPointX, nextPointY, connectingPointX, connectingPointY);

    //New Initial Point, set to Next Point in order to Continue Around the Circle.
    initialPointX = nextPointX;
    initialPointY = nextPointY;
  }
  
  
  // Drawing the Fishes Body and Tail
  
  // Tail Colour
  stroke(0);
  fill(tailR,tailG,tailB);
  
  //Dimensions of Fishes Tail are Determined by the Radius and Position of the Fish
  float tailX = fishX - fishRadius/3;
  float tailY = fishY;
  int tailLength = 26;
  triangle(tailX,tailY,tailX-tailLength,tailY-14,tailX-tailLength,tailY+14);
 
  //Colour and Dimensions of the Fishes Body
  stroke(0);
  fill(fishR,fishG,fishB);
  ellipse(fishX,fishY,fishRadius,fishRadius);
  
  //Colour and Dimensions of the Fishes Eye
  stroke(255);
  fill(255);
  ellipse(fishX+13,fishY-11,12,15);
  stroke(0);
  fill(0);
  ellipse(fishX+14,fishY-9,6,6);
  
  
  // Increment the fishX Coordinate; Moves the Fish Along the Screen
  fishX++;
  
  
  //Draws Barrier
  
  // Colour of Barrier
  int barrierR = 51;
  int barrierG = 153;
  int barrierB = 255;
  stroke(barrierR, barrierG, barrierB);
  fill(barrierR, barrierG, barrierB);
  
  //Dimentions of Barriers (Top and Bottom)
  rect(barrierX, 0, width/8, topBarrier);
  rect(barrierX, bottomBarrier, width/8, bottomBarrier);
  
  
  //If Fish Hits Barrier then Randomise New Start Position and Decrease Score
  if (fishX + fishRadius/2 >= barrierX){
    if (!(fishY - fishRadius/2 >= topBarrier && fishY + fishRadius/2 <= bottomBarrier)){
      fishX = (int) random(1,width/2);
      fishY = (int) random(1,height);
      score = score - 1;
    }
  }
  if(fishX - 68/2 - tailLength == width){
    //Increase Score if Fish went Through the Gap in the Barrier  
    score = score + 1;
  } 

  
  //Display Score
  
  // Select Font
  scoreFont = createFont("Georgia", 20);
  // Select Text Font
  textFont(scoreFont);
  textAlign(CENTER, CENTER);
  text(score, 20, 20);

  
  //Draws a random amount of bubbles
  
  // Continues until numOfBubbles is complete
  // Increases Y function by 10 pixels, so the new bubble appears above the other
  for(int newBubble = numOfBubbles*10 - 10 ; newBubble >= 0; newBubble = newBubble - 10){
    noFill();
    stroke(255);
    ellipse(fishFront, bubblesUp - newBubble, 7, 7);
  }
  
  // Moves bubbles upwards every second pass (slower)
  bubblesUp = bubblesUp - 1;
  
    
  
  // Animates Colour and Size
 
  //Slows the Change of Colour and Size to be Relative to Moving Fish  
  if (fishX % 20 == 0){
    //Randomizes the Fishes Size (Radius)
    fishRadius = (int) random(65,73);
    //Randomises the Fishes Colour
    int fishColour = (int) random(4);
    if (fishColour == 0){
      //Same as Initial Colour (Purple)
      fishR = 204;
      fishG = 153;
      fishB = 255;
      // Light Purple
      tailR = 229;
      tailG = 204;
      tailB = 255;
    } else if (fishColour == 1){
      // Pink
      fishR = 255;
      fishG = 153;
      tailR = 255;
      tailG = 204;
    } else if (fishColour == 2){
      // Blue 
      fishR = 153;
      fishG = 204;
      tailR = 204;
      tailG = 229;
    } else if (fishColour == 3){
      // Light Blue
      fishR = 153;
      fishG = 255;
      tailR = 204;
      tailG = 255;
    }
  }
}


//Movement Up and Down

void keyPressed(){
  //Randomises Movement between 20 (inclusive) and 60 (exlusive)
  int fishMovement = (int) random(20,60);
  int oppositeMovement = (int) random(9);
  // Keys Fuction When Fish is Visible On Screen - Can't Hit Barrier After Passing Through
  if (fishX - 68/2 - 26 < width){
    if (keyCode == UP){
      if (oppositeMovement > 2){
        // Fish Moves Towards the Top (Y = 0)
        fishY = fishY - fishMovement;
      } else {
        // Fish Moves in Wrong Direction Towards the Bottom (Y = 400)
        fishY = fishY + fishMovement;
      }
    } else if (keyCode == DOWN){
      if (oppositeMovement > 2){
        //Fish Moves Towards the Bottom (Y = 400)
        fishY = fishY + fishMovement;
      } else {
        // Fish Moves in Wrong Direction Towards the Top (Y = 0)
        fishY = fishY - fishMovement;
      }
    }
  }
}

void mousePressed() {   
  if(mouseX<= width/2 && !(mouseY >= topBarrier  && mouseY <= bottomBarrier)){
    fishX=mouseX;   // Setting the new value of fishX, where the mouse was clicked
    fishY=mouseY;  // Setting the new value of fishY, where the mouse was clicked
    
    //Resets Bubble Variables
    bubblesUp = fishY;
    fishFront = fishX + fishRadius/2;
    numOfBubbles = (int) random(1,5);
  }
}

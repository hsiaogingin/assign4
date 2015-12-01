PImage start1;
PImage start2;
PImage end1;
PImage end2;
PImage bg1;
PImage bg2;
PImage enemy;
PImage fighter;
PImage hp;
PImage treasure;


float hpX;
float treasureX;
float treasureY;
float bgFirstX;
float bgSecondX;
float fighterX;
float fighterY;

final int START=1;
final int RUN=2;
final int END=3;
int state;

float speed = 5;
float [] enemyFirstX = new float [5];
float [] enemyFirstY = new float [5];
float [] enemySecondX = new float [5];
float [] enemySecondY = new float [5];
float [] enemyThirdX = new float [8]; 
float [] enemyThirdY = new float [8];
float enemySpeed = 5;
float detectFirst;
float detectSecond;
float detectThird;
PImage[] flame= new PImage [5];
int numFrame=5;
int currentFrame;

boolean upPressed=false;
boolean downPressed=false;
boolean leftPressed=false;
boolean rightPressed=false;

void setup () {
size(640,480) ;  
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");
  end1 = loadImage("img/end1.png");
  end2 = loadImage("img/end2.png");
  bg1 = loadImage("img/bg1.png");  
  bg2 = loadImage("img/bg2.png");
  treasure = loadImage("img/treasure.png");
  enemy = loadImage("img/enemy.png");
  bgFirstX = 0;
  bgSecondX = -641;
  treasureX = random(600);
  treasureY = random(440);

  state = START;
    
    
  for(int i=0; i<5; i++){
    enemyFirstX[i] = 0-i*61;
    enemySecondX[i] = (0-640-61*5)-i*61;
  }
  //first and second enemy team


  for(int i=0; i<8; i++){
     if (0<=i && i<=4){
      enemyThirdX[i] = (0-640-61*5)*2-i*61;
    }else if(5<=i && i<=7){
      enemyThirdX[i] = (0-640-61*5)*2-(i-4)*61;
    }
  }
  //third enemy team
  

  detectFirst = enemyFirstX[4];
  detectSecond = enemySecondX[4];
  detectThird = enemyThirdX[4];
 
 
  enemyFirstY[0] = random(420);
  enemySecondY[0] = random(175); //480-61*5=175
  enemyThirdY[0] = random(122,297); //61*2=128; 480-61*3=297 

 
  for(int i=1; i<5; i++){
    enemyFirstY[i] = enemyFirstY[0];
    enemySecondY[i] = enemySecondY[0]+i*61;
  }


  enemyThirdY[1]= enemyThirdY[0]-61*1;
  enemyThirdY[2]= enemyThirdY[0]-61*2;
  enemyThirdY[3]= enemyThirdY[0]-61*1;
  enemyThirdY[4]= enemyThirdY[0];
  enemyThirdY[5]= enemyThirdY[0]+61*1;
  enemyThirdY[6]= enemyThirdY[0]+61*2;
  enemyThirdY[7]= enemyThirdY[0]+61*1;
  
 
  fighter = loadImage("img/fighter.png");
  fighterX = 560;
  fighterY = 240;
 
  
  fill(#CC0000);
  hpX = (205-10)*20/100; //10<=hpX<=205, at least 20 points of blood 
  
  hp = loadImage("img/hp.png"); 
  
}

void draw() {
  if(hpX>205){
    hpX=205;}
switch (state){
    case START:
      image(start2, 0, 0);
      //mouse detecting
      if (mouseX >= width*95/300 && mouseX <= width*215/300 &&
          mouseY >= height*390/500 && mouseY <= height*435/500){
          image(start1, 0, 0);
      }else{
        image (start2, 0, 0);
      }
      //click to start
      if (mousePressed){
        if (mouseX >= width*95/300 && mouseX <= width*215/300 && 
            mouseY >= height*390/500 && mouseY <= height*435/500){
            state = RUN;
          }
      }
      break;
      
      
      
      
      
    case RUN:
    
      image(bg1, bgFirstX, 0);
      image(bg2, bgSecondX, 0);
      bgFirstX++;
      bgSecondX++;
      
      if (bgFirstX >= 641){
        bgFirstX = -641;
      }
      if (bgSecondX >= 641){
        bgSecondX = -641;
      } 
       
      
      image(treasure, treasureX, treasureY);
      //treasure
      
      
      //enemy
      //first team
      detectFirst += enemySpeed; 
     if(detectFirst>=640){
        enemyFirstY[0] = random(420);
        enemyFirstY[1]=enemyFirstY[0];
        enemyFirstY[2]=enemyFirstY[0];
        enemyFirstY[3]=enemyFirstY[0];
        enemyFirstY[4]=enemyFirstY[0];
     }

     for(int i=0; i<5; i++){
       image(enemy, enemyFirstX[i], enemyFirstY[i]);
       enemyFirstX[i] += enemySpeed;   
       if(enemyFirstX[i]>=640){   // X go back
          enemyFirstX[i]=0-640*2-61*5*3; 
       }   
       if(detectFirst >=640){   //reset Y
         detectFirst = 0-640*2-61*5*3;
       }
     } 
         
      //second team 
     detectSecond += enemySpeed;  
     if(detectSecond>=640){    
        enemySecondY[0] = random(175);
        enemySecondY[1]=enemySecondY[0]+61;
        enemySecondY[2]=enemySecondY[0]+61*2;
        enemySecondY[3]=enemySecondY[0]+61*3;
        enemySecondY[4]=enemySecondY[0]+61*4;
       }   
          
     for(int i=0; i<5; i++){
       image(enemy, enemySecondX[i], enemySecondY[i]); 
       enemySecondX[i] += enemySpeed; 
       if(enemySecondX[i]>=640){
         enemySecondX[i]=0-640*2-61*5*3; //X go back
       }
       if( detectSecond >= 640){  //reset Y
        detectSecond = 0-640*2-61*5*3;
       }
     }

     
     //third team
     detectThird += enemySpeed;
     if(detectThird>=640){ 
       enemyThirdY[0] = random(122, 297);
       enemyThirdY[1]= enemyThirdY[0]-61*1;
       enemyThirdY[2]= enemyThirdY[0]-61*2;
       enemyThirdY[3]= enemyThirdY[0]-61*1;
       enemyThirdY[4]= enemyThirdY[0];
       enemyThirdY[5]= enemyThirdY[0]+61*1;
       enemyThirdY[6]= enemyThirdY[0]+61*2;
       enemyThirdY[7]= enemyThirdY[0]+61*1; 
     } 
              
     for(int i=0; i<8; i++){
       image(enemy, enemyThirdX[i], enemyThirdY[i]);
       enemyThirdX[i] += enemySpeed;
       if(enemyThirdX[i]>=640){   
         enemyThirdX[i] = 0-640*2-61*5*3; //X go back
       }
       if(detectThird >= 640){  //reset Y
         detectThird = 0-640*2-61*5*3;
       }
     }  
    
      //fighter
      image(fighter, fighterX, fighterY); 
      if (upPressed){
        fighterY -= speed; 
      }
      if (downPressed){
        fighterY += speed;
      }
      if (leftPressed){
        fighterX -= speed;
      }
      if (rightPressed){
        fighterX += speed;
      }
      if (fighterX>580){
        fighterX = 580;
      }
      if (fighterX<10){
        fighterX = 10;
      }
      if (fighterY>420){
        fighterY = 420;
      }
      if (fighterY<10){
        fighterY = 10;
      }
      
      //hp
      fill(#CC0000);
      rectMode(CORNERS);
      rect(10,4.2,hpX,24);
      image(hp, 0, 0); 
      if(hpX>=205){
       hpX=205;
      }

      
         //First
       for(int i=0; i<5 ; i++){ 
         if ( abs((fighterX+51.0/2)-(enemyFirstX[i]+61.0/2)) <= 56 && 
              abs((fighterY+51.0/2)-(enemyFirstY[i]+61.0/2)) <= 56){
              hpX = hpX - (205-10)*20/100; 
              enemyFirstX[i] = (0-640*2-61*5*3) - (640-enemyFirstX[i]); // disappear, go back earlier, but match the team
         }
         
         //Second
         if ( abs((fighterX+51.0/2)-(enemySecondX[i]+61.0/2)) <= 56 && 
              abs((fighterY+51.0/2)-(enemySecondY[i]+61.0/2)) <= 56){
              hpX = hpX - (205-10)*20/100;
              enemySecondX[i] = (0-640*2-61*5*3) - (640-enemySecondX[i]); // disapper, go back earlier, but match the team
         }
       }
       
         //Third
         for(int i=0; i<8 ; i++){
           if ( abs((fighterX+51.0/2)-(enemyThirdX[i]+61.0/2)) <= 56 && 
                abs((fighterY+51.0/2)-(enemyThirdY[i]+61.0/2)) <= 56){
                hpX = hpX - (205-10)*20/100;
                enemyThirdX[i] = (0-640*2-61*5*3) - (640-enemyThirdX[i]); // disappear, go back earlier, but match the team
           }
         }   
      

     //detect fighter and treasure
     if(abs((fighterX+51.0/2)-(treasureX+41.0/2))<=46 &&
        abs((fighterY+51.0/2)-(treasureY+41.0/2))<=46)
        {
       if(hpX<=205){hpX = hpX + (205-10)*10/100;} // add blood 10%
       treasureX = random(600); 
       treasureY = random(440);
       }
       
     

     if (hpX <= 10){
       state = END;
       //reset all
       for(int i=0; i<5; i++){ 
            enemyFirstX[i] = 0-i*61;
            enemySecondX[i] = (0-640-61*5)-i*61;
       }


      for(int i=0; i<8; i++){
         if (0<=i && i<=4){
            enemyThirdX[i] = (0-640-61*5)*2-i*61;
         }else if(5<=i && i<=7){
            enemyThirdX[i] = (0-640-61*5)*2-(i-4)*61;
         }
      }
      

      detectFirst = enemyFirstX[4];
      detectSecond = enemySecondX[4];
      detectThird = enemyThirdX[4];
 

      enemyFirstY[0] = random(420);
      enemySecondY[0] = random(175); //480-61*5=175
      enemyThirdY[0] = random(122,297); //61*2=128; 480-61*3=297 
      

    for(int i=1; i<5; i++){
      enemyFirstY[i] = enemyFirstY[0];
      enemySecondY[i] = enemySecondY[0]+i*61;
    }



    enemyThirdY[1]= enemyThirdY[0]-61*1;
    enemyThirdY[2]= enemyThirdY[0]-61*2;
    enemyThirdY[3]= enemyThirdY[0]-61*1;
    enemyThirdY[4]= enemyThirdY[0];
    enemyThirdY[5]= enemyThirdY[0]+61*1;
    enemyThirdY[6]= enemyThirdY[0]+61*2;
    enemyThirdY[7]= enemyThirdY[0]+61*1;
       
    hpX = (205-10)*20/100;
    fighterX = 589;
    fighterY = 214.5;
}
     
     break;
          
      
 case END:
       treasureX = random(600);
       treasureY = random(440);
      image(end2, 0, 0);
      if (mouseX >= width*96/300 && mouseX <= width*205/300 && mouseY >= height*257/400 && mouseY <= height*292/400){
        image(end1, 0, 0);
      }else{
        image(end2, 0, 0);
      }
      if (mousePressed){
        if (mouseX >= width*96/300 && mouseX <= width*205/300 && 
            mouseY >= height*257/400 && mouseY <= height*292/400){
            state = RUN;
          }
      }
  }
}


void keyPressed(){
  if (key==CODED){
    switch(keyCode){
      case UP:
        upPressed = true;
      break;
      case DOWN:
        downPressed = true;
      break;
      case LEFT:
        leftPressed = true;
      break;
      case RIGHT:
        rightPressed = true;
      break;
    }
  }
}


void keyReleased(){
  if (key==CODED){
      switch(keyCode){
        case UP:
          upPressed = false;
        break;
        case DOWN:
          downPressed = false;
        break;
        case LEFT:
          leftPressed = false;
        break;
        case RIGHT:
          rightPressed = false;
        break;
      }
  }
}

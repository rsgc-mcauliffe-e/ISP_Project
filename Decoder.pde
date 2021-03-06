class Decoder {
  int shift1;//decode shift one
  int shift2;//decode shift two
  int dshift;//the integer for how much the numbers should shift to decode the message
  int dc;//decode character one
  float dl;//length of mesage to be decoded
  String decoded;//decoded message
  String[] decode;//decode array
  float completion;//Percentage of the message decoded
  PrintWriter outputdecoded;//output the decoded text to decode.txt
  int charnum;//the placement number of the character in the message to be decoded
  int divide;//number of times that charnum can be divided
  int remainder;//remainder of divided charnum
  boolean complete;//is the program complete
  Decoder() {
    decode=loadStrings("Input/decode.txt");// load the text that is to be decoded as an array;
    outputdecoded=createWriter("Output/decoded.txt");//open the file that the decrypted text will be written to 
    shift1=(int(decode[0].charAt(0)));//convert the first character of the key to ASCII
    shift2=(int(decode[0].charAt(1)));//convert the second character of the key to ASCII
    dshift=shift1-shift2;//Calculates the shift required in the numbers to decode the text
    dl=decode[1].length();//calculates the length of the message to be decoded
    divide=(round(dl))/100;//divide the number of characters by 100
    remainder=(round(dl))%100;//find the remainder of the division above
    noStroke();
    complete=false;
  }
  void update() {
    background(255);
    stroke(0);
    fill(255);
    rect(100, 364, 800, 10);//draw static box for loading bar
    noStroke();
    fill(0);
    textSize(20);
    text("Loading...", 490, 394);//print loading on screen
    if (dl==0) {//if there is nothing to be decoded alert the user
      background(255);
      fill(250, 0, 0);
      text("ATTENTION: THERE IS NO MESSAGE TO BE DECRYPTED! PLEASE OPEN \"Input/decode.txt\" AND FOLLOW THE INSTRUCTIONS!", 12, 291, 980, 738);
      if (mouseX>197 && mouseX<801 && mouseY>8 && mouseY<34) { //if mouse is in box, invert colours of box
        textSize(15);
        textAlign(LEFT);
        fill(0);
        stroke(1);
        fill(0);
        rect(392, 8, 213, 26);
        fill(255);
        textSize(15);
        textAlign(CENTER);
        text("Press \"R\" or click to return.", 500, 25); //tell the user where to find the text output so they can copy it to the clipboard
        complete=true;
      } else {//otherwise make box white with black text
        textSize(15);
        textAlign(LEFT);
        fill(0);
        stroke(1);
        fill(255);
        rect(392, 8, 213, 26);
        fill(0);
        textSize(15);
        textAlign(CENTER);
        text("Press \"R\" or click to return.", 500, 25); //tell the user where to find the text output so they can copy it to the clipboard
      }
    } else {
      if (charnum==dl) {//if the program is fully decrypted, do this:
        cursor(ARROW);
        background(255);
        if (mouseX>197 && mouseX<801 && mouseY>8 && mouseY<34) {  //if mouse is in box, invert colours of box
          textSize(15);
          textAlign(LEFT);
          fill(0);
          stroke(1);
          fill(0);
          rect(197, 8, 604, 26);
          text(decoded, 10, 50, 980, 738);//display the decoded message on the screen
          fill(255);
          textSize(15);
          textAlign(CENTER);
          text("Encoded text is also avaliable in \"Output/Decoded.txt\". Press \"R\" or click to return.", 500, 25); //tell the user where to find the text output so they can copy it to the clipboard
          complete=true;
        } else {//otherwise make box white with black text
          textSize(15);
          textAlign(LEFT);
          fill(0);
          stroke(1);
          fill(255);
          rect(197, 8, 604, 26);
          fill(0);
          text(decoded, 10, 50, 980, 738);//display the decoded message on the screen
          textSize(15);
          textAlign(CENTER);
          text("Encoded text is also avaliable in \"Output/Decoded.txt\". Press \"R\" or click to return.", 500, 25); //tell the user where to find the text output so they can copy it to the clipboard
        }
        outputdecoded.print(decoded);//print the decoded message to the output/decoded.txt file 
        outputdecoded.flush();//ensure all data needed is written to the file
        outputdecoded.close();//close the output file
      } else {//if it is not complete, do this:
        cursor(WAIT);
        if (remainder>0) {//decode one character per screen refresh until there is no more characters left in the remainder
          fill(255);
          rect(463, 405, 53, 46);//erase the loading percentage so that we can draw over it again
          dc=int(decode[1].charAt(charnum));//converts every character to ASCII
          if (dc!=32) {//if the character is not a space, shift the ASCII codes to decrypt the message
            dc=dc+dshift;//shifts the ASCII code of each character in the message by eshift
          }
          completion=((charnum/dl)*100);//calculates how far the through the operation the program is
          fill(0);//fill to black
          rect(100, 364, (completion*8), 10);//draw the loading progress rectangle
          text(round(completion)+"%", 490, 423);//display the loading percentage on screen and round it to the nearest percentage
          //println(completion);
          if (charnum==0) {
            decoded=((char)dc)+"";//print nothing instead of "null" character on the first operation
          } else {
            decoded+=((char)dc);//otherwise print the char
          }
          charnum++; //moves to next character
          remainder--;
        } else {//decode 100 characters per screen refresh when 100 goes evenly into the number of digits left to decode
          for (int i = 0; i<100; i++) {
            fill(255);
            rect(463, 405, 53, 46);//erase the loading percentage so that we can draw over it again
            dc=int(decode[1].charAt(charnum));//converts every character to ASCII
            if (dc!=32) {//if the character is not a space, then encrypt the character
              dc=dc+dshift;//shifts the ASCII code of each character in the message by eshift
            }
            completion=((charnum/dl)*100);//calculates how far the throuugh the
            fill(0);
            rect(100, 364, (completion*8), 10);//draw the loading progress rectangle
            text(round(completion)+"%", 490, 423);//display the loading percentage on screen and round it to the nearest percentage
            //println(completion);
            if (charnum==0) {
              decoded=((char)dc)+"";//print nothing instead of "null" character on the first operation
            } else {
              decoded+=((char)dc);//otherwise print the char
            }
            charnum++; //moves to next character
          }
        }
      }
    }
  }
  boolean de_complete() {//returns if the decryption is done
    return complete;
  }
}
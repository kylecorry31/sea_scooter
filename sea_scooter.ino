#include <Servo.h>

Servo ESC;

void setup() {
  pinMode(4, INPUT_PULLUP);
  ESC.attach(10);
}

void loop() {
    if (!digitalRead(4)){
      forward(100);
    } else {
        stop();
    }
}

void calibrate(){
  ESC.writeMicroseconds(2300);
  delay(5000);
  ESC.writeMicroseconds(1100);
  delay(5000);  
}

void forward(double power){
  double microseconds = map(power, 0, 100, 1100, 2300);
  ESC.writeMicroseconds(microseconds);
}

void stop(){
  forward(0);  
}

#include <Servo.h>

Servo ESC;
int leftBtn = 3;
int rightBtn = 4;

void setup() {
  pinMode(leftBtn, INPUT_PULLUP);
  pinMode(rightBtn, INPUT_PULLUP);
  ESC.attach(10);
}

void loop() {
    bool halfPower = !digitalRead(leftBtn) ^ !digitalRead(rightBtn);
    bool fullPower = !digitalRead(leftBtn) && !digitalRead(rightBtn);
    if (fullPower){
      forward(100);
    } else if (halfPower){
      forward(50);
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

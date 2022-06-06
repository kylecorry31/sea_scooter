#include <Servo.h>

Servo ESC;
int btnPin = 4;
int escPin = 10;

int minimumMs = 1100;
int maximumMs = 2300;
int armMs = 500;
int stopMs = minimumMs;
int calibrationDelay = 5000;

int forwardSpeed = 100;

void setup()
{
  pinMode(btnPin, INPUT_PULLUP);
  ESC.attach(escPin);
  if (!digitalRead(btnPin)){
    calibrate();
  }
  arm();
}

void loop()
{
  if (!digitalRead(btnPin))
  {
    forward(forwardSpeed);
  }
  else
  {
    stop();
  }
}

void calibrate()
{
  ESC.writeMicroseconds(maximumMs);
  delay(calibrationDelay);
  ESC.writeMicroseconds(minimumMs);
  delay(calibrationDelay);
}

void arm(){
  ESC.writeMicroseconds(armMs);
}

void forward(double power)
{
  double microseconds = map(power, 0, 100, minimumMs, maximumMs);
  microseconds = constrain(microseconds, minimumMs, maximumMs);
  ESC.writeMicroseconds(microseconds);
}

void stop()
{
  ESC.writeMicroseconds(stopMs);
}

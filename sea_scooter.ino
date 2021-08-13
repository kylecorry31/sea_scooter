#include <Servo.h>

Servo ESC;
int btn = 4;

void setup()
{
  pinMode(btn, INPUT_PULLUP);
  ESC.attach(10);
}

void loop()
{
  if (!digitalRead(btn))
  {
    forward(100);
  }
  else
  {
    stop();
  }
}

void calibrate()
{
  ESC.writeMicroseconds(2300);
  delay(5000);
  ESC.writeMicroseconds(1100);
  delay(5000);
}

void forward(double power)
{
  double microseconds = map(power, 0, 100, 1100, 2300);
  ESC.writeMicroseconds(microseconds);
}

void stop()
{
  forward(0);
}

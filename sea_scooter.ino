#include <Servo.h>

#define MINIMUM_MS 1100
#define MAXIMUM_MS 2300
#define ARM_MS 500
#define CALIBRATION_DELAY_MS 5000
#define SPEED 100
#define BTN_PIN 4
#define ESC_PIN 10

Servo ESC;

void setup()
{
  pinMode(BTN_PIN, INPUT_PULLUP);
  ESC.attach(ESC_PIN);
  if (is_pressed()){
    calibrate();
  }
  arm();
}

void loop()
{
  if (is_pressed())
  {
    spin(SPEED);
  }
  else
  {
    spin(0);
  }
}

bool is_pressed()
{
  return !digitalRead(BTN_PIN);
}

void calibrate()
{
  ESC.writeMicroseconds(MAXIMUM_MS);
  delay(CALIBRATION_DELAY_MS);
  ESC.writeMicroseconds(MINIMUM_MS);
  delay(CALIBRATION_DELAY_MS);
}

void arm(){
  ESC.writeMicroseconds(ARM_MS);
}

void spin(double power)
{
  double microseconds = map(power, 0, 100, MINIMUM_MS, MAXIMUM_MS);
  microseconds = constrain(microseconds, MINIMUM_MS, MAXIMUM_MS);
  ESC.writeMicroseconds(microseconds);
}

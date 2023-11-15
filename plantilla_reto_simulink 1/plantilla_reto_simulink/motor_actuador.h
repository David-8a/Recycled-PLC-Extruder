double motor = 0;

void setup_motor(){
  pinMode(PIN_MOTOR_A, OUTPUT);
  pinMode(PIN_MOTOR_B, OUTPUT);
}

float actuar_motor(double val) {
  motor = 0;
  if(val > 0){
    motor = constrain(val,0,255);
    analogWrite(PIN_MOTOR_A,0);
    analogWrite(PIN_MOTOR_B,(int)motor);
  }else if(val < 0){
    motor = constrain(val,-255,0);
    analogWrite(PIN_MOTOR_A,(int)-motor);
    analogWrite(PIN_MOTOR_B,0); 
  }else{
    analogWrite(PIN_MOTOR_A,0);
    analogWrite(PIN_MOTOR_B,0);
  }
  return motor;
}

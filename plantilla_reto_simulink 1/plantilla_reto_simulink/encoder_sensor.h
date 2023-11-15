volatile long encoder = 0;
volatile bool stateA;
volatile bool stateB;

void encoderA() {
  stateA = PIND & B00000100;
  stateB = PIND & B00001000;
  if(stateA != stateB) encoder++;
  if(stateA == stateB) encoder--;
}

void encoderB() {
  stateA = PIND & B00000100;
  stateB = PIND & B00001000;
  if(stateA != stateB) encoder--;
  if(stateA == stateB) encoder++;
}

void setup_encoder() {
  pinMode(PIN_A, INPUT);
  pinMode(PIN_B, INPUT);
  
  attachInterrupt(digitalPinToInterrupt(PIN_A), encoderA, CHANGE);
  attachInterrupt(digitalPinToInterrupt(PIN_B), encoderB, CHANGE);  
}

double medir_encoder(){
  return (double) encoder;
}

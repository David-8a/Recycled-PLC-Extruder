void setup_resistencia(){
  pinMode(PIN_RESISTENCIA, OUTPUT);
}

void actuar_resistencia(double val){
  analogWrite(PIN_RESISTENCIA, val);
}

#include "configuracion.h"
#include "termistor_sensor.h"
#include "encoder_sensor.h"
#include "motor_actuador.h"
#include "resistencia_actuador.h"
#include "comunicacion.h"

void setup() {
  Serial.begin(115200);
  setup_encoder();
  setup_motor();
  setup_resistencia();
}

void loop() {
  outputs[0].number = medir_encoder();
  outputs[1].number = medir_temperatura();
  
  comunicacion();
  
  actuar_motor(inputs[0].number);
  actuar_resistencia(inputs[1].number);
}

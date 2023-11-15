#define TS 50000
#define NUM_INPUTS  2
#define NUM_OUTPUTS 2

typedef union {
  float number;
  uint8_t bytes[4];
} FLOATUNION_t;

float getFloat() {
  int cont = 0;
  FLOATUNION_t f;
  while (cont < 4 ) {
    f.bytes[cont] = Serial.read() ;
    cont = cont + 1;
  }
  return f.number;
}

FLOATUNION_t outputs[NUM_OUTPUTS];
FLOATUNION_t inputs[NUM_INPUTS];

unsigned long cTimeLast = 0;

void comunicacion() {
  if (micros() - cTimeLast > TS) {
    cTimeLast += TS;

    for(int i=0; i<NUM_INPUTS; i++){
      inputs[i].number = getFloat(); // Give your float a value
    }

    // Print header: Important to avoid sync errors!
    Serial.write('A');

    // Print float data
    for(int o=0; o<NUM_OUTPUTS; o++){
      for (int i = 0; i < 4; i++) {
        Serial.write(outputs[o].bytes[i]);
      }
    }

    // Print terminator
    Serial.print('\n');
  }
}

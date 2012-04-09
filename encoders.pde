void initEncoders()
{
  pinMode(LEFT_ENCODER_PIN_B, INPUT);
  pinMode(RIGHT_ENCODER_PIN_B, INPUT);
  
  attachInterrupt(LEFT_ENCODER_PIN_B, leftEncoderHandlerA, RISING); 
  attachInterrupt(RIGHT_ENCODER_PIN_B, rightEncoderHandlerA, RISING);
}

void leftEncoderHandlerA()
{
  g_robotState.leftEncoder++;
}
void rightEncoderHandlerA()
{
  g_robotState.rightEncoder++;
}

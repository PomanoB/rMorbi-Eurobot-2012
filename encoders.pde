
void initEncoders()
{
  pinMode(LEFT_ENCODER_PIN, INPUT);
  pinMode(RIGHT_ENCODER_PIN, INPUT);
  
  attachInterrupt(LEFT_ENCODER_PIN, leftEncoderHandler, RISING); 
  attachInterrupt(RIGHT_ENCODER_PIN, rightEncoderHandler, RISING);
}

void leftEncoderHandler()
{
  g_robotState.leftEncoder++;
}
void rightEncoderHandler()
{
  g_robotState.rightEncoder++;
}

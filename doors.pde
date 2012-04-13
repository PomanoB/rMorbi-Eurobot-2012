Servo g_leftDoor, g_rightDoor;

void initDoors()
{
  g_leftDoor.attach(LEFT_DOOR_PIN);
  g_rightDoor.attach(RIGHT_DOOR_PIN);
}

void inline closeLeftDoor()
{
  g_leftDoor.writeMicroseconds(2100);
}
void inline openLeftDoor()
{
  g_leftDoor.writeMicroseconds(500);  
}

void inline halfOpenLeftDoor()
{
  g_leftDoor.writeMicroseconds(1500);  
}
void inline closeRightDoor()
{
  g_rightDoor.writeMicroseconds(900);
}
void inline openRightDoor()
{
  g_rightDoor.writeMicroseconds(2400);  //2400
}
void inline halfOpenRightDoor()
{
  g_rightDoor.writeMicroseconds(1800);  
}

Servo g_leftDoor, g_rightDoor;

void initDoors()
{
  g_leftDoor.attach(LEFT_DOOR_PIN, LEFT_DOOR_MIN_PW, LEFT_DOOR_MAX_PW);
  g_leftDoor.attach(RIGHT_DOOR_PIN, RIGHT_DOOR_MIN_PW, RIGHT_DOOR_MAX_PW);
}
void inline closeDoors()
{
  closeLeftDoor();
  closeRightDoor();
}
void inline openDoors()
{
  openLeftDoor();
  openRightDoor();
}
void inline closeLeftDoor()
{
  g_leftDoor.write(0);
}
void inline openLeftDoor()
{
  g_leftDoor.write(180);  
}
void inline closeRightDoor()
{
  g_rightDoor.write(0);
}
void inline openRightDoor()
{
  g_rightDoor.write(180);  
}

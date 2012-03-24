void inline addPlane(int l, uint8 s, uint8 c, uint8 g, uint8 t)
{
  g_robotState.lastAddedPlane++;
  
  g_robotState.planes[g_robotState.lastAddedPlane].len = l;
  g_robotState.planes[g_robotState.lastAddedPlane].speed = s;
  g_robotState.planes[g_robotState.lastAddedPlane].condition = c;
  g_robotState.planes[g_robotState.lastAddedPlane].goTo = g;
  g_robotState.planes[g_robotState.lastAddedPlane].type = t;
}

void inline moveForward(int len)
{
  addPlane(len, 0xFF, COND_NONE, 0, MOVE_FORWARD);
}
void inline moveBackward(int len)
{
  addPlane(len, 0xFF, COND_NONE, 0, MOVE_BACKWARD);
}
void inline turnLeft(int len)
{
  addPlane(len, 0xFF, COND_NONE, 0, TURN_LEFT);   
}
void inline turnRight(int len)
{
  addPlane(len, 0xFF, COND_NONE, 0, TURN_RIGHT);   
}
void inline openDoor()
{
  addPlane(OPEN_DOOR_TIME, 0xFF, COND_NONE, 0, OPEN_DOOR);
}
void inline closeDoor()
{
  addPlane(CLOSE_DOOR_TIME, 0xFF, COND_NONE, 0, CLOSE_DOOR);
}

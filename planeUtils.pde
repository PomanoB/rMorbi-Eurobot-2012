void inline addPlane(int l, uint8 s, uint8 t)
{
  g_robotState.lastAddedPlane++;
  
  g_robotState.planes[g_robotState.lastAddedPlane].len = l;
  g_robotState.planes[g_robotState.lastAddedPlane].speed = s;
  g_robotState.planes[g_robotState.lastAddedPlane].type = t;
}

void inline moveForward(int len)
{
  addPlane(len, 0xFF, MOVE_FORWARD);
}
void inline moveBackward(int len)
{
  addPlane(len, 0xFF, MOVE_BACKWARD);
}
void inline turnLeft(int len)
{
  addPlane(len, 0xFF, TURN_LEFT);   
}
void inline turnRight(int len)
{
  addPlane(len, 0xFF, TURN_RIGHT);   
}
void inline openDoor()
{
  addPlane(OPEN_DOOR_TIME, 0xFF, OPEN_DOORS);
}
void inline closeDoor()
{
  addPlane(CLOSE_DOOR_TIME, 0xFF, CLOSE_DOORS);
}
void inline goToPlane(uint8 n)
{
  addPlane(COND_GO_TO, n, CONDITION);
}

void wait(int t)
{
  addPlane(t, 0xFF, WAIT);
}

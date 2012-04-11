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
void inline openLeft()
{
  addPlane(1, 0xFF, OPEN_LEFT_DOOR);
}
void inline openRight()
{
  addPlane(1, 0xFF, OPEN_RIGHT_DOOR);
}
void inline closeLeft()
{
  addPlane(1, 0xFF, CLOSE_LEFT_DOOR);
}
void inline closeRight()
{
  addPlane(1, 0xFF, CLOSE_RIGHT_DOOR);
}
void inline halfLeft()
{
  addPlane(1, 0xFF, HALF_LEFT_DOOR);
}
void inline halfRight()
{
  addPlane(1, 0xFF, HALF_RIGHT_DOOR);
}

void inline goToPlane(uint8 n)
{
  addPlane(COND_GO_TO, n, CONDITION);
}

void wait(int t)
{
  addPlane(t, 0xFF, WAIT);
}

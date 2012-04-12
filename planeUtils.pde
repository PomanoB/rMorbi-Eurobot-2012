int inline addPlane(int l, uint8 s, uint8 t)
{
  g_robotState.lastAddedPlane++;
  
  g_robotState.planes[g_robotState.lastAddedPlane].len = l;
  g_robotState.planes[g_robotState.lastAddedPlane].speed = s;
  g_robotState.planes[g_robotState.lastAddedPlane].type = t;
  
  return g_robotState.lastAddedPlane;
}

int inline moveForward(int len)
{
  return addPlane(len, 0xFF, MOVE_FORWARD);
}
int inline moveBackward(int len)
{
  return addPlane(len, 0xFF, MOVE_BACKWARD);
}
int inline turnLeft(int len)
{
  return addPlane(len, 0xFF, TURN_LEFT);   
}
int inline turnRight(int len)
{
  return addPlane(len, 0xFF, TURN_RIGHT);   
}
int inline openLeft()
{
  return addPlane(1, 0xFF, OPEN_LEFT_DOOR);
}
int inline openRight()
{
  return addPlane(1, 0xFF, OPEN_RIGHT_DOOR);
}
int inline closeLeft()
{
  return addPlane(1, 0xFF, CLOSE_LEFT_DOOR);
}
int inline closeRight()
{
  return addPlane(1, 0xFF, CLOSE_RIGHT_DOOR);
}
int inline halfLeft()
{
  return addPlane(1, 0xFF, HALF_LEFT_DOOR);
}
int inline halfRight()
{
  return addPlane(1, 0xFF, HALF_RIGHT_DOOR);
}

int inline goToPlane(uint8 n)
{
  return addPlane(COND_GO_TO, n, CONDITION);
}

int wait(int t)
{
  return addPlane(t, 0xFF, WAIT);
}

int inline backCollide()
{
  return addPlane(1, 0xFF, BACK_COLLISION); 
}

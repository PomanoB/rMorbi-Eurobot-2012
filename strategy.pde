
void setLeftStrategy()
{
  moveForward(SM(56));
  turnLeft(DEG(100));
  openRight();
  moveForward(SM(60));
  closeRight();
  moveForward(SM(63));
  turnRight(DEG(95));
  openRight();
  openLeft();
  moveForward(SM(65));
  turnRight(DEG(100));
  wait(3000); 
}

void setRightStrategy()
{
  
}

void invertStrategy()
{
  int i;
  for(i = 0; i < g_robotState.lastAddedPlane; i++)
  {
    switch(g_robotState.planes[i].type)
    {
      case TURN_LEFT:
        g_robotState.planes[i].type = TURN_RIGHT;
        break;
      case TURN_RIGHT:
        g_robotState.planes[i].type = TURN_LEFT;
        break;
        
      case OPEN_LEFT_DOOR:
        g_robotState.planes[i].type = OPEN_RIGHT_DOOR;
        break;
      case OPEN_RIGHT_DOOR:
        g_robotState.planes[i].type = OPEN_LEFT_DOOR;
        break;
        
      
      case CLOSE_LEFT_DOOR:
        g_robotState.planes[i].type = CLOSE_RIGHT_DOOR;
        break;
      case CLOSE_RIGHT_DOOR:
        g_robotState.planes[i].type = CLOSE_LEFT_DOOR;
        break;
        
      
      case HALF_RIGHT_DOOR:
        g_robotState.planes[i].type = HALF_LEFT_DOOR;
        break;
      case HALF_LEFT_DOOR:
        g_robotState.planes[i].type = HALF_RIGHT_DOOR;
        break;
    }
  }
}

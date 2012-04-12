
void setLeftStrategy()
{
  moveForward(SM(56));
  turnLeft(DEG(101));
//  moveBackward(SM(37));
  openRight();
  moveForward(SM(123)); // 123
  
  closeRight();
  turnRight(DEG(97));
  openLeft();
  openRight();
  moveForward(SM(65));
  closeRight();
  turnRight(DEG(195));
  
  moveForward(SM(65));
  wait(3000); 
}

void setRightStrategy()
{
  moveForward(SM(76));
  turnRight(DEG(54));
  openLeft();
  moveForward(SM(143)); // 123
  
  closeLeft();
  turnLeft(DEG(48));
  openRight();
  openLeft();
  moveForward(SM(83));
  turnLeft(DEG(54));
  
  moveBackward(SM(10));
  
  wait(1000); 
}

void invertStrategy()
{
  int i;
  for(i = 0; i <= g_robotState.lastAddedPlane; i++)
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

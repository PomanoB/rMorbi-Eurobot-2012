
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
  moveForward(SM(56));
  turnRight(DEG(110));
  openLeft();
  moveForward(SM(123)); // 123
  
  closeLeft();
  turnLeft(DEG(115));
  openRight();
  openLeft();
  wait(500);
  closeLeft();
  wait(500);
  moveForward(SM(10));
  wait(500); 
  turnLeft(DEG(195));
  
  moveForward(SM(65));
  wait(500); 
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

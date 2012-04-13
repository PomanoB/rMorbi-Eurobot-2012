
void setLeftStrategy()
{
  
//  backCollide();
  
  return;
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
  moveForward(SM(62));
  turnLeft(DEG(52));      //49
  moveBackward(SM(150));
  backCollide();
  moveForward(SM(110));
  turnRight(DEG(52));
  moveBackward(SM(30));
  return;
  
  /*
  moveForward(SM(30));
  backCollide();
  moveForward(SM(30));
  return;
  */
  moveForward(SM(75));
  turnRight(DEG(51));
//  backCollide();
  openLeft();
  moveForward(SM(127)); // 123
  
  openLeft();
  turnLeft(DEG(47));
  openRight();
  openLeft();
  moveForward(SM(83));
  
  closeRight();
  closeLeft();
  turnLeft(DEG(54));
  moveBackward(SM(10));
  openRight();
  openLeft();
  
  moveForward(SM(30));
  
  closeLeft();
  closeRight();
  turnLeft(DEG(47));
  
  moveForward(SM(75));
  turnRight(DEG(47));
  moveForward(SM(90));
  turnLeft(DEG(47));
  moveForward(SM(30));
  openRight();
  openLeft();
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

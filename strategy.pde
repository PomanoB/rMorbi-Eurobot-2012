
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
  /*
  moveForward(SM(60));
  turnLeft(DEG(49));      //49
  moveBackward(SM(150));
  backCollide();
  moveForward(SM(110));
  turnLeft(DEG(52));
  moveForward(SM(15));
  return;
  */
  
  moveForward(SM(79));
  turnRight(DEG(51));
  
  backCollide();
  
  halfLeft();
  moveForward(SM(164)); // 123
  
  turnLeft(DEG(50)); // ---------------------------- choose?
  
  /*
  closeLeft();
  moveForward(SM(30));
  
  turnLeft(DEG(54));
  
  openRight();
  openLeft();
  
  moveForward(SM(29));
    
  closeRight();
  closeLeft();
  */


 // turn left
  halfRight();
  openLeft();
  
  moveForward(SM(85));
  
  closeRight();
  closeLeft();
  moveForward(SM(28));
  
  turnLeft(DEG(54));
  backCollide();
  
  halfRight();
  halfLeft();
  
  moveForward(SM(55));
  turnLeft(DEG(53));
  moveBackward(SM(7));
//  halfRight();
  openLeft();
  
  moveForward(SM(135)); //50 
//  halfRight();
//  closeLeft();
//  moveForward(SM(82));
  turnRight(DEG(53));
  closeRight();
  closeLeft();
  backCollide();
  
 // openRight();
//  openLeft();
  
  
  moveForward(SM(100));
  turnLeft(DEG(56));
  moveForward(SM(40));
  openLeft();
  openRight();
  
  moveBackward(SM(40));
  /* ---- */
  
 // return;
  
  turnLeft(DEG(56));
  backCollide();
  halfLeft();
  halfRight();
  
  
  
  moveForward(SM(55));
  turnLeft(DEG(53));
  moveBackward(SM(7));
//  halfRight();
  openLeft();
  
  moveForward(SM(132)); //50 
//  halfRight();
//  closeLeft();
//  moveForward(SM(82));
  turnRight(DEG(53));
  closeRight();
  closeLeft();
  backCollide();
  
  moveForward(SM(100));
  turnLeft(DEG(56));
  moveForward(SM(40));
  openLeft();
  openRight();
  
  moveBackward(SM(40));
    
  
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

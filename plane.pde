void inline setCurPlane()
{
  /*
  while(g_robotState.currPlane < PLANE_COUNT && g_robotState.planes[g_robotState.currPlane].len <= 0)
  {
    g_robotState.currPlane++;
  }
  */
  if (g_robotState.planes[g_robotState.currPlane].type == CONDITION)
  {
    switch(g_robotState.planes[g_robotState.currPlane].len)
    {
      case COND_GO_TO:
        g_robotState.currPlane = g_robotState.planes[g_robotState.currPlane].speed;
        break;
      default:
        g_robotState.currPlane++;
    }
  }
  else
    g_robotState.currPlane++;
    
  if (g_robotState.currPlane < PLANE_COUNT)
  {
    g_robotState.currLen = 0;
  //  stopEngines();
    setPlaneOutput();
  }
  else
  {
    shutDown();
 //   SerialUSB.println("END!!!!");
  }
  toggleLED();
  g_robotState.leftEncoder = g_robotState.rightEncoder = 0;
}

bool checkComplete()
{
  if (g_robotState.currPlane >= PLANE_COUNT)
    return true;
    
  if (g_robotState.currLen >= g_robotState.planes[g_robotState.currPlane].len)   
  {
 //   stopEngines();
    setCurPlane();
    return true;
  }
  return false;
}

void updatePlane()
{
  switch(g_robotState.planes[g_robotState.currPlane].type)
  {
    case MOVE_FORWARD:
    case MOVE_BACKWARD:
      if (g_robotState.leftEncoder > g_robotState.rightEncoder)
        g_robotState.currLen += g_robotState.leftEncoder;
      else
        g_robotState.currLen += g_robotState.rightEncoder;
      break;
    
    case TURN_LEFT:
        g_robotState.currLen += g_robotState.rightEncoder;
        break;
    
    case TURN_RIGHT:
        g_robotState.currLen += g_robotState.leftEncoder;
        break;
        
    case WAIT:
      g_robotState.currLen = millis() - g_robotState.startPlaneTime;
      break;
    
    case OPEN_LEFT_DOOR:   
    case OPEN_RIGHT_DOOR:
    case CLOSE_LEFT_DOOR:   
    case CLOSE_RIGHT_DOOR:  
    case HALF_LEFT_DOOR:   
    case HALF_RIGHT_DOOR:
      g_robotState.currLen ++;
      break;
      
 //   default:
 //     g_robotState.currLen++;
  }
}

void setPlaneOutput()
{
  g_robotState.startPlaneTime = millis();
  switch(g_robotState.planes[g_robotState.currPlane].type)
  {
   case WAIT:
 //     g_robotState.startPlaneTime = millis();
       break; 
    case MOVE_FORWARD:
      leftEngineForward();
      rightEngineForward();
      break; 
    case MOVE_BACKWARD:
      leftEngineBackward();
      rightEngineBackward();
      break;
    case TURN_LEFT:
   //   leftEngineStop();
      leftEngineBackward();
      rightEngineForward();
      break;
    case TURN_RIGHT:
//      rightEngineStop();
      rightEngineBackward();
      leftEngineForward();
      break;
    case OPEN_LEFT_DOOR:
      openLeftDoor();
      break;
    case OPEN_RIGHT_DOOR:
      openRightDoor();
      break;
    case CLOSE_LEFT_DOOR:
      closeLeftDoor();
      break;
    case CLOSE_RIGHT_DOOR:
      closeRightDoor();
      break;
    case HALF_LEFT_DOOR:
      halfOpenLeftDoor();
      break;
    case HALF_RIGHT_DOOR:
      halfOpenRightDoor();
      break;    
  }
}


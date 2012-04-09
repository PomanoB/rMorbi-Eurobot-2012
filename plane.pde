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
    RESET_FLAG(ALLOW_WORK);
    stopEngines();
 //   SerialUSB.println("END!!!!");
  }
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
      leftEngineStop();
      rightEngineForward();
      break;
    case TURN_RIGHT:
      rightEngineStop();
      leftEngineForward();
      break;
    case OPEN_LEFT_DOOR:
      openLeftDoor();
      break;    
  }
}


void inline setCurPlane()
{
  while(g_robotState.currPlane < PLANE_COUNT && g_robotState.planes[g_robotState.currPlane].len <= 0)
  {
    g_robotState.currPlane++;
  }
  if (g_robotState.planes[g_robotState.currPlane].type == CONDITION)
  {
    SerialUSB.print("Chek condition ");
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
    
    setPlaneOutput();
    
    SerialUSB.print("Current plane switching to "); 
    SerialUSB.print(g_robotState.currPlane);
    SerialUSB.println();
  }
  else
  {
    RESET_FLAG(ALLOW_WORK);
    SerialUSB.println("END!!!!");
  }
}

bool checkComplete()
{
  if (g_robotState.currPlane >= PLANE_COUNT)
    return true;
    
  if (g_robotState.currLen >= g_robotState.planes[g_robotState.currPlane].len)   
  {
    setCurPlane();
    return true;
  }
  return false;
}

void updatePlane()
{
  switch(g_robotState.planes[g_robotState.currPlane].type)
  {
    case WAIT:
      g_robotState.currLen = millis() - g_robotState.startPlaneTime;
      break;
    default:
      g_robotState.currLen++;
  }
}

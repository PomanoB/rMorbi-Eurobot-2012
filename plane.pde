void inline setCurPlane()
{
  if (g_robotState.currPlane < PLANE_COUNT)
  {
    g_robotState.currLen = 0;
    SerialUSB.print("Current plane switching to"); 
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
    switch(g_robotState.planes[g_robotState.currPlane].condition)
    {
      case COND_GO_TO:
        g_robotState.currPlane = g_robotState.planes[g_robotState.currPlane].goTo;
        break;
      default:
        g_robotState.currPlane++;
    }
    setCurPlane();
    return true;
  }
  return false;
}

void updatePlane()
{
  g_robotState.currLen++; 
}

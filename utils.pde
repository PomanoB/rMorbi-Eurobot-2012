void resetState()
{
    g_robotState.leftEncoder = 0;
    g_robotState.rightEncoder = 0;
    g_robotState.leftPWM = 0;
    g_robotState.rightPWM = 0;
    g_robotState.corrector = 0;
    
    g_robotState.currPlane = 0;
    g_robotState.currLen = 0;
    g_robotState.lastAddedPlane = -1;
    g_robotState.startPlaneTime = 0;    
    
    g_robotState.startTime = 0;
    
    RESET_FLAG(ALLOW_WORK);
    RESET_FLAG(COLLISION);
    RESET_FLAG(ENGINE_STOPED);
    
    for(int i = 0; i < PLANE_COUNT; i++)
    {
      g_robotState.planes[i].len = 0;
      g_robotState.planes[i].speed = 0;
      g_robotState.planes[i].type = DO_NOTHING;
    }
}


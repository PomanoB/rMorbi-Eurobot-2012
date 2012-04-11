inline int changeToVal(int val, int toVal, int dec)
{
  if (val < toVal) 
    return incToMax(val, toVal, dec);
  else  
    return decToMin(val, toVal, dec);
}

inline int incToMax(int val, int maxVal, int dec)
{
  if (val < maxVal)
    val += dec;
  if (val > maxVal)
    val = maxVal;
  
  return val;
}
inline int decToMin(int val, int minVal, int dec)
{
  if (val > minVal)
    val -= dec;
  if (val < minVal)
    val = minVal;
  
  return val;
}

void resetState()
{
    g_robotState.leftEncoder = 0;
    g_robotState.rightEncoder = 0;
    g_robotState.leftPWM = 0;
    g_robotState.rightPWM = 0;
    g_robotState.corrector = 0;
    g_robotState.dontMoveTicks = 0;
    g_robotState.minPwm = 3500;
    
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

void initRedButton()
{
   pinMode(RED_BUTTON_PIN, INPUT_PULLUP);
   
   attachInterrupt(RED_BUTTON_PIN, redButtonPressed, FALLING);
}

void redButtonPressed()
{
  shutDown(); 
}

void shutDown()
{
  noInterrupts();
  
  RESET_FLAG(ALLOW_WORK);
  stopEngines();
  
  g_leftDoor.detach();
  g_rightDoor.detach();
}

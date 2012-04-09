void engineCorrectorNone()
{
  g_robotState.leftEncoder = g_robotState.rightEncoder = 0;
  /*
  switch(g_robotState.planes[g_robotState.currPlane].type)
  {
    case MOVE_FORWARD:
    case MOVE_BACKWARD:
    case 
  */    
}

void initEngineTimer(int period)
{
  g_engineTimer.pause();
  g_engineTimer.setPeriod(period);
  
  g_engineTimer.setMode(1, TIMER_OUTPUT_COMPARE);
  g_engineTimer.setCompare(TIMER_CH1, 1);
  
  g_engineTimer.attachInterrupt(1, engineTimerHandler);
  
  g_engineTimer.refresh();
  g_engineTimer.resume();
}

void engineTimerHandler()
{
  if (GET_FLAG(COLLISION))
    return;
    
  if (GET_FLAG(ENGINE_STOPED))
    setPlaneOutput();
  
  if (!checkComplete())
  {
    updatePlane();
    if (g_robotState.corrector)
     g_robotState.corrector();   
  } 

}

void stopEngines()
{
  SET_FLAG(ENGINE_STOPED);
  rightEngineStop();
  leftEngineStop(); 
}

void initEngines()
{
  // Set engines pins to otput
  pinMode(LEFT_ENGINE_A, OUTPUT);
  pinMode(LEFT_ENGINE_B, OUTPUT);
  pinMode(LEFT_ENGINE_E, OUTPUT);
  pinMode(RIGHT_ENGINE_A, OUTPUT);  
  pinMode(RIGHT_ENGINE_B, OUTPUT);
  pinMode(RIGHT_ENGINE_E, OUTPUT);
  
  digitalWrite(LEFT_ENGINE_A, LOW);
  digitalWrite(LEFT_ENGINE_B, HIGH);
  digitalWrite(LEFT_ENGINE_E, LOW);
  
  digitalWrite(RIGHT_ENGINE_A, LOW);
  digitalWrite(RIGHT_ENGINE_B, HIGH);
  digitalWrite(RIGHT_ENGINE_E, LOW);
}

inline void leftEngineForward()
{
  digitalWrite(LEFT_ENGINE_A, LOW);
  digitalWrite(LEFT_ENGINE_B, HIGH);
  digitalWrite(LEFT_ENGINE_E, HIGH);
}
inline void rightEngineForward()
{
  digitalWrite(RIGHT_ENGINE_A, LOW);
  digitalWrite(RIGHT_ENGINE_B, HIGH);
  digitalWrite(RIGHT_ENGINE_E, HIGH);  
}

inline void leftEngineBackward()
{
  digitalWrite(LEFT_ENGINE_A, HIGH);
  digitalWrite(LEFT_ENGINE_B, LOW);
  digitalWrite(LEFT_ENGINE_E, HIGH);
}
inline void rightEngineBackward()
{
  digitalWrite(RIGHT_ENGINE_A, HIGH);
  digitalWrite(RIGHT_ENGINE_B, LOW);
  digitalWrite(RIGHT_ENGINE_E, HIGH);
}
inline void rightEngineStop()
{
  digitalWrite(RIGHT_ENGINE_E, LOW);
}
inline void leftEngineStop()
{
  digitalWrite(LEFT_ENGINE_E, LOW);
}

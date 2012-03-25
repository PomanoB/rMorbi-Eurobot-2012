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
  SerialUSB.println("Engine timer interrupt");
  
  if (isCollision())
  {
    stopEngines();
    return;
  }
  else if (GET_FLAG(ENGINE_STOPED))
    setPlaneOutput();
  
  if (!checkComplete())
  {
    updatePlane();
    
  } 

}

void stopEngines()
{
  SET_FLAG(ENGINE_STOPED);
  SerialUSB.println("Stop engines");
 
}
void setPlaneOutput()
{
}

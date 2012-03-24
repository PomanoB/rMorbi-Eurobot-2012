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
 
  if (!checkComplete())
  {
    updatePlane();
    
  } 

}

void stopEngines()
{
   SerialUSB.println("Stop engines");
   
}

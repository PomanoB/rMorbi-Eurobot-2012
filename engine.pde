void engineCorrectorNone()
{
  if (GET_FLAG(ENGINE_STOPED))
  {
    g_robotState.leftPWM = decToMin(g_robotState.leftPWM, 0, 1000);
    g_robotState.rightPWM = decToMin(g_robotState.rightPWM, 0, 1000);    
  }
  else
  {
    switch(g_robotState.planes[g_robotState.currPlane].type)
    {
      case MOVE_FORWARD:
      case MOVE_BACKWARD:
        g_robotState.leftPWM = incToMax(g_robotState.leftPWM, 65535, 1000);
        g_robotState.rightPWM = incToMax(g_robotState.rightPWM, 65535, 1000);
        
        if (g_robotState.leftEncoder > g_robotState.rightEncoder)
        {
        //  g_robotState.leftPWM = decToMin(g_robotState.leftPWM, 0, 10000);
          if (g_robotState.rightEncoder == 65535)
            g_robotState.leftPWM = decToMin(g_robotState.leftPWM, 0, 1000);
          else
            g_robotState.rightPWM = incToMax(g_robotState.rightPWM, 65535, 1000);
        }
        else
        if (g_robotState.rightPWM > g_robotState.leftEncoder)
        {
          if (g_robotState.leftEncoder == 65535)
            g_robotState.rightPWM = decToMin(g_robotState.rightPWM, 0, 1000);
          else
            g_robotState.leftEncoder = incToMax(g_robotState.leftEncoder, 65535, 1000);
        }
        
        break;
    
      case TURN_LEFT:
        g_robotState.leftPWM = decToMin(g_robotState.leftPWM, 0, 1000);
        g_robotState.rightPWM = incToMax(g_robotState.rightPWM, 65535, 1000);  
        break;
      
      case TURN_RIGHT:
        g_robotState.leftPWM = decToMin(g_robotState.leftPWM, 0, 1000);
        g_robotState.rightPWM = incToMax(g_robotState.rightPWM, 65535, 1000);  
        break;
      default:
        
        if (g_robotState.leftPWM > g_robotState.rightPWM)
        {
          g_robotState.leftPWM = g_robotState.rightPWM = decToMin(g_robotState.leftPWM, 0, 1000);
        }//  g_robotState.leftPWM = g_robotState.rightPWM = decToMin(g_robotState.leftPWM, 0, 1000);
        else
          g_robotState.leftPWM = g_robotState.rightPWM = decToMin(g_robotState.rightPWM, 0, 1000);
       
       //   g_robotState.rightPWM = decToMin(g_robotState.rightPWM, 0, 1000);
        //  g_robotState.leftPWM = g_robotState.rightPWM = decToMin(g_robotState.rightPWM, 0, 1000);
//        g_robotState.rightPWM = decToMin(g_robotState.rightPWM, 0, 1000);
    }
  }
  
  pwmWrite(LEFT_ENGINE_E, g_robotState.leftPWM);  
  pwmWrite(RIGHT_ENGINE_E, g_robotState.rightPWM);
  
  g_robotState.leftEncoder = g_robotState.rightEncoder = 0;   
}

void initEngineTimer(int period)
{
  g_engineTimer.pause();
  g_engineTimer.setPeriod(period);
  
  g_engineTimer.setMode(TIMER_CH1, TIMER_OUTPUT_COMPARE);
  g_engineTimer.setCompare(TIMER_CH1, 1);
  
  g_engineTimer.attachInterrupt(TIMER_CH1, engineTimerHandler);
  
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
    engineCorrectorNone();
 //   if (g_robotState.corrector)
 //    g_robotState.corrector();   
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
  pinMode(LEFT_ENGINE_E, PWM);
  pinMode(RIGHT_ENGINE_A, OUTPUT);  
  pinMode(RIGHT_ENGINE_B, OUTPUT);
  pinMode(RIGHT_ENGINE_E, PWM);
  
  digitalWrite(LEFT_ENGINE_A, LOW);
  digitalWrite(LEFT_ENGINE_B, HIGH);
//  digitalWrite(LEFT_ENGINE_E, LOW);
  pwmWrite(LEFT_ENGINE_E, 0);
  
  digitalWrite(RIGHT_ENGINE_A, LOW);
  digitalWrite(RIGHT_ENGINE_B, HIGH);
//  digitalWrite(RIGHT_ENGINE_E, LOW);
  pwmWrite(RIGHT_ENGINE_E, 0);
}

inline void leftEngineForward()
{
  digitalWrite(LEFT_ENGINE_A, LOW);
  digitalWrite(LEFT_ENGINE_B, HIGH);
 // digitalWrite(LEFT_ENGINE_E, HIGH);
//  pwmWrite(LEFT_ENGINE_E, 65535);
}
inline void rightEngineForward()
{
  digitalWrite(RIGHT_ENGINE_A, LOW);
  digitalWrite(RIGHT_ENGINE_B, HIGH);
//  digitalWrite(RIGHT_ENGINE_E, HIGH);  
//  pwmWrite(RIGHT_ENGINE_E, 65535);
}

inline void leftEngineBackward()
{
  digitalWrite(LEFT_ENGINE_A, HIGH);
  digitalWrite(LEFT_ENGINE_B, LOW);
//  digitalWrite(LEFT_ENGINE_E, HIGH);
//  pwmWrite(LEFT_ENGINE_E, 65535);
}
inline void rightEngineBackward()
{
  digitalWrite(RIGHT_ENGINE_A, HIGH);
  digitalWrite(RIGHT_ENGINE_B, LOW);
//  digitalWrite(RIGHT_ENGINE_E, HIGH);
//  pwmWrite(RIGHT_ENGINE_E, 65535);
}
inline void rightEngineStop()
{
//  digitalWrite(RIGHT_ENGINE_E, LOW);
  pwmWrite(RIGHT_ENGINE_E, 0);
}
inline void leftEngineStop()
{
//  digitalWrite(LEFT_ENGINE_E, LOW);
  pwmWrite(LEFT_ENGINE_E, 0);
}
